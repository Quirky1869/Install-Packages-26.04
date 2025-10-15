package ui

import "fmt"

func (m Model) View() string {
	switch m.state {

	case "install":
		return BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s\n\n%s",
			TitleStyle.Render("Installation en cours..."),
			m.progress.View(),
			m.output,
		))

	case "done":
		return BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s",
			TitleStyle.Render("Résultat de l’installation"),
			m.output,
		))

	default: // "list"
		s := TitleStyle.Render(m.list.Title) + "\n\n"

		for i, li := range m.list.Items() {
			it := li.(item)
			check := "[ ]"
			if m.selected[it.title] {
				check = "[x]"
			}

			cursor := "  " // par défaut, pas de curseur
			if i == m.list.Index() {
				cursor = "> "
			}

			s += fmt.Sprintf("%s%s %s\n", cursor, check, it.title)
		}

		s += HelpStyle.Render("\n↑/↓ pour naviguer • espace pour sélectionner • Entrée pour installer • q pour quitter")
		return BorderStyle.Render(s)
	}
}
