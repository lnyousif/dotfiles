#!/bin/bash

echo "====================================================="
echo "🧹 Almost done! Performing final Operations..."
echo "====================================================="

# Enable Podman socket for user
systemctl --user enable podman.socket

source ~/.bashrc  # For bash
source ~/.zshrc   # For zsh

echo "✅ Operations complete!"
