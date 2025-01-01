dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

## Install

Mac Setup
This'll install Homebrew and chezmoi. After installation `chezmoi` will be initialized.

```Mac
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/mac-install.sh)"
```

Linux Setup 
This'll install chezmoi. After installation `chezmoi` will be initialized.



```Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/linux-install.sh)"
```

Windows Setup
This'll install chezmoi. 

```Windows
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/lnyousif/dotfiles/refs/heads/main/.support/win-install.ps1
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
