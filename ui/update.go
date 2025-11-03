package ui

import (
	"fmt"
	"os/exec"
	"strings"
	"time"

	tea "github.com/charmbracelet/bubbletea"
)

// Messages personnalisés
type (
	outputMsg string
	tickMsg   time.Time
	// nextScriptMsg struct{}
)

// Fonction qui exécute un script à la fois
func runNextScript(m Model) tea.Cmd {
	return func() tea.Msg {
		selectedItems := []string{}
		for app, sel := range m.selected {
			if sel {
				selectedItems = append(selectedItems, app)
			}
		}

		// Si tous les scripts ont été exécutés
		if m.currentIdx >= len(selectedItems) {
			return outputMsg("\nInstallation terminée ! Appuyez sur q ou Entrée pour quitter.\n")
		}

		app := selectedItems[m.currentIdx]
		path := m.scriptMap[app]

		out, err := exec.Command("bash", path).CombinedOutput()
		var sb strings.Builder
		sb.WriteString(fmt.Sprintf("Installation de %s\n", app))
		sb.Write(out)
		if err != nil {
			sb.WriteString(fmt.Sprintf("Erreur : %v\n", err))
		} else {
			sb.WriteString(fmt.Sprintf("%s Installé avec succès\n\n", app))
		}

		return outputMsg(sb.String())
	}
}

// Tick pour animer la progression
func tick() tea.Cmd {
	return tea.Tick(time.Millisecond*100, func(t time.Time) tea.Msg {
		return tickMsg(t)
	})
}

// Gestion de la logique quand l'utilisateur navigue dans la liste
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

			// Cas spécial : "Tout sélectionner / désélectionner"
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
			hasSelected := false
			for _, v := range m.selected {
				if v {
					hasSelected = true
					break
				}
			}

			if !hasSelected {
				m.output = "Aucun script sélectionné."
				m.state = "done"
				return m, nil
			}
			m.state = "install"
			m.currentIdx = 0
			return m, tea.Batch(runNextScript(m), tick())

		case "q", "ctrl+c":
			return m, tea.Quit
		}
	}
	return m, nil
}

// Logique pendant l’installation
func (m Model) updateInstall(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {

	case tickMsg:
		return m, tick()

	case outputMsg:
		m.output += string(msg)
		m.currentIdx++

		selectedCount := 0
		for _, sel := range m.selected {
			if sel {
				selectedCount++
			}
		}

		progress := float64(m.currentIdx) / float64(selectedCount)
		if progress > 1.0 {
			progress = 1.0
		}

		m.progress.SetPercent(progress)

		if m.currentIdx < selectedCount {
			return m, runNextScript(m)
		}

		m.state = "done"
		return m, nil
	}

	return m, nil
}

// Fonction principale de mise à jour globale
func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch m.state {
	case "list":
		return m.updateList(msg)
	case "install":
		return m.updateInstall(msg)
	case "done":
		if keyMsg, ok := msg.(tea.KeyMsg); ok && (keyMsg.String() == "q" || keyMsg.String() == "enter") {
			return m, tea.Quit
		}
	}
	return m, nil
}
