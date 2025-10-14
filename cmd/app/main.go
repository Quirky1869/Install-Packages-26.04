package main

import (
	"log"
	"os"

	tea "github.com/charmbracelet/bubbletea"
	"projet-install-packages-26.04/ui"
)

func main() {
	items := []string{
		"Visual Studio Code",
		"Google Chrome",
		"Burp Suite",
		"Exa",
	}

	m := ui.NewModel(items)
	p := tea.NewProgram(m)
	if err := p.Start(); err != nil {
		log.Fatalf("Erreur au lancement de l'app: %v", err)
		os.Exit(1)
	}
}
