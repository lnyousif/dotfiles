#!/bin/bash

# Improved macOS Installation Script for Dotfiles

set -e

echo "======================================================"
echo "      Dotfiles Installation Script for macOS"
echo "======================================================"

# Function for error handling
error_exit() {
    echo "ERROR: $1" >&2
    exit 1
}

# Check if running as root (generally not recommended on macOS)
if [ "$(id -u)" -eq 0 ]; then
    echo "WARNING: Running as root is not recommended."
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Function to install dependencies
install_dependencies() {
    echo "Installing required dependencies..."

    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error_exit "Failed to install Homebrew"

        # Add Homebrew to PATH for the current session
        if [[ $(uname -m) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo "Homebrew is already installed"
    fi

    # Check if chezmoi is already installed
    if ! command -v chezmoi &> /dev/null; then
        echo "Installing chezmoi..."
        brew install chezmoi || error_exit "Failed to install chezmoi"
    else
        echo "chezmoi is already installed"
        brew upgrade chezmoi || echo "Warning: Could not upgrade chezmoi"
    fi
}

# Function to switch git remote between HTTPS and SSH
switch_git_remote() {
    chezmoi cd
    # Script to toggle origin remote between HTTPS and SSH
    echo "Toggling origin remote between HTTPS and SSH..."

    # Get the current origin URL
    current_url=$(git remote get-url origin)

    # Check if the URL is HTTPS or SSH
    if [[ $current_url == https://* ]]; then
        # Convert HTTPS URL to SSH URL
        ssh_url=$(echo "$current_url" | sed -e 's|https://|git@|' -e 's|/|:|' -e 's|\.com/|\.com:|')

        # Set the new SSH URL as the origin remote
        git remote set-url origin "$ssh_url"
        echo "Origin remote switched to SSH: $ssh_url"
    elif [[ $current_url == git@* ]]; then
        # Convert SSH URL to HTTPS URL
        https_url=$(echo "$current_url" | sed -e 's|git@|https://|' -e 's|:|/|' -e 's|\.com:|\.com/|')

        # Set the new HTTPS URL as the origin remote
        git remote set-url origin "$https_url"
        echo "Origin remote switched to HTTPS: $https_url"
    else
        echo "Origin remote URL format not recognized. No changes made."
    fi
}

# Main installation process
main() {
    echo "🤚  This script will setup .dotfiles for you."
    read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

    install_dependencies

    echo "Installing dotfiles with chezmoi..."

    # Create backup of existing configuration
    BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    echo "Creating backup of existing configuration to $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    # Backup important existing dotfiles
    for file in .bashrc .zshrc .profile .gitconfig; do
        if [ -f "$HOME/$file" ]; then
            cp -f "$HOME/$file" "$BACKUP_DIR/" || echo "Warning: Failed to backup $file"
        fi
    done

    # Initialize and apply chezmoi
    echo "Initializing chezmoi..."
    chezmoi init https://github.com/lnyousif/dotfiles.git --apply || error_exit "Failed to initialize and apply chezmoi"

    # Perform macOS specific post-installation tasks
    if [ -f "$HOME/.macos" ]; then
        echo "Setting macOS preferences..."
        bash "$HOME/.macos" || echo "Warning: Failed to set some macOS preferences"
    fi

    echo "======================================================"
    echo "✅ Dotfiles setup complete!"
    echo "   Backup of previous configuration saved to: $BACKUP_DIR"
    echo "======================================================"

    # Switch git remote between HTTPS and SSH
    echo "Switching git remote between HTTPS and SSH..."
    switch_git_remote

}

# Run the main function
main
