# Troubleshooting Guide

Common issues and their solutions when working with these dotfiles.

## Installation Issues

### Chezmoi Not Found After Installation

**Symptoms**: `command not found: chezmoi` after installation

**Solutions**:

1. **Update PATH for current session**:
   ```bash
   export PATH="$HOME/.local/bin:$PATH"
   ```

2. **Restart your shell**:
   ```bash
   exec $SHELL
   ```

3. **Add to shell profile permanently**:
   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

### Installation Script Fails with Permission Denied

**Symptoms**: Permission errors during installation

**Solutions**:

1. **For Linux/macOS - Check script permissions**:
   ```bash
   chmod +x bootstrap.sh
   ```

2. **For Windows - Run PowerShell as Administrator**

3. **Check if running as root (not recommended)**:
   ```bash
   whoami  # Should not be root
   ```

### Curl/Wget Not Available

**Symptoms**: `curl: command not found` or `wget: command not found`

**Solutions**:

**Ubuntu/Debian**:
```bash
sudo apt update
sudo apt install curl wget
```

**Fedora**:
```bash
sudo dnf install curl wget
```

**macOS**:
```bash
# curl is pre-installed, but if needed:
brew install curl wget
```

## Chezmoi Issues

### Changes Not Applied

**Symptoms**: Configuration changes don't appear after running chezmoi

**Solutions**:

1. **Force re-apply**:
   ```bash
   chezmoi apply --force
   ```

2. **Check for differences**:
   ```bash
   chezmoi diff
   ```

3. **Verify source state**:
   ```bash
   chezmoi verify
   ```

4. **Check if file is managed**:
   ```bash
   chezmoi managed
   ```

### Template Errors

**Symptoms**: Errors like `template: ...` or `undefined variable`

**Solutions**:

1. **Check data values**:
   ```bash
   chezmoi data
   ```

2. **Test template rendering**:
   ```bash
   chezmoi execute-template "{{ .email }}"
   ```

3. **View source with data**:
   ```bash
   chezmoi cat ~/.bashrc
   ```

### Age Encryption Errors

**Symptoms**: `age: error` messages or decryption failures

**Solutions**:

1. **Check key file exists**:
   ```bash
   ls -la ~/.config/chezmoi/key.txt
   ```

2. **Verify key permissions**:
   ```bash
   chmod 600 ~/.config/chezmoi/key.txt
   ```

3. **Re-encrypt with correct recipient**:
   ```bash
   chezmoi add --encrypt ~/.ssh/id_rsa
   ```

4. **Disable encryption temporarily**:
   ```bash
   export CHEZMOI_ENCRYPTION=false
   chezmoi init --apply
   ```

## Package Installation Issues

### Package Not Found

**Symptoms**: Package manager can't find specified packages

**Solutions**:

1. **Update package lists**:
   ```bash
   # Ubuntu/Debian
   sudo apt update
   
   # Fedora
   sudo dnf update
   
   # Arch
   sudo pacman -Sy
   ```

2. **Check package name for your distribution**:
   ```bash
   # Search for package
   apt search package-name
   dnf search package-name
   pacman -Ss package-name
   ```

3. **Skip unavailable packages**: Edit package YAML and comment out

### Homebrew Issues (macOS)

**Symptoms**: Homebrew commands fail or not found

**Solutions**:

1. **Install Homebrew**:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Add to PATH** (Apple Silicon):
   ```bash
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

3. **Add to PATH** (Intel):
   ```bash
   eval "$(/usr/local/bin/brew shellenv)"
   ```

4. **Update Homebrew**:
   ```bash
   brew update
   ```

### Winget Issues (Windows)

**Symptoms**: `winget: command not found` or installation failures

**Solutions**:

1. **Install App Installer** from Microsoft Store

2. **Update winget**:
   ```powershell
   winget upgrade --id Microsoft.AppInstaller
   ```

3. **Check Windows version**: Winget requires Windows 10 1809+ or Windows 11

4. **Run as Administrator** for system-wide packages

## Shell Configuration Issues

### Prompt Not Showing Correctly

**Symptoms**: Shell prompt looks wrong or missing features

**Solutions**:

1. **Check Starship installation**:
   ```bash
   which starship
   starship --version
   ```

2. **Reinstall Starship**:
   ```bash
   curl -sS https://starship.rs/install.sh | sh
   ```

3. **Verify prompt initialization in shell config**:
   ```bash
   grep starship ~/.bashrc
   # Should show: eval "$(starship init bash)"
   ```

4. **Restart shell**:
   ```bash
   exec $SHELL
   ```

### Custom Aliases Not Working

**Symptoms**: Aliases defined in dotfiles don't work

**Solutions**:

1. **Check if file exists**:
   ```bash
   ls -la ~/.myscripts/bash_aliases
   ```

2. **Verify file is sourced**:
   ```bash
   grep bash_aliases ~/.bashrc
   ```

3. **Reload shell configuration**:
   ```bash
   source ~/.bashrc
   ```

4. **Check alias syntax**:
   ```bash
   alias  # List all aliases
   ```

### PATH Not Updated

**Symptoms**: Installed tools not found in PATH

**Solutions**:

1. **Check current PATH**:
   ```bash
   echo $PATH
   ```

2. **Manually add to PATH**:
   ```bash
   export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
   ```

3. **Check shell configuration**:
   ```bash
   grep PATH ~/.bashrc
   ```

4. **Restart shell**:
   ```bash
   exec $SHELL
   ```

## Git Configuration Issues

### Git Credentials Not Working

**Symptoms**: Git asks for credentials repeatedly

**Solutions**:

1. **Check git config**:
   ```bash
   git config --list | grep user
   ```

2. **Set credentials**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

3. **Use SSH instead of HTTPS**:
   ```bash
   chezmoi cd
   git remote set-url origin git@github.com:username/repo.git
   ```

### GPG Signing Failures

**Symptoms**: Git commits fail with GPG errors

**Solutions**:

1. **Check GPG key**:
   ```bash
   gpg --list-secret-keys
   ```

2. **Disable signing temporarily**:
   ```bash
   git config --global commit.gpgsign false
   ```

3. **Configure GPG key**:
   ```bash
   git config --global user.signingkey YOUR_KEY_ID
   ```

## Codespace/DevContainer Issues

### Dotfiles Not Applied in Codespace

**Symptoms**: Codespace doesn't have your configuration

**Solutions**:

1. **Check GitHub Codespaces settings**:
   - Go to GitHub Settings → Codespaces
   - Verify dotfiles repository is set
   - Ensure "Automatically install dotfiles" is enabled

2. **Manually apply in running Codespace**:
   ```bash
   chezmoi init --apply https://github.com/lnyousif/dotfiles.git
   ```

3. **Check environment detection**:
   ```bash
   echo $CODESPACES
   echo $REMOTE_CONTAINERS_IPC
   ```

### DevContainer Build Fails

**Symptoms**: VS Code container build errors

**Solutions**:

1. **Check devcontainer.json syntax**:
   - Use VS Code JSON schema validation
   - Verify no trailing commas

2. **Clear container cache**:
   - VS Code: Command Palette → "Dev Containers: Rebuild Container"

3. **Check Docker/Podman status**:
   ```bash
   docker ps  # or podman ps
   ```

4. **View build logs**: Check VS Code Output panel

### Codespace Initialization Slow

**Symptoms**: Setup takes very long in Codespaces

**Solutions**:

1. **Review script efficiency**: Large downloads or complex setups

2. **Use prebuilt containers**: Configure in `.devcontainer/devcontainer.json`

3. **Minimize packages**: Only install essentials for codespaces

4. **Cache dependencies**: Use features instead of manual installation

## VSCode Issues

### Extensions Not Installing

**Symptoms**: VSCode extensions from dotfiles don't install

**Solutions**:

1. **Check VSCode version**: Update to latest

2. **Manually install extension**:
   ```bash
   code --install-extension extension-id
   ```

3. **Check extension ID**: Verify correct format in vscode.yaml

4. **Review extension availability**: Some may not support all platforms

### Settings Not Syncing

**Symptoms**: VSCode settings don't match dotfiles

**Solutions**:

1. **Disable Settings Sync**: Can conflict with dotfiles
   - Settings → Settings Sync → Turn Off

2. **Force apply settings**:
   ```bash
   chezmoi apply --force ~/.config/Code/User/settings.json
   ```

3. **Check file location**:
   - Linux: `~/.config/Code/User/settings.json`
   - macOS: `~/Library/Application Support/Code/User/settings.json`
   - Windows: `%APPDATA%\Code\User\settings.json`

## Platform-Specific Issues

### macOS: Command Line Tools Missing

**Symptoms**: Build failures on macOS

**Solutions**:

```bash
xcode-select --install
```

### Linux: Missing Dependencies

**Symptoms**: Build errors for native packages

**Solutions**:

**Debian/Ubuntu**:
```bash
sudo apt install build-essential
```

**Fedora**:
```bash
sudo dnf groupinstall "Development Tools"
```

**Arch**:
```bash
sudo pacman -S base-devel
```

### Windows: PowerShell Execution Policy

**Symptoms**: Scripts won't run in PowerShell

**Solutions**:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Performance Issues

### Chezmoi Apply Takes Too Long

**Symptoms**: `chezmoi apply` is very slow

**Solutions**:

1. **Apply specific file**:
   ```bash
   chezmoi apply ~/.bashrc
   ```

2. **Skip scripts**:
   ```bash
   chezmoi apply --exclude=scripts
   ```

3. **Check for network operations**: Some scripts may download

### Shell Startup Slow

**Symptoms**: Opening terminal takes several seconds

**Solutions**:

1. **Profile shell startup**:
   ```bash
   time bash -i -c exit
   ```

2. **Disable slow initializations**: Comment out in ~/.bashrc

3. **Use async loading**: For NVM, etc.

## Debug Mode

### Enable Verbose Output

For detailed debugging:

```bash
chezmoi apply -v
chezmoi apply -vv  # Very verbose
chezmoi apply -vvv  # Extremely verbose
```

### Check Chezmoi Doctor

Run diagnostics:

```bash
chezmoi doctor
```

### View Source Directory

Navigate to source:

```bash
chezmoi cd
```

## Getting More Help

If issues persist:

1. **Check logs**: Review command output for errors
2. **Search issues**: [GitHub Issues](https://github.com/lnyousif/dotfiles/issues)
3. **Open issue**: Provide OS, shell version, error messages
4. **Chezmoi docs**: [https://www.chezmoi.io/](https://www.chezmoi.io/)

## Emergency Reset

If everything is broken:

```bash
# Backup current state
cp -r ~/.local/share/chezmoi ~/chezmoi-backup

# Remove chezmoi completely
chezmoi purge
rm -rf ~/.local/share/chezmoi
rm -rf ~/.config/chezmoi

# Reinstall from scratch
# Use installation command from README
```
