package ui

import (
	"fmt"
	"os"
	"os/exec"
	"sort"
	"strings"
	"time"

	tea "github.com/charmbracelet/bubbletea"
)

type (
	outputMsg string
	tickMsg   time.Time
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

		if err != nil {
			errLine := fmt.Sprintf("Erreur lors de %s : %v\n\n", app, err)
			_ = appendLog(m.logPath, errLine)
		} else {
			successLine := fmt.Sprintf("%s installé avec succès\n\n", app)
			_ = appendLog(m.logPath, successLine)
		}

		var sb strings.Builder
		sb.WriteString(fmt.Sprintf("Installation de %s\n", app))
		sb.WriteString(outText)
		if err != nil {
			sb.WriteString(fmt.Sprintf("Erreur : %v\n\n", err))
		} else {
			sb.WriteString(fmt.Sprintf("%s Installé avec succès\n\n", app))
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

func (m Model) updateList(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {

	case tea.KeyMsg:
		switch msg.String() {

		case "up", "k":
			m.list.CursorUp()
			return m, nil

		case "down", "j":
			m.list.CursorDown()
			return m, nil

		case " ":
			current := m.list.Index()
			selectedItem := m.list.Items()[current].(listItem)
			itemName := string(selectedItem)

			if strings.HasPrefix(itemName, "Tout") {
				allSelected := false
				for _, v := range m.selected {
					if !v {
						allSelected = true
						break
					}
				}

				for app := range m.scriptMap {
					m.selected[app] = allSelected
				}

				if allSelected {
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
				m.output = fmt.Sprintf("⚠️ Impossible d'écrire dans %s (permission). Les logs seront écrits dans %s\n\n", headerPath, fallback)
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
			if !strings.HasPrefix(m.output, "⚠️") {
				m.output = ""
			}
			m.progress.SetPercent(0)
			return m, tea.Batch(runNextScript(m), tick())

		case "q", "ctrl+c":
			return m, tea.Quit
		}
	}
	return m, nil
}

func (m Model) updateInstall(msg tea.Msg) (tea.Model, tea.Cmd) {

	switch msg := msg.(type) {

	case tickMsg:
		return m, tick()

	case outputMsg:
		m.output += string(msg)
		m.currentIdx++

		selectedItems := getSelectedItems(m)
		selectedCount := len(selectedItems)
		if selectedCount == 0 {
			m.progress.SetPercent(1.0)
			m.state = "done"
			return m, nil
		}

		progress := float64(m.currentIdx) / float64(selectedCount)
		if progress > 1.0 {
			progress = 1.0
		}
		cmd := m.progress.SetPercent(progress)

		if m.currentIdx < selectedCount {
			return m, tea.Batch(cmd, runNextScript(m))
		}

		trailer := fmt.Sprintf("==== Fin du run : %s ====\n\n", time.Now().Format(time.RFC3339))
		_ = appendLog(m.logPath, trailer)

		m.state = "done"
		return m, cmd
	}

	return m, nil
}

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
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
				return m, tea.Batch(tea.Quit, openLogCmd(m.logPath))
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
