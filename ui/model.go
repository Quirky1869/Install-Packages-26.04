package ui

import (
	"fmt"

	tea "github.com/charmbracelet/bubbletea"
)

type Model struct {
	items     []string
	cursor    int
	selected  map[int]bool
	state     string // "list", "install", "done"
	output    string // log d'installation
	scriptMap map[string]string
}

func NewModel(items []string) Model {
	scriptMap := map[string]string{
		"Visual Studio Code": "scripts/install_vscode.sh",
		"Google Chrome":      "scripts/install_chrome.sh",
		"Burp Suite":         "scripts/install_burpsuite.sh",
		"Exa":                "scripts/install_exa.sh",
	}

	return Model{
		items:     items,
		cursor:    0,
		selected:  make(map[int]bool),
		state:     "list",
		scriptMap: scriptMap,
	}
}

func (m Model) Init() tea.Cmd { return nil }

type SelectedMsg struct {
	Items []string
}

func (m Model) Selected() SelectedMsg {
	var out []string
	for i, it := range m.items {
		if m.selected[i] {
			out = append(out, it)
		}
	}
	return SelectedMsg{Items: out}
}

func (m Model) StringSelected() string {
	sel := m.Selected()
	if len(sel.Items) == 0 {
		return "(aucune sélection)"
	}
	return fmt.Sprintf("%v", sel.Items)
}
