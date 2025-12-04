# Quick Start Guide

Get up and running with these dotfiles in minutes across any machine.

## Installation Methods

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

### 📦 Platform-Specific Scripts

#### macOS
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/mac-install.sh)"
```

#### Linux
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/linux-install.sh)"
```

#### Windows
Download and run: [win-install.ps1](https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/win-install.ps1)

### ☁️ GitHub Codespaces

1. Configure in GitHub Settings → Codespaces
2. Set dotfiles repo: `lnyousif/dotfiles`
3. Dotfiles apply automatically on new Codespace creation

### 🐳 DevContainers

Add to your `.devcontainer/devcontainer.json`:
```json
{
  "dotfiles": {
    "repository": "lnyousif/dotfiles",
    "installCommand": "bootstrap.sh"
  }
}
```

## First-Time Setup

During installation, you'll be prompted for:

1. **Setup Type** - Choose your environment:
   - `basic` - Minimal setup
   - `development` - Full dev tools
   - `work` - Work configuration
   - `kids` - Kid-friendly setup

2. **User Type** - Select privileges:
   - `sudo` - Can install system packages
   - `normal` - User-only installation

3. **Optional Features** (if applicable):
   - Encryption/decryption support
   - Password manager integration
   - Network hub/node configuration
   - Cloudflare DNS updater

## What Gets Installed

### Base Setup (All Machines)
- **Shell**: Bash/Zsh with Starship prompt
- **Editor**: Micro (terminal editor)
- **Tools**: Git, curl, wget, tmux
- **Utilities**: age (encryption), xclip (clipboard)

### Development Setup
- **Containers**: Podman with compose
- **Code Quality**: commitizen, pre-commit
- **AI Tools**: GitHub Copilot, Gemini CLI
- **Browser**: Chromium
- **Testing**: act (GitHub Actions locally)

### Platform-Specific

#### Linux
- Package manager configuration (apt/dnf/pacman/apk)
- Desktop environment optimizations
- VSCode with extensions

#### macOS
- Homebrew package manager
- macOS defaults configuration
- Keyboard and UI customizations

#### Windows
- Winget package manager
- PowerShell profile
- Windows Terminal settings

## Environment Variables

### Pre-configure Installation

Skip prompts by setting environment variables:

```bash
export CHEZMOI_NAME="Your Name"
export CHEZMOI_EMAIL="your.email@example.com"
export CHEZMOI_SETUP_TYPE="development"
export CHEZMOI_USER_TYPE="sudo"
export CHEZMOI_ENCRYPTION=false
export CHEZMOI_PASS_MANAGER=false
export CHEZMOI_NETWORK_HUB=false
export CHEZMOI_NETWORK_NODE=false
export CHEZMOI_NETWORK_CLOUDFLARE=false
```

Then run the installation command.

## Post-Installation

### Apply Changes
```bash
chezmoi apply
```

### Update Dotfiles
```bash
chezmoi update
```

### Edit Configurations
```bash
chezmoi edit ~/.bashrc
chezmoi apply
```

### Add New Files
```bash
chezmoi add ~/.config/newfile
```

### View Differences
```bash
chezmoi diff
```

## Common Customizations

### Change Default Editor
Edit `~/.bashrc` or `~/.zshrc`:
```bash
export EDITOR=vim  # or nano, code, etc.
```

### Add Custom Aliases
Edit `~/.myscripts/bash_aliases` (managed by chezmoi)

### Modify Shell Prompt
Edit Starship config:
```bash
chezmoi edit ~/.config/starship.toml
```

### Add Git Aliases
Already included! Try:
- `git lg` - Beautiful log view
- `git st` - Status
- `git co` - Checkout
- `git br` - Branch

## Troubleshooting

### Installation Fails

**Check prerequisites:**
```bash
# Linux/Mac
which curl || which wget
which git

# Windows
winget --version
```

### Dotfiles Not Applied

**Manually apply:**
```bash
chezmoi init --apply https://github.com/lnyousif/dotfiles.git
```

### Permission Issues

**Ensure script is executable:**
```bash
chmod +x bootstrap.sh
```

### Reset Everything

**Start fresh:**
```bash
chezmoi purge
rm -rf ~/.local/share/chezmoi
# Then re-run installation
```

## Directory Structure

```
~/.local/share/chezmoi/  # Source dotfiles
~/.config/chezmoi/       # Chezmoi configuration
~/.myscripts/            # Custom scripts and functions
~/.config/Code/          # VSCode settings (Linux)
~/AppData/Roaming/Code/  # VSCode settings (Windows)
~/Library/               # Application settings (macOS)
```

## Next Steps

1. **Explore** - Review what was installed
2. **Customize** - Adjust settings to your preference
3. **Learn** - Check out [Chezmoi documentation](https://www.chezmoi.io/)
4. **Backup** - Your configs are now in version control!

## Getting Help

- **View Chezmoi logs**: `chezmoi doctor`
- **Check configuration**: `chezmoi data`
- **Validate state**: `chezmoi verify`
- **Report issues**: [GitHub Issues](https://github.com/lnyousif/dotfiles/issues)

## Advanced Topics

For more advanced usage, see:
- [DevContainer Setup](DEVCONTAINER_SETUP.md)
- [Environment Reference](ENVIRONMENT_REFERENCE.md)
- [Troubleshooting Guide](TROUBLESHOOTING.md)
