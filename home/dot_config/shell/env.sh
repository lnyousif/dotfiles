# shellcheck shell=sh
# ~/.config/shell/env.sh — environment for EVERY shell: login, interactive, scripts,
# cron and `ssh host cmd`. Sourced by ~/.profile, ~/.bash_profile, ~/.zshenv,
# ~/.zprofile, ~/.bashrc and ~/.zshrc.
#
# Rules: POSIX only (also runs under dash and zsh), no output, nothing slow.
# Safe to source repeatedly: directories are moved to the front, never duplicated.
# Machine-specific additions go in ~/.config/shell/env.local.sh (not managed).

# Put a directory at the front of PATH, if it exists. Removes any existing copy first.
# Uses parameter expansion rather than IFS splitting so it also works in zsh.
path_prepend() {
    [ -d "$1" ] || return 0
    _pp_new="$1"
    _pp_rest="$PATH:"
    while [ -n "$_pp_rest" ]; do
        _pp_dir="${_pp_rest%%:*}"
        _pp_rest="${_pp_rest#*:}"
        if [ -n "$_pp_dir" ] && [ "$_pp_dir" != "$1" ]; then
            _pp_new="$_pp_new:$_pp_dir"
        fi
    done
    PATH="$_pp_new"
    unset _pp_new _pp_rest _pp_dir
}

# --- Homebrew (Linux, Apple Silicon, Intel macOS) ---------------------------
# Set directly instead of `eval "$(brew shellenv)"`: no subprocess, works in sh.
for _brew_prefix in /home/linuxbrew/.linuxbrew /opt/homebrew /usr/local; do
    if [ -x "$_brew_prefix/bin/brew" ]; then
        export HOMEBREW_PREFIX="$_brew_prefix"
        path_prepend "$_brew_prefix/sbin"
        path_prepend "$_brew_prefix/bin"
        # Trailing ':' keeps the system man/info paths searched as well
        case ":${MANPATH:-}:" in
            *":$_brew_prefix/share/man:"*) ;;
            *) export MANPATH="$_brew_prefix/share/man${MANPATH:+:$MANPATH}:" ;;
        esac
        case ":${INFOPATH:-}:" in
            *":$_brew_prefix/share/info:"*) ;;
            *) export INFOPATH="$_brew_prefix/share/info:${INFOPATH:-}" ;;
        esac
        break
    fi
done
unset _brew_prefix

# --- Language/tool managers ---------------------------------------------------
export PNPM_HOME="$HOME/.local/share/pnpm"
path_prepend "$PNPM_HOME"
path_prepend "$HOME/.bun/bin"     # bun's installer would edit rc files chezmoi overwrites
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/go/bin"

# --- Personal bins (highest priority; prepended last) ------------------------
path_prepend "$HOME/bin"
path_prepend "$HOME/.myscripts/bin"
path_prepend "$HOME/.local/bin"   # chezmoi, pipx, micro fallback install
export PATH

# --- Editor: first one available ---------------------------------------------
# git has no core.editor set, so it follows $VISUAL/$EDITOR too.
for _editor in micro nano vi; do
    if command -v "$_editor" > /dev/null 2>&1; then
        export EDITOR="$_editor" VISUAL="$_editor"
        break
    fi
done
unset _editor

# --- Local overrides -----------------------------------------------------------
if [ -r "$HOME/.config/shell/env.local.sh" ]; then
    # shellcheck source=/dev/null
    . "$HOME/.config/shell/env.local.sh"
fi

unset -f path_prepend
