# DevContainer Examples

This directory contains example DevContainer configurations that integrate with these dotfiles.

## Available Templates

### 1. Node.js Development Container
**File**: `nodejs-devcontainer.json`

A complete setup for Node.js development with:
- Latest LTS Node.js version
- Git and GitHub CLI
- ESLint and Prettier
- GitHub Copilot
- Automatic npm install

**Best for**: Web applications, JavaScript/TypeScript projects

### 2. Python Development Container
**File**: `python-devcontainer.json`

Python development environment with:
- Python 3.11
- Docker-in-Docker support
- Pylint and Black formatter
- Git tools
- GitHub Copilot

**Best for**: Python applications, data science projects, ML/AI work

### 3. Universal Development Container
**File**: `universal-devcontainer.json`

Multi-language development with:
- Node.js (LTS)
- Python 3.11
- Go (latest)
- Docker-in-Docker
- Git and GitHub CLI

**Best for**: Polyglot projects, experimentation, learning

## How to Use

### Option 1: Copy to Your Project

1. Create `.devcontainer` directory in your project:
   ```bash
   mkdir .devcontainer
   ```

2. Copy desired template:
   ```bash
   cp nodejs-devcontainer.json .devcontainer/devcontainer.json
   ```

3. Customize as needed (ports, extensions, commands)

4. Open in VS Code and select "Reopen in Container"

### Option 2: Use with GitHub Codespaces

1. Add `.devcontainer/devcontainer.json` to your repository
2. Create a new Codespace
3. Configuration applies automatically

## Customization Guide

### Adding More Features

Explore available features at [containers.dev/features](https://containers.dev/features):

```json
"features": {
  "ghcr.io/devcontainers/features/rust:1": {
    "version": "latest"
  },
  "ghcr.io/devcontainers/features/terraform:1": {
    "version": "latest"
  }
}
```

### Forwarding Ports

For web applications:

```json
"forwardPorts": [3000, 8080, 5173],
"portsAttributes": {
  "3000": {
    "label": "Application",
    "onAutoForward": "notify"
  }
}
```

### Adding VS Code Extensions

```json
"customizations": {
  "vscode": {
    "extensions": [
      "your-extension-id"
    ]
  }
}
```

Find extension IDs in VS Code Extensions panel.

### Environment Variables

Set environment variables for the container:

```json
"containerEnv": {
  "MY_VAR": "value",
  "NODE_ENV": "development"
}
```

### Post-Creation Commands

Run commands after container creation:

```json
"postCreateCommand": "npm install && npm run setup"
```

Multiple commands:

```json
"postCreateCommand": "npm install && pip install -r requirements.txt && ./setup.sh"
```

### Mounting Local Files

Mount SSH keys or configuration:

```json
"mounts": [
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.ssh,target=/home/vscode/.ssh,readonly,type=bind",
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.gitconfig,target=/home/vscode/.gitconfig,type=bind"
]
```

### Using Different Base Images

Popular base images:

```json
// Debian-based
"image": "mcr.microsoft.com/devcontainers/base:debian"

// Ubuntu-based
"image": "mcr.microsoft.com/devcontainers/base:ubuntu"

// Alpine (lightweight)
"image": "mcr.microsoft.com/devcontainers/base:alpine"

// Language-specific
"image": "mcr.microsoft.com/devcontainers/typescript-node:lts"
```

## Dotfiles Integration

All templates include:

```json
"dotfiles": {
  "repository": "lnyousif/dotfiles",
  "installCommand": "bootstrap.sh"
}
```

This ensures your personal configuration is applied automatically.

### Disabling Dotfiles

If you want to skip dotfiles for a specific project:

```json
"dotfiles": {
  "repository": "",
  "installCommand": ""
}
```

## Advanced Configurations

### Multi-Container Setup

For projects needing multiple services:

```json
"dockerComposeFile": "docker-compose.yml",
"service": "app",
"workspaceFolder": "/workspace"
```

### Custom Dockerfile

For more control:

```json
"build": {
  "dockerfile": "Dockerfile",
  "context": ".."
},
"workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind",
"workspaceFolder": "/workspace"
```

### Lifecycle Scripts

Run scripts at different stages:

```json
"initializeCommand": "echo 'Before container is created'",
"onCreateCommand": "echo 'Right after container is created'",
"updateContentCommand": "echo 'When container content changes'",
"postCreateCommand": "echo 'After everything is set up'",
"postStartCommand": "echo 'Each time container starts'",
"postAttachCommand": "echo 'When you attach to container'"
```

## Testing Your Configuration

### Local Testing

1. Open project in VS Code
2. Press `F1` (Command Palette)
3. Select "Dev Containers: Reopen in Container"
4. Wait for build and initialization
5. Verify tools are installed

### Debugging Build Issues

View logs:
- Check VS Code "Dev Containers" output panel
- Look for error messages during build
- Verify feature syntax and names

Common issues:
- Invalid JSON syntax
- Missing features
- Network timeouts
- Permission errors

## Best Practices

1. **Start Simple**: Begin with basic template, add features incrementally
2. **Pin Versions**: Specify exact versions for reproducibility
3. **Minimal Extensions**: Only include essential VS Code extensions
4. **Fast Setup**: Keep post-create commands quick
5. **Document Changes**: Add comments explaining custom configuration
6. **Test Locally**: Verify before pushing to repository

## Example Projects

### Web App (React + Node.js)

```json
{
  "name": "React App",
  "image": "mcr.microsoft.com/devcontainers/typescript-node:lts",
  "features": {
    "ghcr.io/devcontainers/features/git:1": {}
  },
  "dotfiles": {
    "repository": "lnyousif/dotfiles",
    "installCommand": "bootstrap.sh"
  },
  "forwardPorts": [3000],
  "postCreateCommand": "npm install",
  "customizations": {
    "vscode": {
      "extensions": [
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ]
    }
  }
}
```

### API Server (Python + PostgreSQL)

```json
{
  "name": "Python API",
  "dockerComposeFile": "docker-compose.yml",
  "service": "app",
  "workspaceFolder": "/workspace",
  "dotfiles": {
    "repository": "lnyousif/dotfiles",
    "installCommand": "bootstrap.sh"
  },
  "forwardPorts": [8000, 5432],
  "postCreateCommand": "pip install -r requirements.txt",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-python.vscode-pylance"
      ]
    }
  }
}
```

## Additional Resources

- [DevContainers Documentation](https://containers.dev/)
- [VS Code DevContainers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Feature Reference](https://containers.dev/features)
- [Image Reference](https://containers.dev/images)
- [GitHub Codespaces](https://docs.github.com/en/codespaces)

## Contributing

Have a useful template? Submit a PR with:
- The JSON configuration
- Description of use case
- Any special setup notes
