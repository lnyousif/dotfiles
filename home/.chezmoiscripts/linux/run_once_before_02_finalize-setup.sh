#!/bin/bash

echo "====================================================="
echo "🧹 Almost done! Performing final cleanup operations..."
echo "====================================================="

# Remove temporary directory and its contents
echo "Removing temporary directory..."
#{{ .superuser }} rm -rf "${HOME}/.temp"

source ~/.bashrc  # For bash
source ~/.zshrc   # For zsh

echo "✅ Cleanup complete!"
