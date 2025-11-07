package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"

	tea "github.com/charmbracelet/bubbletea"
	"projet-install-packages-26.04/ui"
)

func ensureSudoCached() func() {
	if path, err := exec.LookPath("sudo"); err == nil && path != "" {
		cmd := exec.Command("sudo", "-v")
		cmd.Stdin = os.Stdin
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		fmt.Println("Demande d'authentification sudo (nécessaire pour les scripts).")
		if err := cmd.Run(); err != nil {
			fmt.Fprintln(os.Stderr, "Impossible d'obtenir les droits sudo :", err)
			return nil
		}

		stop := make(chan struct{})
		go func() {
			ticker := time.NewTicker(4 * time.Minute)
			defer ticker.Stop()
			for {
				select {
				case <-ticker.C:
					_ = exec.Command("sudo", "-v").Run()
				case <-stop:
					return
				}
			}
		}()

		return func() {
			close(stop)
		}
	}

	if path, err := exec.LookPath("pkexec"); err == nil && path != "" {
		fmt.Println("sudo introuvable — tentative d'authentification via pkexec (polkit).")
		cmd := exec.Command("pkexec", "/usr/bin/true")
		cmd.Stdin = os.Stdin
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			fmt.Fprintln(os.Stderr, "pkexec échoué :", err)
			return nil
		}

		fmt.Println("Authentification via pkexec effectuée (attention : cela ne configure pas sudo).")
		return nil
	}

	fmt.Fprintln(os.Stderr, "ni sudo ni pkexec trouvés : les scripts demanderont peut-être un mot de passe.")
	return nil
}

func main() {
	cleanup := ensureSudoCached()
	if cleanup != nil {
		defer cleanup()
	}

	items := []string{
		"Tout sélectionner / désélectionner",
		"Agg",
		"Ansible",
		"Aperisolve",
		"Apache2",
		"Arsenal",
		"Bashrc",
		"Binary Ninja",
		"Brave",
		"Burp Suite",
		"DCV",
		"Doc Scripts",
		"Docker",
		"Discord",
		"Exa",
		"Git",
		"Github Desktop",
		"Google Chrome",
		"Holehe",
		"Kitty Terminal",
		"Lazy Docker",
		"MariaDB",
		"Metasploit",
		"Packets",
		"Pet",
		"Pip",
		"Raccourcis Clavier",
		"SSH List",
		"Sherlock",
		"Snap",
		"SQLMap",
		"TGPT",
		"The Harvester",
		"Themes",
		"Vagrant",
		"VirtualBox",
		"Visual Studio Code",
		"Wireshark",
		"Zsh and Ohmyzsh",
	}

	m := ui.NewModel(items)
	p := tea.NewProgram(m)

	if err := p.Start(); err != nil {
		log.Fatalf("Erreur au lancement de l'app: %v", err)
		os.Exit(1)
	}
}
