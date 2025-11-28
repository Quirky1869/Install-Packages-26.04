package ui

import (
	"fmt"
	"os"
	"os/exec"
	"sort"
	"strings"
	"time"

	tea "github.com/charmbracelet/bubbletea"
)

type (
	outputMsg string
	tickMsg   time.Time
)

func getSelectedItems(m Model) []string {
	items := []string{}
	for name, sel := range m.selected {
		if sel {
			if strings.HasPrefix(name, "Tout") {
				continue
			}
			items = append(items, name)
		}
	}
	sort.Strings(items)
	return items
}

func appendLog(path, text string) error {
	f, err := os.OpenFile(path, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		return err
	}
	defer f.Close()

	if _, err := f.WriteString(text); err != nil {
		return err
	}
	return nil
}

func runNextScript(m Model) tea.Cmd {
	return func() tea.Msg {
		selectedItems := getSelectedItems(m)

		if m.currentIdx >= len(selectedItems) {
			// S'il n'y a plus de scripts à lancer, retourne un message vide.
			return outputMsg("")
		}

		app := selectedItems[m.currentIdx]
		path := m.scriptMap[app]

		// Log du début
		ts := time.Now().Format(time.RFC3339)
		header := fmt.Sprintf("---- [%s] Début installation: %s (%s)\n", ts, app, path)
		_ = appendLog(m.logPath, header)

		// Exécution synchrone du script bash
		out, err := exec.Command("bash", path).CombinedOutput()
		outText := string(out)
		if outText == "" {
			outText = "(no output)\n"
		}
		_ = appendLog(m.logPath, outText)

		// Log de fin
		var sb strings.Builder
		sb.WriteString(fmt.Sprintf("Installation de %s terminée.\n\n", app))
		sb.WriteString("--- Sortie du script ---\n")
		sb.WriteString(outText)
		sb.WriteString("------------------------\n")
		
		if err != nil {
			errLine := fmt.Sprintf("Erreur lors de %s : %v\n\n", app, err)
			_ = appendLog(m.logPath, errLine)
			sb.WriteString(errLine)
		} else {
			successLine := fmt.Sprintf("%s installé avec succès\n\n", app)
			_ = appendLog(m.logPath, successLine)
			sb.WriteString(successLine)
		}

		return outputMsg(sb.String())
	}
}

func tick() tea.Cmd {
	return tea.Tick(time.Millisecond*100, func(t time.Time) tea.Msg {
		return tickMsg(t)
	})
}

func openLogCmd(path string) tea.Cmd {
	return func() tea.Msg {
		editor := os.Getenv("EDITOR")
		try := func(cmd *exec.Cmd) {
			cmd.Stdin = os.Stdin
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr
			// On ignore l'erreur d'exécution car on essaie plusieurs commandes.
			_ = cmd.Run() 
		}

		if editor != "" {
			parts := strings.Fields(editor)
			cmd := exec.Command(parts[0], append(parts[1:], path)...)
			try(cmd)
			return outputMsg("")
		}

		candidates := []string{"xdg-open", "nano", "vim", "vi"}
		for _, c := range candidates {
			if p, err := exec.LookPath(c); err == nil {
				cmd := exec.Command(p, path)
				try(cmd)
				return outputMsg("")
			}
		}

		return outputMsg(fmt.Sprintf("Impossible de trouver un éditeur pour ouvrir %s\n", path))
	}
}

func (m Model) updateList(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {

	case tea.KeyMsg:
		switch msg.String() {

		case "up", "k":
			m.list.CursorUp()
			return m, nil

		case "down", "j":
			m.list.CursorDown()
			return m, nil

		case " ":
			current := m.list.Index()
			selectedItem := m.list.Items()[current].(listItem)
			itemName := string(selectedItem)

			if strings.HasPrefix(itemName, "Tout") {
				// Logique pour Tout sélectionner / désélectionner
				allSelected := false
				for _, v := range m.selected {
					if !v {
						allSelected = true
						break
					}
				}

				// Inclut tous les éléments du scriptMap dans la sélection
				for app := range m.scriptMap {
					// Assurez-vous de ne pas sélectionner "Tout..." lui-même dans la map
					if !strings.HasPrefix(app, "Tout") { 
						m.selected[app] = allSelected
					}
				}

				if allSelected {
					m.output = "Tous les paquets sélectionnés."
				} else {
					m.output = "Tous les paquets désélectionnés."
				}

			} else {
				// Toggle la sélection pour l'élément courant
				m.selected[itemName] = !m.selected[itemName]
			}

			return m, nil

		case "enter":
			selectedItems := getSelectedItems(m)
			if len(selectedItems) == 0 {
				m.output = "Aucun script sélectionné."
				m.state = "done"
				return m, nil
			}

			// Initialisation des logs
			headerPath := m.logPath
			headerContent := fmt.Sprintf("==== Nouveau run : %s ====\n", time.Now().Format(time.RFC3339))
			if err := appendLog(headerPath, headerContent); err != nil {
				fallback := "./Install-Packages-26.04.log"
				m.output = fmt.Sprintf("Impossible d'écrire dans %s (permission). Les logs seront écrits dans %s\n\n", headerPath, fallback)
				m.logPath = fallback
				_ = appendLog(m.logPath, headerContent)
			} else {
				selection := "Paquets sélectionnés:\n"
				for _, s := range selectedItems {
					selection += "- " + s + "\n"
				}
				selection += "\n"
				_ = appendLog(m.logPath, selection)
			}

			// --- Démarrage de l'installation ---
			m.state = "install"
			m.currentIdx = 0
			
			// 1. Initialisation de la barre de progression à 0%
			progressCmd := m.progress.SetPercent(0.0)

			// 2. Affichage du premier script qui va commencer
			currentAppName := selectedItems[0]
			m.output = fmt.Sprintf("Démarrage de l'installation : **%s**\n\n", currentAppName)

			// 3. Lancement de la première commande et de la mise à jour de la progression
			return m, tea.Batch(progressCmd, runNextScript(m))

		case "q", "ctrl+c":
			return m, tea.Quit
		}
	}
	return m, nil
}

func (m Model) updateInstall(msg tea.Msg) (tea.Model, tea.Cmd) {

	switch msg := msg.(type) {

	case tickMsg:
		// Le tickMsg est conservé, mais il ne fait rien ici car la mise à jour
		// est pilotée par la fin de l'exécution du script (outputMsg).
		return m, tick()

	case outputMsg:
		// 1. Ajout de la sortie du script précédent
		m.output = string(msg)
		m.currentIdx++

		selectedItems := getSelectedItems(m)
		selectedCount := len(selectedItems)
		
		// Calcul de la progression (scripts terminés / scripts totaux)
		progress := float64(m.currentIdx) / float64(selectedCount)
		if progress > 1.0 {
			progress = 1.0
		}
		
		// 2. Mise à jour de la barre de progression
		cmd := m.progress.SetPercent(progress)

		// Vérification si d'autres scripts sont à lancer
		if m.currentIdx < selectedCount {
			// Préparation de l'affichage pour le script suivant
			currentAppName := selectedItems[m.currentIdx]
			
			// On ajoute le message d'attente/démarrage pour le prochain script
			m.output = fmt.Sprintf("Script terminé. Préparation du script suivant:\n Démarrage de l'installation : **%s**\n\n", currentAppName)

			// 3. Exécution de la commande de mise à jour de la barre ET du script suivant
			return m, tea.Batch(cmd, runNextScript(m))
		}

		// Si tous les scripts sont terminés
		trailer := fmt.Sprintf("==== Fin du run : %s ====\n\n", time.Now().Format(time.RFC3339))
		_ = appendLog(m.logPath, trailer)
		
		m.state = "done"
		m.output = "INSTALLATION TERMINEE !"
		return m, cmd
	}

	return m, nil
}

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch m.state {
	case "list":
		return m.updateList(msg)

	case "install":
		return m.updateInstall(msg)

	case "done":
		if keyMsg, ok := msg.(tea.KeyMsg); ok {
			switch keyMsg.String() {
			case "q", "enter":
				return m, tea.Quit
			case "l":
				return m, tea.Batch(tea.Quit, openLogCmd(m.logPath))
			}
		}
	case "log":
		if keyMsg, ok := msg.(tea.KeyMsg); ok {
			switch keyMsg.String() {
			case "q", "enter":
				return m, tea.Quit
			case "b":
				m.state = "done"
				if m.output == "" {
					m.output = "INSTALLATION TERMINEE !"
				}
				return m, nil
			}
		}
	}

	return m, nil
}