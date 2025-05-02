# Dotfiles Managed with Chezmoi

This repository contains my personal dotfiles and configuration files, managed using [chezmoi](https://www.chezmoi.io/). It is designed to ensure consistency and security across different environments (Linux, macOS, Windows).

## Structure

### `home/`
- **`dot_bashrc.tmpl`**: Template for `.bashrc`.
- **`dot_zshrc.tmpl`**: Template for `.zshrc`.
- **`dot_config/`**: Configuration files for various tools.
- **`dot_external/`**: External configurations, e.g., `selinux_config.tmpl`.

- **`photos/`**: Personal images for profiles or presentations.

### Installation Scripts
- **`linux-install.sh`**: Setup script for Linux.
- **`mac-install.sh`**: Setup script for macOS.
- **`win-install.ps1`**: Setup script for Windows.

## Usage

1. Install chezmoi:
   ```bash
   sh -c "$(curl -fsLS chezmoi.io/get)"
   ```

2. Initialize chezmoi with this repository:
   ```bash
   chezmoi init --apply <repo-url>
   ```

3. Customize templates and configurations as needed.

## Security

- Sensitive files are encrypted using [age](https://github.com/FiloSottile/age).
- Ensure you have the decryption key to access private files.

## Contributing

Feel free to suggest improvements or report issues.

## Install

Mac Setup
This'll install Homebrew and chezmoi. After installation `chezmoi` will be initialized.

```Mac
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/mac-install.sh)"
```

Linux Setup 
This'll install chezmoi. After installation `chezmoi` will be initialized.

```Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/linux-install.sh)"
```

Windows Setup
This'll install chezmoi. 

```Windows
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/win-install.ps1
Invoke-Expression $($ScriptFromGitHub.Content)
```

## Manual install

Prerequisite: Homebrew & chezmoi

```shell
# Setup
chezmoi init https://github.com/lnyousif/dotfiles.git

# Configure ~/.config/chezmoi/chezmoi.toml
chezmoi init
```
