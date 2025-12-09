package ui

import (
	"fmt"

	"github.com/charmbracelet/lipgloss"
)

func (m Model) View() string {
	contentWidth := m.width - BorderStyle.GetHorizontalFrameSize()

	if m.width > 0 && contentWidth > 0 {
		m.progress.Width = contentWidth
	} else if m.width == 0 {
		return "Initialisation de la TUI..."
	}

	var content string

	switch m.state {

	case "install":
		content = BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s\n\n%s\n\n%s",
			TitleStyle.Render("Installation en cours..."),
			m.progress.View(),
			m.output,
			HelpStyle.Render("Installation en cours..."),
		))

	case "done":
		content = BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s\n\n%s\n%s\n%s",
			TitleStyle.Render("Résultat de l’installation"),
			m.output,
			LogoffStyle.Render("Voulez-vous vous déconnecter maintenant ? (y/n)"),
			HelpStyle.Render("Appuyez sur q ou Entrée pour quitter."),
			HelpStyle.Render("Appuyez sur 'l' pour ouvrir le fichier de log."),
		))

	case "log":
		content = BorderStyle.Render(fmt.Sprintf(
			"%s\n\n%s\n\n%s",
			TitleStyle.Render("Logs d'installation"),
			m.output,
			HelpStyle.Render("Appuyez sur 'b' pour revenir, Entrée ou q pour quitter."),
		))

	default:
		s := TitleStyle.Render("Sélectionnez les paquets à installer") + "\n\n"

		start, end := m.paginator.GetSliceBounds(len(m.items))
		itemsOnPage := m.items[start:end]

		for i, item := range itemsOnPage {
			check := "[ ]"
			if _, ok := m.selected[item]; ok && m.selected[item] {
				check = "[x]"
			}

			cursor := "  "
			itemStyle := ItemStyle

			if i == m.cursor {
				cursor = "> "
				itemStyle = SelectedItemStyle
			}

			s += itemStyle.Render(fmt.Sprintf("%s%s %s", cursor, check, item)) + "\n"
		}

		s += "\n" + m.paginator.View() + "\n"

		s += HelpStyle.Render("\n↑/↓ pour naviguer • ←/→ pour changer de page • espace pour sélectionner • Entrée pour installer • q pour quitter")
		content = BorderStyle.Render(s)
	}

	return lipgloss.Place(
		m.width,
		m.height,
		lipgloss.Center,
		lipgloss.Center,
		content,
	)
}
