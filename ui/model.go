package ui

import (
	"github.com/charmbracelet/bubbles/paginator"
	"github.com/charmbracelet/bubbles/progress"
	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

const itemsPerPage = 25

type Model struct {
	items      []string
	cursor     int
	paginator  paginator.Model
	selected   map[string]bool
	scriptMap  map[string]string
	progress   progress.Model
	output     string
	state      string
	currentIdx int
	logPath    string
	width      int
	height     int
}

func NewModel(items []string) Model {
	p := paginator.New()
	p.Type = paginator.Dots
	p.PerPage = itemsPerPage
	p.ActiveDot = lipgloss.NewStyle().Foreground(colorPrimary).Render("•")
	p.InactiveDot = lipgloss.NewStyle().Foreground(lipgloss.Color("#666666")).Render("•")
	p.SetTotalPages(len(items))

	defaultLogPath := "/var/log/Install-Packages-26.04.log"

	return Model{
		items:     items,
		cursor:    0,
		paginator: p,
		selected:  make(map[string]bool),
		progress:  progress.New(progress.WithDefaultGradient()),
		scriptMap: getScriptMap(),
		state:     "list",
		logPath:   defaultLogPath,
	}
}

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
