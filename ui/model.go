package ui

import (
	"github.com/charmbracelet/bubbles/list"
	"github.com/charmbracelet/bubbles/progress"
	tea "github.com/charmbracelet/bubbletea"
)

type Model struct {
	list        list.Model        // composant liste (sélection)
	selected    map[string]bool   // éléments sélectionnés
	scriptMap   map[string]string // association nom -> script
	progress    progress.Model    // barre de progression
	output      string            // affichage terminal
	state       string            // état : "list", "install", "done", "log"
	currentIdx  int               // index du script en cours
	logPath     string            // chemin du fichier de log
	width       int               // Largeur du terminal pour le rendu de la barre
	height      int               // Hauteur du terminal
}

func NewModel(items []string) Model {
	var listItems []list.Item
	for _, i := range items {
		listItems = append(listItems, listItem(i))
	}

	l := list.New(listItems, list.NewDefaultDelegate(), 40, 10)
	l.Title = "Sélectionnez les paquets à installer"
	l.SetShowHelp(false)
	l.SetFilteringEnabled(false)
	l.DisableQuitKeybindings()

	defaultLogPath := "/var/log/Install-Packages-26.04.log"

	return Model{
		list:        l,
		selected:    make(map[string]bool),
		progress:    progress.New(progress.WithDefaultGradient()),
		scriptMap:   getScriptMap(),
		state:       "list",
		logPath:     defaultLogPath,
	}
}

type listItem string

func (i listItem) Title() string       { return string(i) }
func (i listItem) Description() string { return "" }
func (i listItem) FilterValue() string { return string(i) }

func (m Model) Init() tea.Cmd {
	return nil
}

func getScriptMap() map[string]string {
	return map[string]string{
		"Agg":                "scripts/install_agg.sh",
		"Ansible":            "scripts/install_ansible.sh",
		"Aperisolve":         "scripts/install_aperisolve.sh",
		"Apache2":            "scripts/install_apache2.sh",
		"Arsenal":            "scripts/install_arsenal.sh",
		"Bashrc":             "scripts/install_bashrc.sh",
		"Binary Ninja":       "scripts/install_binaryninja.sh",
		"Brave":              "scripts/install_brave.sh",
		"Burp Suite":         "scripts/install_burpsuite.sh",
		"DCV":                "scripts/install_dcv.sh",
		"Doc Scripts":        "scripts/install_doc-scripts.sh",
		"Docker":             "scripts/install_docker.sh",
		"Discord":            "scripts/install_discord.sh",
		"Exa":                "scripts/install_exa.sh",
		"Git":                "scripts/install_git.sh",
		"Github Desktop":     "scripts/install_github-desktop.sh",
		"Google Chrome":      "scripts/install_chrome.sh",
		"Holehe":             "scripts/install_holehe.sh",
		"Kitty Terminal":     "scripts/install_kitty-terminal.sh",
		"Lazy Docker":        "scripts/install_lazy-docker.sh",
		"MariaDB":            "scripts/install_mariadb.sh",
		"Metasploit":         "scripts/install_metasploit.sh",
		"Packets":            "scripts/install_packets.sh",
		"Pet":                "scripts/install_pet.sh",
		"Pip":                "scripts/install_pip.sh",
		"Raccourcis Clavier": "scripts/install_raccourcis-clavier.sh",
		"SSH List":           "scripts/install_sshlist.sh",
		"Sherlock":           "scripts/install_sherlock.sh",
		"Snap":               "scripts/install_snap.sh",
		"SQLMap":             "scripts/install_sqlmap.sh",
		"TGPT":               "scripts/install_tgpt.sh",
		"The Harvester":      "scripts/install_the-harvester.sh",
		"Themes":             "scripts/install_themes.sh",
		"Vagrant":            "scripts/install_vagrant.sh",
		"VirtualBox":         "scripts/install_virtualbox.sh",
		"Visual Studio Code": "scripts/install_vscode.sh",
		"Warp":               "scripts/install_warp-terminal.sh",
		"Wireshark":          "scripts/install_wireshark.sh",
		"Zsh and Ohmyzsh":    "scripts/install_zsh-ohmyzsh.sh",
	}
}
