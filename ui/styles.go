package ui

import "github.com/charmbracelet/lipgloss"

var (
	// Couleurs principales
	colorPrimary   = lipgloss.Color("#7D56F4")
	colorSecondary = lipgloss.Color("#04B575")
	colorSelected  = lipgloss.Color("#FFB86C")
	colorText      = lipgloss.Color("#E5E5E5")

	// Styles
	TitleStyle = lipgloss.NewStyle().
			Bold(true).
			Foreground(colorPrimary).
			MarginBottom(1)

	ItemStyle = lipgloss.NewStyle().
			PaddingLeft(2).
			Foreground(colorText)

	SelectedItemStyle = lipgloss.NewStyle().
				PaddingLeft(2).
				Bold(true).
				Foreground(colorSelected)

	HelpStyle = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#666666")).
			MarginTop(1)

	BorderStyle = lipgloss.NewStyle().
			Border(lipgloss.RoundedBorder()).
			BorderForeground(lipgloss.Color("#444444")).
			Padding(1, 2).
			Margin(1, 2)
)
