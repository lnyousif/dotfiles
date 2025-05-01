#!/bin/bash

# Improved Linux Installation Script for Dotfiles
# This script detects the Linux distribution and installs the required packages
# before initializing and applying the chezmoi dotfiles

set -e

echo "======================================================"
echo "      Dotfiles Installation Script for Linux"
echo "======================================================"y

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
    echo "Detecting Linux distribution..."
    
    if [ -f /etc/debian_version ] || [ -f /etc/ubuntu_version ]; then
        echo "Debian/Ubuntu-based distribution detected"
        sudo apt update || error_exit "Failed to update package lists"
        sudo apt install -y curl git || error_exit "Failed to install curl and git"
        
        # Check if chezmoi is already installed
        if ! command -v chezmoi &> /dev/null; then
            echo "Installing chezmoi..."
            sudo apt install -y chezmoi || error_exit "Failed to install chezmoi"
        else
            echo "chezmoi is already installed"
        fi
    elif [ -f /etc/fedora-release ]; then
        echo "Fedora-based distribution detected"
        sudo dnf check-update || true
        sudo dnf install -y curl git || error_exit "Failed to install curl and git"
        
        if ! command -v chezmoi &> /dev/null; then
            echo "Installing chezmoi..."
            sudo dnf install -y chezmoi || error_exit "Failed to install chezmoi"
        else
            echo "chezmoi is already installed"
        fi
    elif [ -f /etc/arch-release ]; then
        echo "Arch-based distribution detected"
        sudo pacman -Sy || error_exit "Failed to update package lists"
        sudo pacman -S --needed curl git || error_exit "Failed to install curl and git"
        
        if ! command -v chezmoi &> /dev/null; then
            echo "Installing chezmoi..."
            sudo pacman -S --needed chezmoi || error_exit "Failed to install chezmoi"
        else
            echo "chezmoi is already installed"
        fi
    else
        echo "Unsupported distribution. Installing chezmoi using alternative method..."
        if command -v curl &> /dev/null; then
            sh -c "$(curl -fsLS get.chezmoi.io)" || error_exit "Failed to install chezmoi"
        else
            error_exit "curl is not installed. Please install curl manually and try again."
        fi
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
    
    echo "======================================================"
    echo "✅ Dotfiles setup complete!"
    echo "   Backup of previous configuration saved to: $BACKUP_DIR"
    echo "======================================================"

    switch_git_remote
}

# Run the main function
main