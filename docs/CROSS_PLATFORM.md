# Cross-Platform Compatibility Guide

This guide explains how these dotfiles work across different platforms and environments.

## Platform Support Matrix

| Feature | Linux | macOS | Windows | Codespaces | DevContainers |
|---------|-------|-------|---------|------------|---------------|
| Shell (Bash) | ✅ | ✅ | ✅ (WSL) | ✅ | ✅ |
| Shell (Zsh) | ✅ | ✅ | ❌ | ✅ | ✅ |
| Starship Prompt | ✅ | ✅ | ✅ | ✅ | ✅ |
| Tmux | ✅ | ✅ | ✅ (WSL) | ✅ | ✅ |
| Micro Editor | ✅ | ✅ | ✅ | ✅ | ✅ |
| VSCode Settings | ✅ | ✅ | ✅ | ✅ | ✅ |
| Git Configuration | ✅ | ✅ | ✅ | ✅ | ✅ |
| Encryption (Age) | ✅ | ✅ | ✅ | ⚠️ | ⚠️ |
| Password Manager | ✅ | ✅ | ✅ | ❌ | ❌ |
| Container Tools | ✅ | ✅ | ✅ (WSL) | ✅ | N/A |

✅ Fully Supported | ⚠️ Limited/Optional | ❌ Not Available

## Platform-Specific Behaviors

### Linux

**Package Managers Supported:**
- **Debian/Ubuntu**: apt
- **Fedora/RHEL**: dnf
- **Arch Linux**: pacman
- **Alpine**: apk

**Shell Configuration:**
- Default: Bash
- Starship prompt auto-configured
- Custom functions in `~/.myscripts/`

**File Locations:**
```
~/.config/           # Application configs
~/.local/bin/        # User executables
~/.bashrc            # Bash configuration
~/.zshrc             # Zsh configuration (if installed)
```

### macOS

**Package Manager:**
- **Homebrew**: Automatically installed if missing
- Supports both Intel and Apple Silicon

**Shell Configuration:**
- Default: Zsh (macOS Catalina+)
- Starship prompt configured
- Homebrew in PATH automatically

**File Locations:**
```
~/Library/                           # Application settings
~/.config/                          # XDG config (modern apps)
~/.zshrc                            # Zsh configuration
/opt/homebrew/                      # Apple Silicon Homebrew
/usr/local/                         # Intel Homebrew
```

**macOS-Specific Features:**
- System defaults configuration
- Keyboard and trackpad settings
- Dock and Finder optimizations
- Notification center preferences

### Windows

**Package Manager:**
- **Winget**: Microsoft's official package manager
- PowerShell-based installation

**Shell Configuration:**
- PowerShell profile configured
- Starship prompt for PowerShell
- Git Bash supported

**File Locations:**
```
%USERPROFILE%\AppData\Roaming\Code\  # VSCode settings
%USERPROFILE%\Documents\PowerShell\  # PowerShell profile
C:\Users\<username>\.config\         # Some configs (Git, etc.)
```

**Windows-Specific Features:**
- Windows Terminal configuration
- WSL integration
- PowerShell profile with aliases
- Windows-specific package management

**WSL Notes:**
- Linux dotfiles work in WSL
- Separate Windows and WSL configurations
- Can share Git credentials between Windows and WSL

### GitHub Codespaces

**Environment:**
- Ubuntu-based Linux container
- Runs as `codespace` user
- Full sudo access

**Automatic Detection:**
```bash
$CODESPACES = "true"
```

**Optimizations:**
- Ephemeral mode (no encryption)
- Headless configuration
- Minimal package installation
- Fast startup focus

**Special Features:**
- Project folder alias (`proj`)
- GitHub CLI pre-configured
- Dotfiles auto-applied on creation
- Git configured automatically

### DevContainers (VS Code)

**Environment:**
- Various base images supported
- Typically runs as `vscode` user
- May have sudo access

**Automatic Detection:**
```bash
$REMOTE_CONTAINERS_IPC != ""
# or username in ["vscode", "vagrant"]
```

**Optimizations:**
- Container-optimized configuration
- Minimal tool installation
- Fast rebuild times
- Integration with VS Code

## File Path Compatibility

### Cross-Platform Paths

These dotfiles use platform-appropriate paths:

```bash
# Linux/macOS
~/.config/app/config.json
~/.local/bin/script

# Windows
%APPDATA%\app\config.json
%LOCALAPPDATA%\Programs\script.exe
```

### Chezmoi Path Translation

Chezmoi automatically handles platform differences:

```
home/dot_config/              → ~/.config/ (Linux/macOS)
home/private_AppData/         → %APPDATA% (Windows)
home/private_Library/         → ~/Library/ (macOS)
```

## Line Endings

Git is configured to handle line endings correctly:

```gitconfig
[core]
    autocrlf = false  # Let Git handle it automatically
```

For shell scripts, use LF (Unix) line endings on all platforms.

## Shell Compatibility

### Bash vs Zsh

**Bash (Linux, macOS, WSL, Containers)**
- Template: `home/.chezmoitemplates/bashrc`
- Portable across Unix-like systems
- Used in most containers and codespaces

**Zsh (macOS default)**
- Template: `home/.chezmoitemplates/mac_zshrc`
- Similar configuration to Bash
- macOS Catalina+ default shell

**PowerShell (Windows)**
- Separate profile configuration
- Starship integration
- Windows-specific aliases

### Shared Shell Features

All shells include:
- Starship prompt
- Custom PATH configuration
- Useful aliases
- Environment variable exports
- Tool initialization (NVM, etc.)

## Package Name Differences

Some packages have different names across platforms:

| Tool | Linux (apt) | macOS (brew) | Windows (winget) |
|------|-------------|--------------|------------------|
| Clipboard | xclip | pbcopy/pbpaste | clip |
| Container | podman | podman | docker |
| Browser | chromium | chromium | Google.Chrome |
| Password Manager | keepassxc | keepassxc | KeePassXCTeam.KeePassXC |

These differences are handled in platform-specific package files.

## Environment Variables

### Cross-Platform Variables

```bash
# Works everywhere
$HOME                 # User home directory
$USER / $USERNAME     # Current user
$PATH                 # Executable search path
```

### Platform-Specific

**Unix (Linux/macOS):**
```bash
$SHELL               # Current shell
$XDG_CONFIG_HOME     # ~/.config
```

**Windows:**
```powershell
$env:USERPROFILE     # C:\Users\Username
$env:APPDATA         # Roaming app data
$env:LOCALAPPDATA    # Local app data
```

### Chezmoi Variables

Available in all templates:

```
{{ .chezmoi.os }}            # linux, darwin, windows
{{ .chezmoi.arch }}          # amd64, arm64, etc.
{{ .chezmoi.username }}      # Current user
{{ .chezmoi.hostname }}      # Machine hostname
{{ .chezmoi.homeDir }}       # Home directory path
```

## Container Considerations

### File System Differences

Containers may have:
- Limited file system access
- Different user IDs/permissions
- Mounted volumes from host
- Ephemeral storage

### Network Differences

Containers typically:
- Have isolated network
- Port forwarding required
- May have restricted internet
- Can access local services via host

### Tool Availability

In containers:
- GUI apps not available
- Some system tools missing
- Language runtimes pre-installed
- Docker-in-Docker may be needed

## Testing Across Platforms

### Local Testing

**Linux:**
```bash
./bootstrap.sh
# Test in VM if needed
```

**macOS:**
```bash
./home/mac-install.sh
# Test on Intel and Apple Silicon if possible
```

**Windows:**
```powershell
.\home\win-install.ps1
# Test in PowerShell 5.1 and 7+
```

### Container Testing

**Create test container:**
```bash
docker run -it --rm ubuntu:latest bash
# Then run installation
```

**Test in Codespace:**
1. Create new Codespace
2. Configure dotfiles in GitHub settings
3. Verify automatic application

**Test in DevContainer:**
1. Use example template
2. Open in VS Code
3. Select "Reopen in Container"
4. Verify setup completes

## Troubleshooting Platform Issues

### Path Issues

**Problem**: Command not found after installation

**Solution**:
```bash
# Check PATH
echo $PATH

# Add to PATH temporarily
export PATH="$HOME/.local/bin:$PATH"

# Add permanently to shell config
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

### Permission Issues

**Problem**: Cannot write to directories

**Solution**:
```bash
# Fix ownership (Linux/macOS)
sudo chown -R $USER:$USER ~/.local

# Check permissions
ls -la ~/.local/bin
```

### Package Manager Issues

**Problem**: Package manager not found

**Solution**:
```bash
# Install package manager first
# See platform-specific sections above
```

### Line Ending Issues

**Problem**: Script fails with `\r` errors

**Solution**:
```bash
# Convert to Unix line endings
dos2unix script.sh
# or
sed -i 's/\r$//' script.sh
```

## Migration Guide

### From Linux to macOS

1. Run macOS installation
2. Homebrew replaces apt
3. Most configs work unchanged
4. Shell switches from Bash to Zsh

### From macOS to Linux

1. Run Linux installation
2. Package manager auto-detected
3. Remove macOS-specific settings
4. Bash becomes default shell

### From Windows to WSL

1. Install WSL first
2. Run Linux installation in WSL
3. Windows and WSL configs separate
4. Can share Git config

### To Codespace/Container

1. Configure dotfiles in GitHub
2. Automatic application
3. Ephemeral mode activated
4. Minimal configuration applied

## Best Practices

1. **Test incrementally**: Apply changes on one platform first
2. **Use templates**: Leverage Chezmoi templates for platform-specific config
3. **Check detection**: Verify platform auto-detection works
4. **Document differences**: Note platform-specific requirements
5. **Keep it simple**: Avoid over-complicating cross-platform logic

## Platform Detection Examples

### In Templates

```go
{{- if eq .chezmoi.os "linux" -}}
# Linux-specific configuration
{{- else if eq .chezmoi.os "darwin" -}}
# macOS-specific configuration
{{- else if eq .chezmoi.os "windows" -}}
# Windows-specific configuration
{{- end -}}
```

### In Scripts

```bash
case "$(uname -s)" in
    Linux*)     echo "Linux detected" ;;
    Darwin*)    echo "macOS detected" ;;
    CYGWIN*|MINGW*|MSYS*) echo "Windows detected" ;;
esac
```

## Additional Resources

- [Chezmoi Platform Docs](https://www.chezmoi.io/reference/templates/functions/)
- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [Homebrew Documentation](https://docs.brew.sh/)
- [Winget Documentation](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
