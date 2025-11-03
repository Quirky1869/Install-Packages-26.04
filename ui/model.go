package ui

import (
	"github.com/charmbracelet/bubbles/list"
	"github.com/charmbracelet/bubbles/progress"
	tea "github.com/charmbracelet/bubbletea"
)

// Modèle global de l'application
type Model struct {
	list       list.Model        // composant liste (sélection)
	selected   map[string]bool   // éléments sélectionnés
	scriptMap  map[string]string // association nom -> script
	progress   progress.Model    // barre de progression
	output     string            // affichage terminal
	state      string            // état : "list", "install", "done"
	currentIdx int               // index du script en cours
}

// Constructeur pour être appelé depuis main.go
func NewModel(items []string) Model {
	// Conversion vers []list.Item
	var listItems []list.Item
	for _, i := range items {
		listItems = append(listItems, listItem(i))
	}

	l := list.New(listItems, list.NewDefaultDelegate(), 40, 10)
	l.Title = "Sélectionnez les paquets à installer"
	l.SetShowHelp(false)
	l.SetFilteringEnabled(false)
	l.DisableQuitKeybindings()

	return Model{
		list:      l,
		selected:  make(map[string]bool),
		progress:  progress.New(progress.WithDefaultGradient()),
		scriptMap: getScriptMap(),
		state:     "list",
	}
}

// // Ancienne version conservée (optionnelle)
// func InitialModel() Model {
// 	items := []string{
// 		"Tout sélectionner / désélectionner",
// 		"Visual Studio Code",
// 		"Google Chrome",
// 		"Burp Suite",
// 		"Exa",
// 	}
// 	return NewModel(items)
// }

// listItem est un type wrapper pour la liste Bubble Tea
type listItem string

func (i listItem) Title() string       { return string(i) }
func (i listItem) Description() string { return "" }
func (i listItem) FilterValue() string { return string(i) }

// Lancement initial
func (m Model) Init() tea.Cmd {
	return nil
}

// Map des scripts installables
func getScriptMap() map[string]string {
	return map[string]string{
		"Visual Studio Code": "scripts/install_vscode.sh",
		"Google Chrome":      "scripts/install_chrome.sh",
		"Burp Suite":         "scripts/install_burpsuite.sh",
		"Exa":                "scripts/install_exa.sh",
	}
}
