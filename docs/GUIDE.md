# How this dotfiles setup works

A maintainer's guide to the moving parts: how a machine is configured, where secrets live,
and how to add or rotate keys and tokens. For install commands see the [Readme](../Readme.md).

## 1. The big picture

```
repo root
├── .chezmoiroot            -> "home": chezmoi's source directory is home/
├── bootstrap.sh            # Codespaces/devcontainers entry point (sources pre-init.sh)
├── pre-init.sh             # Default CHEZMOI_* answers for unattended installs
├── scripts/lint-templates.sh  # Renders templates and ShellChecks them (used by CI)
└── home/
    ├── .chezmoi.toml.tmpl  # Asks the questions, writes ~/.config/chezmoi/chezmoi.toml
    ├── .chezmoiignore      # Drops files/scripts for disabled OSes, setups and features
    ├── .chezmoidata/       # Package lists per setup and OS (YAML)
    ├── .chezmoiscripts/    # Install/config scripts, per OS (see section 3)
    ├── .chezmoitemplates/  # Shared template snippets (shell rc, keys, cloudflare)
    ├── key.txt.age         # Your age private key, passphrase-encrypted
    ├── dot_keepassxc/      # KeePassXC DB + key file, age-encrypted
    ├── private_dot_ssh/    # SSH private keys, rendered from KeePassXC
    └── dot_*, dot_config/  # Plain dotfiles
```

`chezmoi init` renders `.chezmoi.toml.tmpl` once. Every answer is stored in
`~/.config/chezmoi/chezmoi.toml` under `[data]`. All other templates read those values as
`.setups.*` and `.features.*`.

## 2. Machine profile: setups and features

**Setup type** (`CHEZMOI_SETUP_TYPE`, asked once):

| Setup         | `setups.development` | `setups.kids` | `features.work` |
|---------------|:---:|:---:|:---:|
| `basic`       |     |     |     |
| `development` |  ✓  |     |     |
| `work`        |  ✓  |     |  ✓  |
| `kids`        |     |  ✓  |     |

`setups.base` is always on.

**Features** are only asked when the one above them is on:

```
encryption ──► passman ──► hub, node, cloudflare (+ cfloc), k0shub, k0snode
```

| Feature     | Env var                       | What it does |
|-------------|-------------------------------|--------------|
| encryption  | `CHEZMOI_ENCRYPTION`          | Decrypts the age key and enables `encrypted_*` files |
| passman     | `CHEZMOI_PASS_MANAGER`        | Deploys the KeePassXC DB used for every secret below |
| hub         | `CHEZMOI_NETWORK_HUB`         | Installs the homelab SSH private key (`~/.ssh/id_ed25519_homelab`) |
| node        | `CHEZMOI_NETWORK_NODE`        | Adds the homelab public key to `~/.ssh/authorized_keys` |
| k0shub      | `CHEZMOI_K0S_HUB`             | Installs the k0s SSH private key (`~/.ssh/id_ed25519_k0s`) |
| k0snode     | `CHEZMOI_K0S_NODE`            | Adds the k0s public key to `authorized_keys` |
| cloudflare  | `CHEZMOI_NETWORK_CLOUDFLARE`  | Deploys the DDNS scripts and their cron jobs (`CHEZMOI_NETWORK_CFLOC` picks the site) |

These are detected automatically, never asked:

- **Codespace, devcontainer, Vagrant:** sets `codespace`, `ephemeral` and `headless`.
- **Encryption** is off in those environments.

Env vars must be exactly `true` or `false`. Any other value, or unset, triggers the prompt.

**Changing a profile later:**

1. Edit `~/.config/chezmoi/chezmoi.toml`, or run `chezmoi init` again with the env vars set.
2. Run `chezmoi apply`.

## 3. Script order

chezmoi runs `.chezmoiscripts/<os>/` in this order:

1. All `*_before_*` scripts, alphabetically.
2. Files and plain scripts.
3. All `*_after_*` scripts.

The folder prefixes therefore set the order:

| Folder         | Runs | Purpose |
|----------------|------|---------|
| `00_before/`   | first | Repos, Homebrew, packages from `.chezmoidata` |
| `10_setups/<setup>/` | with files | Per-setup config (e.g. VS Code extensions) |
| `20_features/<feature>/` | by prefix | Per-feature scripts (age key decrypt, authorized_keys, cron) |
| `30_after/`    | last  | Finalize (node apps, OS tweaks) |

`.chezmoiignore` skips `10_setups/<x>` and `20_features/<x>` folders whose flag is false.
To add behaviour for a feature, drop a script into its folder; no wiring is needed.

Script prefixes:

- `run_onchange_` re-runs only when the script's rendered content changes.
- `run_once_` runs once per machine.

## 4. How secrets flow

```
AGE_PASSPHRASE ──► key.txt.age ──► ~/.config/chezmoi/key.txt   (age identity)
                                         │
                                         ▼ decrypts encrypted_* files
                         ~/.keepassxc/chezmoi.kdbx + keypass.keyx
                                         │
KEEPASSXC_PASSPHRASE ──► my_chezmoi_keepassxc.sh ──► keepassxc-cli
                                         │
                                         ▼ keepassxc / keepassxcAttachment
                     SSH keys, Cloudflare credentials, other tokens
```

1. **Age identity.**
   - `20_features/encryption/run_once_before_01_decrypt-private-key` decrypts `key.txt.age` into `~/.config/chezmoi/key.txt`.
   - It uses `AGE_PASSPHRASE` when set, and asks you otherwise.
   - The file is never committed.
2. **KeePassXC database.** `dot_keepassxc/encrypted_*` are age-encrypted. chezmoi decrypts them into `~/.keepassxc/`.
3. **Lookups.**
   - The `[keepassxc]` config points chezmoi at `my_chezmoi_keepassxc.sh`, which pipes `KEEPASSXC_PASSPHRASE` into `keepassxc-cli`.
   - Templates read entries with `keepassxc "Group/Entry"` (fields) or `keepassxcAttachment "Group/Entry" "file"` (attachments).
4. **Double encryption for keys.** SSH key attachments are themselves age-encrypted, hence `... | decrypt`. A leaked DB export alone doesn't expose them.

**Guard rule:** every template that reads KeePassXC is wrapped in `if env "KEEPASSXC_PASSPHRASE"`.

- If the passphrase isn't set, the template keeps the file already on disk.
- If there is no file, it renders nothing.
- So `chezmoi apply` never fails just because the vault is locked.

Follow the same pattern for new secrets; see `private_dot_ssh/*.tmpl`.

### Secrets currently in the database

| Entry | Used by |
|-------|---------|
| `Keys/chezmoi-github` → `encrypted_ed25519` | `~/.ssh/id_ed25519` |
| `Keys/chezmoi-homelab-hub` → `encrypted_id_ed25519_homelab` | `~/.ssh/id_ed25519_homelab` (hub) |
| `Keys/chezmoi-homelab-node` → `encrypted_id_ed25519_homelab.pub` | `authorized_keys` (node) |
| `Keys/chezmoi-homelab-k0s-hub` → `encrypted_id_ed25519_homelab_k0s` | `~/.ssh/id_ed25519_k0s` (k0shub) |
| `Keys/chezmoi-homelab-k0s-pub` → `encrypted_id_ed25519_homelab_k0s.pub` | `authorized_keys` (k0snode) |
| `Cloudflare/*`, `Cloudflare/record_name_<loc>`, `Cloudflare/sitename_<loc>` | DDNS scripts |

## 5. Common tasks

### Set up a new machine with secrets

```bash
export AGE_PASSPHRASE='…' KEEPASSXC_PASSPHRASE='…'
export CHEZMOI_ENCRYPTION=true CHEZMOI_PASS_MANAGER=true CHEZMOI_NETWORK_HUB=true
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply lnyousif
```

Prefix the line with a space so it stays out of shell history, if your shell is configured
for that (`HISTCONTROL=ignorespace`).

### Add a new SSH key

1. Generate it: `ssh-keygen -t ed25519 -f /tmp/id_new`.
2. Encrypt it: `chezmoi age encrypt /tmp/id_new > encrypted_id_new`. This uses the recipient from your chezmoi config.
3. In KeePassXC, create `Keys/<name>` and attach `encrypted_id_new`. Commit the updated DB:
   - Run `chezmoi re-add ~/.keepassxc/chezmoi.kdbx`, which re-encrypts it into the source.
   - Then commit and push from `chezmoi cd`.
4. Add a template in `.chezmoitemplates/<area>/`, guarded by a feature flag and `KEEPASSXC_PASSPHRASE`.
5. Add `private_dot_ssh/private_id_new.tmpl`, copying `private_id_ed25519_homelab.tmpl`.
6. If it needs a new flag:
   - Add the prompt and env var to `.chezmoi.toml.tmpl`.
   - Add the value to `[data]`.
   - Add a `20_features/<flag>/` folder.

### Add an API token as an environment variable

Create `home/private_dot_config/secrets.env.tmpl`:

```sh
{{- if env "KEEPASSXC_PASSPHRASE" }}
export GITHUB_TOKEN={{ (keepassxc "Tokens/github").Password | quote }}
{{- end }}
```

Then source `~/.config/secrets.env` from `.chezmoitemplates/shell/shellrc`.

### Rotate a key or token

1. Replace the value in KeePassXC.
2. Commit the DB and push.
3. On each machine, run `chezmoi update` with `KEEPASSXC_PASSPHRASE` set.

The templates prefer the vault over the file on disk, so the new value replaces the old.

### Add packages

Edit `home/.chezmoidata/packages/<setup>/<os>.yaml`. Linux keys:

- `apt`: also used for dnf, apk and pacman names.
- `apt_junk`: packages to remove.
- `brews`, `pips`, `pnpm`.
- `linux_cmd`: arbitrary install commands; `{arch}` is replaced with the machine architecture.

The install script re-runs on the next apply because its rendered content changed.

## 6. Troubleshooting

| Symptom | Cause / fix |
|---------|-------------|
| `error calling keepassxc: ... exit status 1` | Wrong or empty `KEEPASSXC_PASSPHRASE`, missing `~/.keepassxc/keypass.keyx`, or the entry doesn't exist. chezmoi hides the reason; run the command it prints yourself, e.g. `my_chezmoi_keepassxc.sh show -k ~/.keepassxc/keypass.keyx ~/.keepassxc/chezmoi.kdbx Cloudflare/auth_email` |
| `age: no identity matched` / decrypt fails | `~/.config/chezmoi/key.txt` missing or wrong. Delete it and re-run `chezmoi apply` with `AGE_PASSPHRASE` set |
| A setting in `~/.gitconfig` disappears | Something ran `git config --global`. That file is managed by `dot_gitconfig.tmpl`; put the setting there, or in `~/.gitconfig_local` (unmanaged, already included) |
| Changed a script but it didn't run | `run_once_` scripts don't re-run; `chezmoi state delete-bucket --bucket=scriptState` resets them |
| See what would change | `chezmoi diff`, or `chezmoi execute-template < file.tmpl` to render one template |

## 7. Checks

- `pre-commit` runs commitizen, file hygiene and ShellCheck on plain `.sh` files.
- `scripts/lint-templates.sh` renders every script template and the shell rc files with secrets disabled, then ShellChecks the output.
- CI (`.github/workflows/lint.yml`) runs both on every push.
