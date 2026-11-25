# Dotfiles Managed with Chezmoi

This repository contains personal dotfiles and configuration files, managed using [chezmoi](https://www.chezmoi.io/). It provides a unified experience across different environments including:

- 🐧 **Linux** (Ubuntu, Fedora, Arch, Alpine)
- 🍎 **macOS** (Intel & Apple Silicon)
- 🪟 **Windows** (with WSL support)
- ☁️ **GitHub Codespaces**
- 🐳 **DevContainers** (VS Code Remote Containers)

> 📖 **How it works** (machine profiles, script order, secrets, adding/rotating keys,
> troubleshooting): see [docs/GUIDE.md](docs/GUIDE.md).

## Quick Start

### 🚀 One-Line Install

#### macOS & Linux
```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply lnyousif
```

#### Windows (PowerShell as Administrator)
```powershell
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/win-install.ps1
Invoke-Expression $($ScriptFromGitHub.Content)
```

### 📦 Platform-Specific Installation

<details>
<summary><b>macOS Installation</b></summary>

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/mac-install.sh)"
```

This installs:
- Homebrew (if not present)
- Chezmoi
- Base tools and configurations
- macOS-specific optimizations

</details>

<details>
<summary><b>Linux Installation</b></summary>

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/linux-install.sh)"
```

Supports:
- Debian/Ubuntu (apt)
- Fedora (dnf)
- Arch Linux (pacman)
- Alpine (apk)

</details>

<details>
<summary><b>Windows Installation</b></summary>

```powershell
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/win-install.ps1
Invoke-Expression $($ScriptFromGitHub.Content)
```

Features:
- Winget package manager setup
- PowerShell profile configuration
- Windows Terminal settings

</details>

### ☁️ GitHub Codespaces

Dotfiles automatically apply when creating a Codespace:

1. **Configure in GitHub**: Settings → Codespaces
2. **Set repository**: `lnyousif/dotfiles`
3. **Install command**: `bootstrap.sh`
4. **Enable**: "Automatically install dotfiles"

### 🐳 DevContainers

Add to your project's `.devcontainer/devcontainer.json`:

```json
{
  "dotfiles": {
    "repository": "lnyousif/dotfiles",
    "installCommand": "bootstrap.sh"
  }
}
```



## Features

### 🛠️ Tools & Software

**Base Setup (All Platforms)**
- Shell: Bash/Zsh with [Starship](https://starship.rs/) prompt
- Editor: [Micro](https://micro-editor.github.io/)
- Terminal Multiplexer: [Tmux](https://github.com/tmux/tmux)
- Version Control: Git with useful aliases
- Security: Age encryption support

**Development Setup**
- Containers: Podman with compose
- Code Quality: Pre-commit, Commitizen
- AI Assistants: GitHub Copilot, Gemini CLI
- Testing: Act (run GitHub Actions locally)
- IDE: VSCode with curated extensions

### ⚙️ Configuration Options

During setup, choose from:

- **Setup Types**: basic, development, kids, work
- **Features**: encryption, password manager, network node
- **Platform Detection**: Automatic for Codespaces/DevContainers

See the Environment Variables section below for pre-configuration options.



## Environment Variables

You can pre-configure the installation by setting environment variables:

```bash
export CHEZMOI_NAME="Your Name"
export CHEZMOI_EMAIL="your@email.com"
export CHEZMOI_SETUP_TYPE="development"  # basic, kids, development, work
export CHEZMOI_USER_TYPE="sudo"          # sudo, normal
export CHEZMOI_ENCRYPTION=false
export CHEZMOI_PASS_MANAGER=false
export CHEZMOI_NETWORK_HUB=false
export CHEZMOI_NETWORK_NODE=false
export CHEZMOI_NETWORK_CLOUDFLARE=false
export CHEZMOI_NETWORK_CFLOC=""          # Cloudflare site: sd, ag, rm, bk
export CHEZMOI_K0S_HUB=false
export CHEZMOI_K0S_NODE=false

# Secrets (only needed with encryption / password manager)
export AGE_PASSPHRASE='…'                # decrypts home/key.txt.age
export KEEPASSXC_PASSPHRASE='…'          # unlocks the KeePassXC database
```

Boolean flags must be exactly `true` or `false`; unset ones are prompted for.

## Common Tasks

### Update Dotfiles
```bash
chezmoi update
```

### Apply Changes
```bash
chezmoi apply
```

### Edit Configuration
```bash
chezmoi edit ~/.bashrc
chezmoi apply
```

### View Differences
```bash
chezmoi diff
```

### Add New File
```bash
chezmoi add ~/.config/newfile
```

## Project Structure

```
.
├── home/                           # Dotfiles source (managed by chezmoi)
│   ├── .chezmoi.toml.tmpl         # Main configuration template
│   ├── .chezmoiignore             # Ignore patterns
│   ├── .chezmoiscripts/           # Setup scripts
│   │   ├── linux/                 # Linux-specific
│   │   ├── darwin/                # macOS-specific
│   │   └── windows/               # Windows-specific
│   ├── .chezmoitemplates/         # Reusable templates
│   ├── .chezmoidata/              # Package definitions
│   ├── dot_bashrc.tmpl            # Bash configuration
│   ├── dot_zshrc.tmpl             # Zsh configuration
│   ├── dot_config/                # Application configs
│   └── dot_myscripts/             # Custom scripts
└── bootstrap.sh                    # Bootstrap script
```

## Customization

This dotfile setup is designed to be forked and customized:

1. **Fork this repository**
2. **Update personal information** in `.chezmoi.toml.tmpl`
3. **Customize packages** in `home/.chezmoidata/packages/`
4. **Add your scripts** in `home/.chezmoiscripts/`
5. **Modify templates** in `home/.chezmoitemplates/`

## Shell Features

### Custom Aliases

Defined in `home/dot_myscripts/_aliases`:
- `ll`, `la`, `l` - List views
- `h` / `hs` - Search shell / session history (fzf)
- `fp` - fzf with a bat preview
- `edit` - Open micro
- `cp`, `mv`, `df`, `du`, `mount` - Verbose / human-readable defaults

Functions (`_functions`, `_extra`): `cb <file>` copies a file to the clipboard,
`toggle_origin_remote` switches `origin` between HTTPS and SSH.

### Git Enhancements

- Pre-configured global `.gitignore`
- Commit and tag signing on development machines
- Machine-specific settings go in `~/.gitconfig_local` (included, not managed)

### Starship Prompt

Intelligent prompt showing:
- Current directory
- Git status
- Programming language versions
- Command duration
- Error indicators

## Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [DevContainers Specification](https://containers.dev/)
- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)
- [Starship Prompt](https://starship.rs/)

## License

This repository is provided as-is for personal use. Feel free to fork and adapt to your needs.

---

**Made with ❤️ for unified development environments**
