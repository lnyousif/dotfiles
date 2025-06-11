#!/usr/bin/env bash
echo -e "${KEEPASSXC_PASSPHRASE}\n" | keepassxc-cli "$@"
