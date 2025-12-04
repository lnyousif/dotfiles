# Features Overview

Complete overview of features available in these dotfiles.

## Core Features

### 🚀 Cross-Platform Support

**Supported Platforms:**
- Linux (Ubuntu, Debian, Fedora, Arch, Alpine)
- macOS (Intel & Apple Silicon)
- Windows (Native & WSL)
- GitHub Codespaces
- VS Code DevContainers

**Automatic Detection:**
- Platform-specific configurations
- Package manager selection
- Environment adaptation

### 🛠️ Smart Installation

**One-Command Setup:**
```bash
# Single command installs everything
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply lnyousif
```

**Intelligent Prompts:**
- Setup type selection
- Feature configuration
- Encryption preferences
- Network configuration

**Non-Interactive Mode:**
```bash
export CHEZMOI_SETUP_TYPE="development"
# Skips prompts, uses environment variables
```

### 📦 Package Management

**Unified Package Definition:**
- YAML-based configuration
- Platform-specific packages
- Automatic installation
- Removal of bloatware

**Supported Package Managers:**
- apt (Debian/Ubuntu)
- dnf (Fedora/RHEL)
- pacman (Arch)
- apk (Alpine)
- brew (macOS)
- winget (Windows)
- pip/pipx (Python)
- npm/pnpm (Node.js)

## Shell Enhancements

### 🎨 Starship Prompt

**Features:**
- Beautiful, informative prompt
- Git status integration
- Language version display
- Command duration
- Error indicators
- Highly customizable

**Supported Shells:**
- Bash
- Zsh
- PowerShell
- Fish (can be added)

### 💻 Terminal Configuration

**Tmux Setup:**
- Modern key bindings
- Better color scheme
- Plugin management (TPM)
- Mouse support
- Clipboard integration

**Shell Features:**
- Custom aliases
- Useful functions
- Intelligent PATH management
- Tool initialization (NVM, PNPM)

## Development Tools

### 🐳 Container Support

**Podman Configuration:**
- Rootless containers
- Docker-compatible
- Compose support
- VSCode integration

**DevContainer Features:**
- Automatic dotfiles application
- Project-specific templates
- Feature-based setup
- Fast initialization

### 🤖 AI Assistant Integration

**GitHub Copilot:**
- VSCode extension
- Chat integration
- Code suggestions
- Inline completions

**Gemini CLI:**
- Command-line AI
- Code generation
- Quick queries

### 🔧 Code Quality Tools

**Pre-commit Hooks:**
- Automatic linting
- Format checking
- Commit message validation
- Custom hooks

**Commitizen:**
- Structured commits
- Changelog generation
- Version management
- Conventional commits

**Testing:**
- Act (GitHub Actions locally)
- Language-specific test runners
- CI/CD integration

## Editor Configuration

### 💼 VSCode Setup

**Settings Sync:**
- Consistent across machines
- Platform-specific overrides
- Extension management
- Workspace settings

**Extensions:**
- Copilot & Copilot Chat
- Language support
- Dev tools
- Quality of life improvements

**Theme & UI:**
- Material Icon Theme
- Tomorrow Night Blue
- Minimal distractions
- Optimized workflow

### ⌨️ Terminal Editor

**Micro:**
- Modern keybindings
- Syntax highlighting
- Plugin support
- Mouse support
- Multi-cursor editing

## Security Features

### 🔐 Encryption

**Age Integration:**
- Modern encryption tool
- SSH key encryption
- Secret file protection
- Automatic decryption

**Encrypted Files:**
- SSH keys
- GPG keys
- API tokens
- Configuration secrets

### 🔑 Password Management

**KeePassXC:**
- Secure password storage
- Chezmoi integration
- Database encryption
- Keyfile support

**Git Credentials:**
- Credential helper
- SSH key management
- GPG signing
- Token authentication

## Git Configuration

### 📝 Enhanced Git

**Global Configuration:**
- User information
- Signing key setup
- Merge strategies
- Alias definitions

**Useful Aliases:**
```bash
git lg    # Beautiful log view
git st    # Status
git co    # Checkout
git br    # Branch
```

**Security:**
- GPG commit signing
- SSH authentication
- Credential caching
- Safe default behaviors

## Network Features

### 🌐 Dynamic DNS

**Cloudflare Integration:**
- Automatic IP updates
- IPv4 and IPv6 support
- Template-based config
- Scheduled updates

### 🔌 Network Node Setup

**SSH Server:**
- Secure configuration
- Key-based authentication
- Port configuration
- Firewall rules

**Hub Configuration:**
- Central access point
- Key distribution
- Network management
- Service hosting

## Platform-Specific Features

### 🐧 Linux Features

**Desktop Environment:**
- Remove bloatware
- Optimize performance
- Keyboard shortcuts
- System settings

**Package Optimization:**
- Faster downloads (dnf)
- Parallel operations
- Mirror selection
- Cache management

**Repository Setup:**
- Additional repos (Chaotic AUR)
- Third-party sources
- GPG key management

### 🍎 macOS Features

**System Defaults:**
- Keyboard settings
- Trackpad configuration
- Dock preferences
- Finder settings
- Mission Control
- Hot corners

**Homebrew:**
- Auto-installation
- PATH configuration
- Cask support
- Services management

### 🪟 Windows Features

**PowerShell Profile:**
- Custom prompt
- Aliases
- Functions
- Module loading

**Windows Terminal:**
- Theme configuration
- Profile settings
- Key bindings
- Appearance

**WSL Integration:**
- Shared Git config
- Cross-platform tools
- File system access

## Codespace/Container Features

### ☁️ Codespace Optimizations

**Fast Startup:**
- Minimal installation
- Essential tools only
- Cached dependencies
- Parallel operations

**Automatic Configuration:**
- Git setup
- GPG signing
- Aliases
- Environment variables

**Project Integration:**
- Workspace folder alias
- Project-specific setup
- Custom scripts
- Team settings

### 🐳 DevContainer Support

**Template Library:**
- Node.js
- Python
- Universal
- Language-specific

**VS Code Integration:**
- Settings sync
- Extension installation
- Port forwarding
- Terminal config

**Feature-Based:**
- Modular installation
- Version pinning
- Dependency management
- Custom features

## Setup Types

### 🎯 Basic Setup

**Minimal Configuration:**
- Essential tools only
- Shell enhancements
- Git configuration
- Basic utilities

**Use Cases:**
- Personal machines
- Minimal environments
- Quick setup
- Testing

### 💻 Development Setup

**Full Toolkit:**
- All basic features
- Container tools
- Code quality tools
- AI assistants
- Additional languages

**Use Cases:**
- Development workstations
- Programming projects
- Full-time development
- Multiple languages

### 👨‍👩‍👧‍👦 Kids Setup

**Safe Configuration:**
- Simplified interface
- Restricted features
- No encryption
- Parental controls

**Use Cases:**
- Family computers
- Educational systems
- Shared machines
- Learning environments

### 💼 Work Setup

**Professional Environment:**
- No personal secrets
- Company-compliant
- Encryption disabled
- Work tools focus

**Use Cases:**
- Company laptops
- Corporate networks
- Compliance requirements
- Team environments

## Customization Options

### 🎨 Theme Customization

**Prompt:**
- Starship configuration
- Color schemes
- Symbols
- Module selection

**Editor:**
- VSCode themes
- Syntax highlighting
- Icon themes
- UI preferences

### ⚙️ Behavior Customization

**Shell:**
- Custom aliases
- Functions
- Environment variables
- Tool initialization

**Editor:**
- Key bindings
- Settings
- Extensions
- Snippets

### 📦 Package Customization

**Add Packages:**
Edit `home/.chezmoidata/packages/{setup}/{platform}.yaml`

**Remove Packages:**
Comment out or delete entries

**Platform-Specific:**
Separate files for each OS

## Advanced Features

### 🔄 Automatic Updates

**Chezmoi Updates:**
```bash
chezmoi update  # Pull and apply changes
```

**Package Updates:**
- Platform-specific commands
- Scheduled updates
- Security patches

### 🔍 State Management

**Version Control:**
- All configs tracked
- Change history
- Easy rollback
- Branch workflows

**Diff Viewing:**
```bash
chezmoi diff    # See pending changes
chezmoi status  # Check managed files
```

### 🧪 Testing

**Local Testing:**
- Safe apply (--dry-run)
- Diff before apply
- Selective application
- Rollback support

**Container Testing:**
- Clean environments
- Multiple platforms
- Isolated testing
- Quick iterations

## Documentation

### 📚 Comprehensive Guides

**Available Documentation:**
- Quick Start Guide
- DevContainer Setup
- Environment Reference
- Troubleshooting Guide
- Cross-Platform Guide
- Contributing Guide

**Examples:**
- DevContainer templates
- Configuration samples
- Script examples
- Use case scenarios

### 🆘 Support Resources

**Troubleshooting:**
- Common issues
- Platform-specific problems
- Error solutions
- Debug commands

**Community:**
- GitHub Issues
- Discussions
- Pull Requests
- Contributing

## Performance

### ⚡ Fast Installation

**Optimizations:**
- Parallel downloads
- Cached packages
- Minimal prompts
- Smart detection

**Benchmarks:**
- Basic: ~2-5 minutes
- Development: ~10-15 minutes
- Codespace: ~3-7 minutes

### 💾 Storage Efficient

**Minimal Footprint:**
- Essential tools only
- No redundant packages
- Cleanup of bloatware
- Efficient configs

## Maintenance

### 🔧 Easy Updates

**Simple Commands:**
```bash
chezmoi update        # Update dotfiles
chezmoi apply         # Apply changes
chezmoi diff          # View differences
```

**Automatic:**
- Configuration sync
- Package updates
- Security patches

### 🧹 Cleanup

**Remove Bloatware:**
- Platform-specific junk
- Unnecessary apps
- Default bloat

**Maintain Order:**
- Organized structure
- Clear naming
- Documentation
- Version control

## Future Features

### 🚀 Planned

- Additional language templates
- More devcontainer examples
- Improved documentation
- Video tutorials
- Community templates

### 💡 Ideas Welcome

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to suggest features!
