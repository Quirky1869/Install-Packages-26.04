package ui

import "fmt"

func (m Model) View() string {
	switch m.state {

	case "install":
		return BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s\n\n%s\n\n%s",
			TitleStyle.Render("Installation en cours..."),
			m.progress.View(),
			m.output,
			HelpStyle.Render("Installation en cours... (Appuyez sur 'q' pour quitter à tout moment.)"),
		))

	case "done":
		return BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s\n\n%s\n\n%s",
			TitleStyle.Render("Résultat de l’installation"),
			m.output,
			HelpStyle.Render("INSTALLATION TERMINEE ! Appuyez sur q ou Entrée pour quitter."),
			HelpStyle.Render("Appuyez sur 'l' pour ouvrir le fichier de log."),
		))

	case "log":
		return BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s\n\n%s",
			TitleStyle.Render("Logs d'installation"),
			m.output,
			HelpStyle.Render("Appuyez sur 'b' pour revenir, Entrée ou q pour quitter."),
		))

	default:
		s := TitleStyle.Render(m.list.Title) + "\n\n"

		for i, li := range m.list.Items() {
			it := li.(listItem)
			check := "[ ]"
			if m.selected[it.Title()] {
				check = "[x]"
			}

			cursor := "  "
			if i == m.list.Index() {
				cursor = "> "
			}

			s += fmt.Sprintf("%s%s %s\n", cursor, check, it.Title())
		}

		s += HelpStyle.Render("\n↑/↓ pour naviguer • espace pour sélectionner • Entrée pour installer • q pour quitter")
		return BorderStyle.Render(s)
	}
}
