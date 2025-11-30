package ui

import (
	"fmt"
	"os"
	"os/exec"
	"sort"
	"strings"
	"time"

	"github.com/charmbracelet/bubbles/progress"
	tea "github.com/charmbracelet/bubbletea"
)

type (
	outputMsg     string
	tickMsg       time.Time
	finalPauseMsg struct{}
)

func getSelectedItems(m Model) []string {
	items := []string{}
	for name, sel := range m.selected {
		if sel {
			if strings.HasPrefix(name, "Tout") {
				continue
			}
			items = append(items, name)
		}
	}
	sort.Strings(items)
	return items
}

func appendLog(path, text string) error {
	f, err := os.OpenFile(path, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		return err
	}
	defer f.Close()

	if _, err := f.WriteString(text); err != nil {
		return err
	}
	return nil
}

func runNextScript(m Model) tea.Cmd {
	return func() tea.Msg {
		selectedItems := getSelectedItems(m)

		if m.currentIdx >= len(selectedItems) {
			return outputMsg("")
		}

		app := selectedItems[m.currentIdx]
		path := m.scriptMap[app]

		ts := time.Now().Format(time.RFC3339)
		header := fmt.Sprintf("---- [%s] Début installation: %s (%s)\n", ts, app, path)
		_ = appendLog(m.logPath, header)

		out, err := exec.Command("bash", path).CombinedOutput()
		outText := string(out)
		if outText == "" {
			outText = "(no output)\n"
		}
		_ = appendLog(m.logPath, outText)

		var sb strings.Builder
		sb.WriteString(fmt.Sprintf("Installation de %s terminée.\n\n", app))
		sb.WriteString("--- Sortie du script ---\n")
		sb.WriteString(outText)
		sb.WriteString("------------------------\n")

		if err != nil {
			errLine := fmt.Sprintf("Erreur lors de %s : %v\n\n", app, err)
			_ = appendLog(m.logPath, errLine)
			sb.WriteString(errLine)
		} else {
			successLine := fmt.Sprintf("%s installé avec succès\n\n", app)
			_ = appendLog(m.logPath, successLine)
			sb.WriteString(successLine)
		}

		return outputMsg(sb.String())
	}
}

func tick() tea.Cmd {
	return tea.Tick(time.Millisecond*100, func(t time.Time) tea.Msg {
		return tickMsg(t)
	})
}

func openLogCmd(path string) tea.Cmd {
	return func() tea.Msg {
		editor := os.Getenv("EDITOR")
		try := func(cmd *exec.Cmd) {
			cmd.Stdin = os.Stdin
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr
			_ = cmd.Run()
		}

		if editor != "" {
			parts := strings.Fields(editor)
			cmd := exec.Command(parts[0], append(parts[1:], path)...)
			try(cmd)
			return outputMsg("")
		}

		candidates := []string{"xdg-open", "nano", "vim", "vi"}
		for _, c := range candidates {
			if p, err := exec.LookPath(c); err == nil {
				cmd := exec.Command(p, path)
				try(cmd)
				return outputMsg("")
			}
		}

		return outputMsg(fmt.Sprintf("Impossible de trouver un éditeur pour ouvrir %s\n", path))
	}
}

func clearScreen() tea.Cmd {
	return func() tea.Msg {
		cmd := exec.Command("clear")
		cmd.Stdout = os.Stdout
		_ = cmd.Run()
		return nil
	}
}

func logoffCmd() tea.Cmd {
	return func() tea.Msg {
		path := "scripts/install_logoff.sh"

		cmd := exec.Command("bash", path)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		_ = cmd.Run()

		return tea.Quit
	}
}

func (m Model) updateList(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd

	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {

		case "up", "k":
			if m.cursor > 0 {
				m.cursor--
			}
			return m, nil

		case "down", "j":
			start, end := m.paginator.GetSliceBounds(len(m.items))
			itemsOnPage := m.items[start:end]

			if m.cursor < len(itemsOnPage)-1 {
				m.cursor++
			}
			return m, nil

		case "h", "left":
			m.paginator.PrevPage()
			m.cursor = 0
			return m, nil

		case "l", "right":
			m.paginator.NextPage()
			m.cursor = 0
			return m, nil

		case " ":
			start, _ := m.paginator.GetSliceBounds(len(m.items))
			globalIndex := start + m.cursor

			itemName := m.items[globalIndex]

			if strings.HasPrefix(itemName, "Tout") {
				targetState := false

				for app := range m.scriptMap {
					if !m.selected[app] {
						targetState = true
						break
					}
				}

				for app := range m.scriptMap {
					if !strings.HasPrefix(app, "Tout") {
						m.selected[app] = targetState
					}
				}

				m.selected[itemName] = targetState

				if targetState {
					m.output = "Tous les paquets sélectionnés."
				} else {
					m.output = "Tous les paquets désélectionnés."
				}

			} else {
				m.selected[itemName] = !m.selected[itemName]
			}

			return m, nil

		case "enter":
			selectedItems := getSelectedItems(m)
			if len(selectedItems) == 0 {
				m.output = "Aucun script sélectionné."
				m.state = "done"
				return m, nil
			}

			headerPath := m.logPath
			headerContent := fmt.Sprintf("==== Nouveau run : %s ====\n", time.Now().Format(time.RFC3339))
			if err := appendLog(headerPath, headerContent); err != nil {
				fallback := "./Install-Packages-26.04.log"
				m.output = fmt.Sprintf("Impossible d'écrire dans %s (permission). Les logs seront écrits dans %s\n\n", headerPath, fallback)
				m.logPath = fallback
				_ = appendLog(m.logPath, headerContent)
			} else {
				selection := "Paquets sélectionnés:\n"
				for _, s := range selectedItems {
					selection += "- " + s + "\n"
				}
				selection += "\n"
				_ = appendLog(m.logPath, selection)
			}

			m.state = "install"
			m.currentIdx = 0

			progressCmd := m.progress.SetPercent(0.0)

			currentAppName := selectedItems[0]
			m.output = fmt.Sprintf("Démarrage de l'installation : %s\n\n", currentAppName)

			return m, tea.Batch(clearScreen(), progressCmd, runNextScript(m))

		case "q", "ctrl+c":
			return m, tea.Quit
		}
	}

	m.paginator, cmd = m.paginator.Update(msg)
	return m, cmd
}

func (m Model) updateInstall(msg tea.Msg) (tea.Model, tea.Cmd) {

	switch msg := msg.(type) {

	case tickMsg:
		return m, tick()

	case finalPauseMsg:
		trailer := fmt.Sprintf("==== Fin du run : %s ====\n\n", time.Now().Format(time.RFC3339))
		_ = appendLog(m.logPath, trailer)

		m.state = "done"
		m.output = "INSTALLATION TERMINEE !"
		return m, nil

	case outputMsg:
		m.currentIdx++

		selectedItems := getSelectedItems(m)
		selectedCount := len(selectedItems)

		var statusMsg string
		if m.currentIdx > 0 && m.currentIdx <= selectedCount {
			previousApp := selectedItems[m.currentIdx-1]
			if strings.Contains(string(msg), "Erreur lors de") {
				statusMsg = fmt.Sprintf("Installation de %s terminée avec des erreurs.", previousApp)
			} else {
				statusMsg = fmt.Sprintf("Installation de %s terminée avec succès.", previousApp)
			}
			m.output = statusMsg
		}

		progressPct := float64(m.currentIdx) / float64(selectedCount)
		if progressPct > 1.0 {
			progressPct = 1.0
		}

		cmd := m.progress.SetPercent(progressPct)

		if m.currentIdx < selectedCount {
			currentAppName := selectedItems[m.currentIdx]

			m.output = fmt.Sprintf("%s\nScript terminé. Préparation du script suivant:\nDémarrage de l'installation : %s\n\n", m.output, currentAppName)

			return m, tea.Batch(cmd, runNextScript(m))
		}

		waitCmd := func() tea.Msg {
			time.Sleep(time.Second * 1)
			return finalPauseMsg{}
		}

		return m, tea.Batch(cmd, waitCmd)
	}

	return m, nil
}

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	if msg, ok := msg.(tea.WindowSizeMsg); ok {
		m.width = msg.Width
		m.height = msg.Height
	}

	switch msg := msg.(type) {
	case progress.FrameMsg:
		progressModel, cmd := m.progress.Update(msg)
		m.progress = progressModel.(progress.Model)
		return m, cmd
	}

	switch m.state {
	case "list":
		return m.updateList(msg)

	case "install":
		return m.updateInstall(msg)

	case "done":
		if keyMsg, ok := msg.(tea.KeyMsg); ok {
			switch keyMsg.String() {
			case "q", "enter":
				return m, tea.Quit
			case "l":
				return m, tea.Batch(tea.Quit, clearScreen(), openLogCmd(m.logPath))

			case "y":
				return m, tea.Batch(clearScreen(), logoffCmd())
			case "n":
				return m, tea.Quit
			}
		}

	case "log":
		if keyMsg, ok := msg.(tea.KeyMsg); ok {
			switch keyMsg.String() {
			case "q", "enter":
				return m, tea.Quit
			case "b":
				m.state = "done"
				if m.output == "" {
					m.output = "INSTALLATION TERMINEE !"
				}
				return m, nil
			}
		}
	}

	return m, nil
}
