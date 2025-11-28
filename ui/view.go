package ui

import "fmt"

func (m Model) View() string {

	
	contentWidth := m.width - BorderStyle.GetHorizontalFrameSize()

	if m.width > 0 && contentWidth > 0 {
		
		m.progress.Width = contentWidth
	} else if m.width == 0 {
		
		return "Initialisation de la TUI..."
	}

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
			
			if _, ok := m.selected[it.Title()]; ok && m.selected[it.Title()] {
				check = "[x]"
			}

			cursor := "  "
			itemStyle := ItemStyle

			if i == m.list.Index() {
				
				cursor = "> "
				itemStyle = SelectedItemStyle
			}

			
			s += itemStyle.Render(fmt.Sprintf("%s%s %s", cursor, check, it.Title())) + "\n"
		}

		s += HelpStyle.Render("\n↑/↓ pour naviguer • espace pour sélectionner • Entrée pour installer • q pour quitter")
		return BorderStyle.Render(s)
	}
}
