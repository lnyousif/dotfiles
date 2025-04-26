#!/bin/bash

# Linux Installation Script for Dotfiles

set -e

# Update and install dependencies
sudo apt update && sudo apt install -y curl git chezmoi

# Initialize chezmoi
chezmoi init --apply

# Post-installation steps
# Add any additional setup commands here

echo "Dotfiles setup complete!"