#!/bin/bash

# Improved Linux Installation Script for Dotfiles
# This script detects the Linux distribution and installs the required packages
# before initializing and applying the chezmoi dotfiles

set -e

echo "======================================================"
echo "      Dotfiles Installation Script for Linux"
echo "======================================================"

# Function for error handling
error_exit() {
    echo "ERROR: $1" >&2
    exit 1
}

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
    echo "WARNING: Running as root is not recommended. Consider running without sudo."
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi




# Function to detect package manager and install dependencies
install_dependencies() {
      echo "Installing chezmoi"
      if command -v curl &> /dev/null; then
          sh -c "$(curl -fsLS get.chezmoi.io/lb)" || error_exit "Failed to install chezmoi"
      else
          error_exit "curl is not installed. Please install curl manually and try again."
      fi
}

# Function to switch git remote between HTTPS and SSH
switch_git_remote() {
    # `chezmoi cd` opens an interactive subshell, so cd into the working tree instead
    cd "$(chezmoi source-path)" || error_exit "Could not cd into chezmoi source"

    echo "Toggling origin remote between HTTPS and SSH..."
    current_url=$(git remote get-url origin)

    if [[ $current_url == https://* ]]; then
        # https://github.com/user/repo.git -> git@github.com:user/repo.git
        ssh_url=$(echo "$current_url" | sed -E 's|^https://([^/]+)/|git@\1:|')
        git remote set-url origin "$ssh_url"
        echo "Origin remote switched to SSH: $ssh_url"
    elif [[ $current_url == git@* ]]; then
        # git@github.com:user/repo.git -> https://github.com/user/repo.git
        https_url=$(echo "$current_url" | sed -E 's|^git@([^:]+):|https://\1/|')
        git remote set-url origin "$https_url"
        echo "Origin remote switched to HTTPS: $https_url"
    else
        echo "Origin remote URL format not recognized. No changes made."
    fi
}

# Main installation process
main() {
    install_dependencies

    echo "Installing dotfiles with chezmoi..."


    # Initialize and apply chezmoi
    echo "Initializing chezmoi..."
    chezmoi init https://github.com/lnyousif/dotfiles.git --apply || error_exit "Failed to initialize and apply chezmoi"

    echo "======================================================"
    echo "✅ Dotfiles setup complete!"
    echo "======================================================"

    switch_git_remote
}

# Run the main function
main
