# Dotfiles Managed with Chezmoi

This repository contains my personal dotfiles and configuration files, managed using [chezmoi](https://www.chezmoi.io/). It is designed to ensure consistency and security across different environments (Linux, macOS, Windows).

## Usage

Install chezmoi:

Mac & Linux

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply lnyousif
```

Windows install and initiate

```
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/win-install.ps1
Invoke-Expression $($ScriptFromGitHub.Content)
```

Other ways to install and inittiate

Mac

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/mac-install.sh)"
```

Linux

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/home/linux-install.sh)"
```
