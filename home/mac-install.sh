#!/bin/bash

# macOS Installation Script for Dotfiles

set -e

# Clone git submodules
git submodule update --init --recursive

echo ""
echo "🤚  This script will setup .dotfiles for you."
read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dependencies
brew install chezmoi

# Initialize chezmoi
chezmoi init --apply

# Post-installation steps
# Add any additional setup commands here

echo "Dotfiles setup complete!"