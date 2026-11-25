#!/usr/bin/env bash
# Called by chezmoi as its keepassxc command: feeds the DB passphrase on stdin.
set -euo pipefail

if [ -z "${KEEPASSXC_PASSPHRASE:-}" ]; then
    echo "my_chezmoi_keepassxc.sh: KEEPASSXC_PASSPHRASE is not set" >&2
    exit 1
fi

# printf, not `echo -e`: echo -e would rewrite backslashes in the passphrase
printf '%s\n' "${KEEPASSXC_PASSPHRASE}" | keepassxc-cli "$@"
