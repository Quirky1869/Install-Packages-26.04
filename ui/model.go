package ui

import (
	"github.com/charmbracelet/bubbles/list"
	"github.com/charmbracelet/bubbles/progress"
	tea "github.com/charmbracelet/bubbletea"
)

type item struct {
	title, desc string
}

func (i item) Title() string       { return i.title }
func (i item) Description() string { return i.desc }
func (i item) FilterValue() string { return i.title }

type Model struct {
	list       list.Model
	progress   progress.Model
	state      string
	output     string
	scriptMap  map[string]string
	selected   map[string]bool
	// currentIdx int
}

func NewModel(items []string) Model {
	var listItems []list.Item
	for _, it := range items {
		listItems = append(listItems, item{title: it})
	}

	l := list.New(listItems, list.NewDefaultDelegate(), 40, 10)
	l.Title = "Sélectionnez les paquets à installer"
	l.SetShowHelp(false)
	l.SetFilteringEnabled(false)

	p := progress.New(progress.WithDefaultGradient())

	scriptMap := map[string]string{
		"Visual Studio Code": "scripts/install_vscode.sh",
		"Google Chrome":      "scripts/install_chrome.sh",
		"Burp Suite":         "scripts/install_burpsuite.sh",
		"Exa":                "scripts/install_exa.sh",
	}

	return Model{
		list:      l,
		progress:  p,
		state:     "list",
		scriptMap: scriptMap,
		selected:  make(map[string]bool),
	}
}

func (m Model) Init() tea.Cmd { return nil }
