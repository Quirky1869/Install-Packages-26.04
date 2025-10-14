package ui

import (
	"fmt"
	"os/exec"
	"strings"

	tea "github.com/charmbracelet/bubbletea"
)

// Message pour transmettre la sortie des scripts
type outputMsg string

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {

	case tea.KeyMsg:
		switch msg.String() {

		case "ctrl+c", "q":
			return m, tea.Quit

		case "up", "k":
			if m.state == "list" && m.cursor > 0 {
				m.cursor--
			}

		case "down", "j":
			if m.state == "list" && m.cursor < len(m.items)-1 {
				m.cursor++
			}

		case " ":
			if m.state == "list" {
				m.selected[m.cursor] = !m.selected[m.cursor]
			}

		case "enter":
			if m.state == "list" {
				selected := m.Selected().Items
				if len(selected) == 0 {
					m.output = "Aucun script sélectionné.\n"
					m.state = "done"
					return m, nil
				}
				m.state = "install"
				m.output = "Lancement de l'installation...\n\n"
				return m, runScripts(selected, m.scriptMap)
			} else if m.state == "done" {
				return m, tea.Quit
			}
		}

	case outputMsg:
		m.output += string(msg)
		m.state = "done"
	}

	return m, nil
}

// Fonction pour exécuter les scripts sélectionnés
func runScripts(selected []string, scripts map[string]string) tea.Cmd {
	return func() tea.Msg {
		var output strings.Builder

		for _, app := range selected {
			path, ok := scripts[app]
			if !ok {
				output.WriteString(fmt.Sprintf("Aucun script associé à %s\n", app))
				continue
			}

			output.WriteString(fmt.Sprintf("Exécution de %s (%s)\n", app, path))
			cmd := exec.Command("bash", path)

			out, err := cmd.CombinedOutput()
			output.Write(out)
			if err != nil {
				output.WriteString(fmt.Sprintf("Erreur lors de l'exécution de %s : %v\n", path, err))
			}
			output.WriteString("\n----------------------------------------\n\n")
		}

		output.WriteString("Installation terminée ! Appuyez sur q pour quitter.\n")
		return outputMsg(output.String())
	}
}
