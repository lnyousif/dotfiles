#!/bin/sh

echo "Setting up dotfiles for Laith machines."
# Set environment variables for chezmoi configuration
export CHEZMOI_NAME="Laith Yousif"        # User's full name
export CHEZMOI_EMAIL="Laith@tmobi.link"   # User's email address
export CHEZMOI_SETUP_TYPE="basic"         # Options: basic, kids, development, work
export CHEZMOI_ENCRYPTION=false           # Set to true to enable encryption
export CHEZMOI_PASS_MANAGER=false         # Set to true to enable password manager
export CHEZMOI_NETWORK_HUB=false          # Set to true if this is a network hub
export CHEZMOI_NETWORK_NODE=false         # Set to true if this is a node machine
export CHEZMOI_NETWORK_CLOUDFLARE=false   # Set to true to enable Cloudflare DDNS updates
export CHEZMOI_NETWORK_CFLOC=""         # Cloudflare location for DDNS updates (e.g., ag)

echo "Environment variables for chezmoi have been set."
