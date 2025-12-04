# Documentation Index

Welcome to the dotfiles documentation! This index helps you find the right guide for your needs.

## Getting Started

**New to these dotfiles?** Start here:

1. 📖 [Quick Start Guide](QUICK_START.md) - Installation and first steps
2. ⭐ [Features Overview](FEATURES.md) - What's included in these dotfiles

## Setup Guides

Choose your environment:

- 🐳 [DevContainer Setup](DEVCONTAINER_SETUP.md) - VS Code DevContainers & GitHub Codespaces
- 🌍 [Cross-Platform Guide](CROSS_PLATFORM.md) - Platform-specific details and compatibility

## Reference Documentation

**Need detailed information?**

- 🔧 [Environment Reference](ENVIRONMENT_REFERENCE.md) - All configuration variables and options
- 🔍 [Troubleshooting Guide](TROUBLESHOOTING.md) - Common issues and solutions

## Contributing

**Want to help improve these dotfiles?**

- 🤝 [Contributing Guide](../CONTRIBUTING.md) - How to contribute effectively

## Quick Links by Task

### Installation
- [One-line install](QUICK_START.md#-one-line-install)
- [Platform-specific install](QUICK_START.md#-platform-specific-scripts)
- [Codespace setup](DEVCONTAINER_SETUP.md#for-github-codespaces)
- [DevContainer setup](DEVCONTAINER_SETUP.md#for-vs-code-devcontainers)

### Configuration
- [Environment variables](ENVIRONMENT_REFERENCE.md#environment-variables)
- [Setup types](ENVIRONMENT_REFERENCE.md#setup-type)
- [Feature flags](ENVIRONMENT_REFERENCE.md#feature-flags)
- [Package customization](FEATURES.md#-package-customization)

### Troubleshooting
- [Installation issues](TROUBLESHOOTING.md#installation-issues)
- [Chezmoi issues](TROUBLESHOOTING.md#chezmoi-issues)
- [Package problems](TROUBLESHOOTING.md#package-installation-issues)
- [Platform-specific](TROUBLESHOOTING.md#platform-specific-issues)

### Platform Support
- [Linux](CROSS_PLATFORM.md#linux)
- [macOS](CROSS_PLATFORM.md#macos)
- [Windows](CROSS_PLATFORM.md#windows)
- [Codespaces](CROSS_PLATFORM.md#github-codespaces)
- [DevContainers](CROSS_PLATFORM.md#devcontainers-vs-code)

### Development
- [DevContainer templates](../examples/devcontainer/)
- [Adding packages](ENVIRONMENT_REFERENCE.md#customization-points)
- [Custom scripts](ENVIRONMENT_REFERENCE.md#script-execution-order)
- [VSCode config](ENVIRONMENT_REFERENCE.md#vscode-configuration)

## Documentation Structure

```
docs/
├── INDEX.md                    # This file - documentation index
├── QUICK_START.md             # Installation and basic usage
├── FEATURES.md                # Complete features list
├── DEVCONTAINER_SETUP.md      # DevContainer & Codespace guide
├── ENVIRONMENT_REFERENCE.md   # Configuration reference
├── TROUBLESHOOTING.md         # Problem solving
└── CROSS_PLATFORM.md          # Platform compatibility
```

## By User Type

### 🆕 First-Time User
1. [Quick Start Guide](QUICK_START.md)
2. [Features Overview](FEATURES.md)
3. Choose your [setup type](ENVIRONMENT_REFERENCE.md#setup-type-details)

### 💻 Developer
1. [DevContainer Setup](DEVCONTAINER_SETUP.md)
2. [Development features](FEATURES.md#development-tools)
3. [VSCode configuration](ENVIRONMENT_REFERENCE.md#vscode-configuration)

### 🔧 Power User
1. [Environment Reference](ENVIRONMENT_REFERENCE.md)
2. [Cross-Platform Guide](CROSS_PLATFORM.md)
3. [Customization options](FEATURES.md#customization-options)

### 🤝 Contributor
1. [Contributing Guide](../CONTRIBUTING.md)
2. [Platform considerations](CROSS_PLATFORM.md#platform-detection-examples)
3. [Testing guidelines](../CONTRIBUTING.md#testing)

## Common Questions

### How do I...

**Install on a new machine?**
→ See [Quick Start Guide](QUICK_START.md#installation-methods)

**Use with Codespaces?**
→ See [DevContainer Setup](DEVCONTAINER_SETUP.md#for-github-codespaces)

**Customize packages?**
→ See [Features Overview](FEATURES.md#-package-customization)

**Fix installation errors?**
→ See [Troubleshooting Guide](TROUBLESHOOTING.md#installation-issues)

**Understand environment variables?**
→ See [Environment Reference](ENVIRONMENT_REFERENCE.md#environment-variables)

**Add support for my platform?**
→ See [Contributing Guide](../CONTRIBUTING.md) and [Cross-Platform Guide](CROSS_PLATFORM.md)

**Configure for work?**
→ See [Setup Types](ENVIRONMENT_REFERENCE.md#setup-type-details) - use "work" type

**Use different shells?**
→ See [Shell Configuration](ENVIRONMENT_REFERENCE.md#shell-configuration)

## Examples

Real-world examples and templates:

- [Node.js DevContainer](../examples/devcontainer/nodejs-devcontainer.json)
- [Python DevContainer](../examples/devcontainer/python-devcontainer.json)
- [Universal DevContainer](../examples/devcontainer/universal-devcontainer.json)

More examples in the [examples directory](../examples/).

## External Resources

### Tools
- [Chezmoi Documentation](https://www.chezmoi.io/)
- [Starship Prompt](https://starship.rs/)
- [Tmux Guide](https://github.com/tmux/tmux/wiki)
- [Micro Editor](https://micro-editor.github.io/)

### Containers
- [DevContainers Spec](https://containers.dev/)
- [VS Code DevContainers](https://code.visualstudio.com/docs/devcontainers/containers)
- [GitHub Codespaces](https://docs.github.com/en/codespaces)
- [Podman Documentation](https://podman.io/)

### Package Managers
- [Homebrew](https://brew.sh/)
- [Winget](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
- [apt](https://ubuntu.com/server/docs/package-management)
- [dnf](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)

## Getting Help

Can't find what you need?

1. **Check documentation** - Use this index to find the right guide
2. **Search issues** - [GitHub Issues](https://github.com/lnyousif/dotfiles/issues)
3. **Ask a question** - [GitHub Discussions](https://github.com/lnyousif/dotfiles/discussions)
4. **Report a bug** - [New Issue](https://github.com/lnyousif/dotfiles/issues/new)

## Documentation Updates

This documentation is actively maintained. Last major update: December 2025

Found an error or want to improve the docs? See [Contributing Guide](../CONTRIBUTING.md#documentation-standards).

---

**Quick Links:**
[Main README](../Readme.md) |
[Quick Start](QUICK_START.md) |
[Features](FEATURES.md) |
[Contributing](../CONTRIBUTING.md)
