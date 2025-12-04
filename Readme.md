# Dotfiles Managed with Chezmoi

This repository contains personal dotfiles and configuration files, managed using [chezmoi](https://www.chezmoi.io/). It provides a unified experience across different environments including:

- 🐧 **Linux** (Ubuntu, Fedora, Arch, Alpine)
- 🍎 **macOS** (Intel & Apple Silicon)
- 🪟 **Windows** (with WSL support)
- ☁️ **GitHub Codespaces**
- 🐳 **DevContainers** (VS Code Remote Containers)

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

See [example templates](examples/devcontainer/) for complete configurations.

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

Pre-configure with environment variables to skip prompts:

```bash
export CHEZMOI_NAME="Your Name"
export CHEZMOI_EMAIL="your@email.com"
export CHEZMOI_SETUP_TYPE="development"
```

See [Environment Reference](docs/ENVIRONMENT_REFERENCE.md) for all options.

## Documentation

- 📖 [Quick Start Guide](docs/QUICK_START.md) - Detailed installation and setup
- 🐳 [DevContainer Setup](docs/DEVCONTAINER_SETUP.md) - VS Code DevContainers & Codespaces
- 🔧 [Environment Reference](docs/ENVIRONMENT_REFERENCE.md) - Configuration variables and options
- 🔍 [Troubleshooting Guide](docs/TROUBLESHOOTING.md) - Common issues and solutions
- ⭐ [Features Overview](docs/FEATURES.md) - Complete list of all features
- 🌍 [Cross-Platform Guide](docs/CROSS_PLATFORM.md) - Platform-specific details

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
├── docs/                           # Documentation
├── examples/                       # Example configurations
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

Pre-configured useful aliases:
- `ll` - Detailed list view
- `la` - List all including hidden
- `..` - Go up one directory
- Git shortcuts: `gst`, `gco`, `glog`

### Git Enhancements

- Beautiful log view: `git lg`
- Pre-configured global `.gitignore`
- Commit signing support
- Useful aliases

### Starship Prompt

Intelligent prompt showing:
- Current directory
- Git status
- Programming language versions
- Command duration
- Error indicators

## Contributing

While this is a personal dotfiles repository, suggestions and improvements are welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines on:
- Reporting issues
- Suggesting enhancements
- Submitting pull requests
- Code style and testing
- Platform considerations

## Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [DevContainers Specification](https://containers.dev/)
- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)
- [Starship Prompt](https://starship.rs/)

## License

This repository is provided as-is for personal use. Feel free to fork and adapt to your needs.

---

**Made with ❤️ for unified development environments**
