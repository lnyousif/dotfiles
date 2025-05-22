# Dotfiles Managed with Chezmoi

This repository contains my personal dotfiles and configuration files, managed using [chezmoi](https://www.chezmoi.io/). It is designed to ensure consistency and security across different environments (Linux, macOS, Windows).

## Usage

Install chezmoi:
```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply lnyousif
```


## Install (removing soon)

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
