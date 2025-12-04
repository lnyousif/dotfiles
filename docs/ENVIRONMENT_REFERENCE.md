# Environment Reference

Complete reference for environment variables and configuration options.

## Environment Variables

### Core Configuration

| Variable | Default | Description | Example |
|----------|---------|-------------|---------|
| `CHEZMOI_NAME` | "Laith Yousif" | Full name for Git configuration | "John Doe" |
| `CHEZMOI_EMAIL` | "Laith@tmobi.link" | Email for Git configuration | "john@example.com" |

### Setup Type

| Variable | Default | Options | Description |
|----------|---------|---------|-------------|
| `CHEZMOI_SETUP_TYPE` | prompted | basic, kids, development, work | Determines which tools are installed |

#### Setup Type Details

**basic**
- Minimal installation
- Essential shell tools
- No development tools
- Ideal for: Personal machines, minimal environments

**development**
- Full development environment
- Containers (Podman)
- Code quality tools
- AI assistants
- Ideal for: Development workstations

**kids**
- Simplified setup
- Restricted features
- No encryption options
- Ideal for: Family computers, child accounts

**work**
- Work-specific configuration
- Encryption disabled
- SSH keys excluded
- Ideal for: Company computers

### User Privileges

| Variable | Default | Options | Description |
|----------|---------|---------|-------------|
| `CHEZMOI_USER_TYPE` | prompted | sudo, normal | Package installation privileges |

### Feature Flags

| Variable | Default | Description |
|----------|---------|-------------|
| `CHEZMOI_ENCRYPTION` | prompted | Enable age encryption support |
| `CHEZMOI_PASS_MANAGER` | prompted | Enable KeePassXC integration |
| `CHEZMOI_NETWORK_HUB` | false | Configure as network hub |
| `CHEZMOI_NETWORK_NODE` | prompted | Configure SSH server access |
| `CHEZMOI_NETWORK_CLOUDFLARE` | false | Enable Cloudflare DDNS updater |

## Automatic Environment Detection

### Codespace/DevContainer Detection

The dotfiles automatically detect these environments:

```bash
# GitHub Codespaces
$CODESPACES == "true"

# VS Code Remote Containers
$REMOTE_CONTAINERS_IPC != ""

# Special usernames
$USER in ["vagrant", "vscode"]
```

### Auto-configured Settings

When running in ephemeral environments (Codespaces, DevContainers):

| Setting | Value | Reason |
|---------|-------|--------|
| `ephemeral` | true | Temporary environment |
| `headless` | true | No GUI available |
| `encryption` | false | Not needed for ephemeral |
| `development` | false | Basic tools only |
| `superuser` | sudo | Need package installation |
| `codespace` | true | Enable codespace features |

## Configuration Files

### Chezmoi Configuration

**Location**: `~/.config/chezmoi/chezmoi.toml`

Generated from: `home/.chezmoi.toml.tmpl`

Key sections:
```toml
[data]
  email = "user@example.com"
  name = "User Name"
  osid = "linux-ubuntu"
  setuptype = "development"
  superuser = "sudo"

[data.setups]
  base = true
  development = true
  kids = false

[data.features]
  ephemeral = false
  headless = false
  encryption = true
  codespace = false
  passman = true
  work = false
  hub = false
  node = true
  cloudflare = false
```

### Package Configuration

**Location**: `home/.chezmoidata/packages/`

Structure:
```
packages/
├── base/
│   ├── linux.yaml
│   ├── darwin.yaml
│   └── windows.yaml
├── development/
│   ├── linux.yaml
│   ├── darwin.yaml
│   ├── windows.yaml
│   └── vscode.yaml
└── kids/
    ├── linux.yaml
    ├── darwin.yaml
    └── windows.yaml
```

### Package Format

```yaml
packages:
  setup_name:
    os_name:
      common:
        apt:              # Native packages
          - package-name
        apt_junk:         # Packages to remove
          - bloatware
        pips:             # Python packages
          - python-package
        linux_cmd:        # Shell commands
          - curl ... | sh
```

## Operating System Detection

### OS ID Format

Generated from:
```
{os}-{id}
```

Examples:
- `linux-ubuntu`
- `linux-debian`
- `linux-fedora`
- `linux-arch`
- `linux-alpine`
- `darwin` (macOS)
- `windows`

### Package Manager Detection

| OS | Package Manager | Command |
|----|----------------|---------|
| Debian/Ubuntu | apt | `apt install` |
| Fedora | dnf | `dnf install` |
| Arch | pacman | `pacman -S` |
| Alpine | apk | `apk add` |
| macOS | Homebrew | `brew install` |
| Windows | winget | `winget install` |

## Script Execution Order

### Linux Setup Scripts

```
.chezmoiscripts/linux/
├── run_once_before_11_configure-repos-and-executables.sh.tmpl
├── run_once_before_12_install-setup-packages.sh.tmpl
├── 1_setups/
│   ├── base/
│   │   └── run_once_*
│   └── development/
│       └── run_once_*
├── 2_features/
│   ├── encryption/
│   ├── codespace/
│   │   └── run_once_51_init-codespace.sh.tmpl
│   └── [feature]/
│       └── run_once_*
└── run_once_after_99_finalize-setup.sh
```

### Execution Order

1. `run_once_before_*` - Pre-setup (repos, updates)
2. `1_setups/[setup]/run_once_*` - Setup-specific scripts
3. `2_features/[feature]/run_once_*` - Feature-specific scripts
4. `run_once_after_*` - Post-setup finalization

## Shell Configuration

### Bash

**File**: `~/.bashrc`
**Template**: `home/.chezmoitemplates/bashrc`

Key features:
- Starship prompt
- Custom PATH configuration
- NVM integration
- PNPM support
- Custom functions and aliases

### Zsh (macOS)

**File**: `~/.zshrc`
**Template**: `home/.chezmoitemplates/mac_zshrc`

Similar to Bash with macOS-specific optimizations.

### Custom Scripts

**Location**: `~/.myscripts/`

Files:
- `bash_functions.tmpl` - Reusable shell functions
- `bash_aliases.tmpl` - Command aliases
- `bash_extra` - Additional configurations

## VSCode Configuration

### Settings Location

| Platform | Path |
|----------|------|
| Linux | `~/.config/Code/User/settings.json` |
| macOS | `~/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json` |

### Extension Management

**Location**: `home/.chezmoidata/packages/development/vscode.yaml`

Categories:
- **global** - Installed on all platforms
- **windows** - Windows-specific (e.g., WSL)
- **darwin** - macOS-specific
- **linux** - Linux-specific

### Dotfiles Integration

VSCode settings include:
```json
{
  "dotfiles.repository": "https://github.com/lnyousif/dotfiles.git",
  "dotfiles.targetPath": "~/.dotfiles",
  "dotfiles.installCommand": "bootstrap.sh"
}
```

## Encryption Setup

### Age Configuration

When encryption is enabled:

**Identity**: `~/.config/chezmoi/key.txt`
**Recipient**: `age14t6vfqtd0f2z9gth0tsnw3qwh6nxgkvem5exjzs3x9juyp5659wqh47sfw`

### KeePassXC Integration

**Database**: `~/.keepassxc/chezmoi.kdbx`
**Keyfile**: `~/.keepassxc/keypass.keyx`

Command: `my_chezmoi_keepassxc.sh`

## Ignore Patterns

Files ignored by chezmoi (from `home/.chezmoiignore`):

### Always Ignored
- `key.txt.age`
- `.chezmoidata/**`
- Install scripts (`*-install.sh`, `*-install.ps1`)

### Conditional Ignoring

Based on `features.encryption`:
- `false` → Ignore `.keepassxc/**` and `.ssh/**`

Based on `features.work`:
- `true` → Ignore `.keepassxc/**` and `.ssh/**`

Based on OS:
- Linux: Ignore Windows/macOS scripts
- macOS: Ignore Linux/Windows scripts
- Windows: Ignore Linux/macOS scripts

Based on feature flags:
- Disabled features → Ignore feature scripts

Based on setup type:
- Disabled setups → Ignore setup scripts

## Customization Points

### Adding New Packages

1. Edit `home/.chezmoidata/packages/{setup}/{os}.yaml`
2. Add package to appropriate section
3. Run `chezmoi apply`

### Adding New Scripts

1. Create script in `home/.chezmoiscripts/{os}/{category}/`
2. Name with execution order prefix: `run_once_XX_name.sh`
3. Make executable
4. Run `chezmoi apply`

### Adding Custom Configurations

1. Create config file in `home/dot_config/`
2. Use `.tmpl` extension for templates
3. Reference variables with `{{ .variablename }}`
4. Run `chezmoi apply`

## Debugging

### View Current Configuration

```bash
chezmoi data
```

### Test Template Rendering

```bash
chezmoi execute-template "{{ .email }}"
```

### Check What Would Change

```bash
chezmoi diff
```

### Verbose Application

```bash
chezmoi apply -v
```

### Verify State

```bash
chezmoi verify
```

## Environment-Specific Workflows

### Development Machine

```bash
export CHEZMOI_SETUP_TYPE="development"
export CHEZMOI_ENCRYPTION=true
export CHEZMOI_PASS_MANAGER=true
export CHEZMOI_NETWORK_NODE=true
```

### Work Laptop

```bash
export CHEZMOI_SETUP_TYPE="work"
export CHEZMOI_ENCRYPTION=false
export CHEZMOI_PASS_MANAGER=false
```

### Home Server

```bash
export CHEZMOI_SETUP_TYPE="basic"
export CHEZMOI_NETWORK_NODE=true
export CHEZMOI_CLOUDFLARE=true
```

### Codespace/DevContainer

Automatically detected - no manual configuration needed.
