package ui

import (
	"fmt"
	"os/exec"
	"strings"
	"time"

	tea "github.com/charmbracelet/bubbletea"
)

type tickMsg time.Time
type outputMsg string
type progressMsg float64

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch m.state {
	case "list":
		return m.updateList(msg)
	case "install":
		return m.updateInstall(msg)
	case "done":
		if keyMsg, ok := msg.(tea.KeyMsg); ok {
			if keyMsg.String() == "enter" || keyMsg.String() == "q" {
				return m, tea.Quit
			}
		}
	}
	return m, nil
}

func (m Model) updateList(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd
	m.list, cmd = m.list.Update(msg)

	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case " ":
			if i, ok := m.list.SelectedItem().(item); ok {
				m.selected[i.title] = !m.selected[i.title]
			}
		case "enter":
			if len(m.selected) == 0 {
				m.output = "Aucun script sélectionné."
				m.state = "done"
				return m, nil
			}
			m.state = "install"
			return m, tea.Batch(runScripts(m.selected, m.scriptMap), tick())
		case "q", "ctrl+c":
			return m, tea.Quit
		}
	}
	return m, cmd
}

func (m Model) updateInstall(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tickMsg:
		return m, tick()
	case outputMsg:
		m.output += string(msg)
		m.progress.SetPercent(1.0)
		m.state = "done"
	case progressMsg:
		m.progress.SetPercent(float64(msg))
	}
	return m, nil
}

func tick() tea.Cmd {
	return tea.Tick(time.Millisecond*150, func(t time.Time) tea.Msg {
		return tickMsg(t)
	})
}

func runScripts(selected map[string]bool, scripts map[string]string) tea.Cmd {
	return func() tea.Msg {
		var output strings.Builder
		done := 0

		for app, sel := range selected {
			if !sel {
				continue
			}
			path := scripts[app]
			output.WriteString(fmt.Sprintf("Exécution de %s (%s)\n", app, path))

			cmd := exec.Command("bash", path)
			out, err := cmd.CombinedOutput()
			output.Write(out)
			if err != nil {
				output.WriteString(fmt.Sprintf("Erreur : %v\n", err))
			}
			done++
		}

		output.WriteString("\nInstallation terminée ! Appuyez sur q ou Entrée pour quitter.\n")
		return outputMsg(output.String())
	}
}
