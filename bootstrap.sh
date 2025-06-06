#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! chezmoi="$(command -v chezmoi)"; then
	bin_dir="${HOME}/.local/bin"
	chezmoi="${bin_dir}/chezmoi"
	echo "Installing chezmoi to '${chezmoi}'" >&2
	if command -v curl >/dev/null; then
		chezmoi_install_script="$(curl -fsSL get.chezmoi.io)"
	elif command -v wget >/dev/null; then
		chezmoi_install_script="$(wget -qO- get.chezmoi.io)"
	else
		echo "To install chezmoi, you must have curl or wget installed." >&2
		exit 1
	fi
	sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
	unset chezmoi_install_script bin_dir
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"


# Set environment variables for chezmoi configuration
export CHEZMOI_NAME="Laith Yousif"
export CHEZMOI_EMAIL="Laith@tmobi.link"
export CHEZMOI_SETUP_TYPE="basic"  # Options: basic, kids, development, work
export CHEZMOI_ENCRYPTION=false     # Set to true to enable encryption
export CHEZMOI_PASS_MANAGER=false    # Set to true to enable password manager
export CHEZMOI_NETWORK_HUB=false     # Set to true if this is a network hub
export CHEZMOI_NETWORK_NODE=false    # Set to true if this is a node machine

echo "Environment variables for chezmoi have been set."


set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
