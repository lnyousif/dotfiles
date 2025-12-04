# DevContainer Setup Guide

This guide explains how to use these dotfiles with VS Code DevContainers and GitHub Codespaces.

## Quick Start

### For GitHub Codespaces

1. **Create a Codespace** from your repository
2. **Dotfiles are automatically applied** - GitHub will automatically clone and apply these dotfiles
3. **Wait for setup to complete** - The initialization script will configure your environment

### For VS Code DevContainers

1. **Add devcontainer configuration** to your project (see templates below)
2. **Open in container** using VS Code's "Reopen in Container" command
3. **Dotfiles are applied** automatically if you've configured your GitHub settings

## Configuration

### GitHub Codespaces Settings

To ensure your dotfiles are automatically applied in Codespaces:

1. Go to **GitHub Settings** → **Codespaces**
2. Set **Dotfiles repository** to: `lnyousif/dotfiles`
3. Set **Install command** to: `./bootstrap.sh`
4. Enable **Automatically install dotfiles**

### DevContainer Template

Create a `.devcontainer/devcontainer.json` file in your project:

```json
{
  "name": "Development Container",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  
  // Features to install
  "features": {
    "ghcr.io/devcontainers/features/git:1": {},
    "ghcr.io/devcontainers/features/github-cli:1": {},
    "ghcr.io/devcontainers/features/node:1": {
      "version": "lts"
    }
  },
  
  // Dotfiles configuration
  "dotfiles": {
    "repository": "lnyousif/dotfiles",
    "installCommand": "bootstrap.sh"
  },
  
  // VS Code customizations
  "customizations": {
    "vscode": {
      "settings": {
        "terminal.integrated.defaultProfile.linux": "bash"
      },
      "extensions": [
        "github.copilot",
        "github.copilot-chat",
        "esbenp.prettier-vscode"
      ]
    }
  },
  
  // Container user configuration
  "remoteUser": "vscode",
  
  // Post-create commands
  "postCreateCommand": "echo 'Container setup complete!'"
}
```

## Environment Detection

These dotfiles automatically detect when running in:

- **GitHub Codespaces** - via `$CODESPACES` environment variable
- **VS Code Remote Containers** - via `$REMOTE_CONTAINERS_IPC` environment variable
- **Special users** - vagrant, vscode usernames

When detected, the configuration:
- Disables encryption (ephemeral environment)
- Sets up development tools appropriately
- Configures headless operation
- Uses sudo for package installation

## Codespace-Specific Features

### Automatic Git Configuration

The codespace initialization script configures:
- Git user name and email
- GPG signing (with your key)
- Useful Git aliases
- Core settings for better workflow

### Environment Aliases

Automatically added to your shell:
- `proj` - Navigate to your project folder
- `refresh` - Reload shell configuration

### Project Setup Integration

If your project has a `.devcontainer/project-setup.sh` script, it will be automatically executed during initialization.

## Customization

### Environment Variables

You can customize the setup using environment variables:

```bash
export CHEZMOI_NAME="Your Name"
export CHEZMOI_EMAIL="your.email@example.com"
export CHEZMOI_SETUP_TYPE="development"  # basic, kids, development, work
export CHEZMOI_ENCRYPTION=false
export CHEZMOI_PASS_MANAGER=false
```

### Setup Types

- **basic** - Minimal setup with essential tools
- **development** - Full development environment with additional tools
- **kids** - Kid-friendly setup with restrictions
- **work** - Work environment configuration

## Troubleshooting

### Dotfiles Not Applied

1. Check GitHub Codespaces settings
2. Verify dotfiles repository URL is correct
3. Check that bootstrap.sh is executable
4. Review Codespace logs for errors

### Missing Tools

If tools are missing after setup:
```bash
chezmoi apply -v
```

### Update Dotfiles in Running Container

```bash
chezmoi update
```

### Check Codespace Detection

```bash
echo $CODESPACES
echo $REMOTE_CONTAINERS_IPC
```

## Advanced Usage

### Custom DevContainer Features

You can extend the base configuration with additional features:

```json
"features": {
  "ghcr.io/devcontainers/features/docker-in-docker:1": {},
  "ghcr.io/devcontainers/features/python:1": {
    "version": "3.11"
  }
}
```

### Mount Local SSH Keys

To use your SSH keys in the container:

```json
"mounts": [
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.ssh,target=/home/vscode/.ssh,readonly,type=bind"
]
```

### Environment-Specific Overrides

Create different configurations for different projects by placing setup scripts in:
```
.devcontainer/project-setup.sh
```

## Best Practices

1. **Keep devcontainer.json minimal** - Let dotfiles handle most configuration
2. **Use features for tools** - Install language runtimes via devcontainer features
3. **Test locally first** - Use VS Code's devcontainer to test before pushing
4. **Pin versions** - Specify exact versions for reproducibility
5. **Document custom setup** - Add project-specific notes to your README

## Resources

- [DevContainers Documentation](https://containers.dev/)
- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)
- [Chezmoi Documentation](https://www.chezmoi.io/)
