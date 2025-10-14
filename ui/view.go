package ui

import (
	"fmt"
	"strings"
)

func (m Model) View() string {
	switch m.state {
	case "install", "done":
		return fmt.Sprintf("%s\n\n%s", m.output, "Appuyez sur q pour quitter.")
	}

	var b strings.Builder
	b.WriteString("Sélectionnez les paquets à installer :\n\n")
	for i, item := range m.items {
		cursor := "  "
		if m.cursor == i {
			cursor = "> "
		}
		checked := "[ ]"
		if m.selected[i] {
			checked = "[x]"
		}
		b.WriteString(fmt.Sprintf("%s%s %s\n", cursor, checked, item))
	}

	b.WriteString("\nContrôles: ↑/↓ pour naviguer, espace pour sélectionner, Entrée pour installer, q pour quitter\n")
	return b.String()
}
