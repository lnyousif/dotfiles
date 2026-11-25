#!/bin/bash

echo "====================================================="
echo "🧹 Almost done! Performing final Operations..."
echo "====================================================="

# Enable the Podman socket only where a user systemd session and podman exist
# (containers and WSL often have neither).
if command -v podman &> /dev/null && systemctl --user is-system-running &> /dev/null; then
  systemctl --user enable podman.socket
fi

# Shell rc files can't be sourced from here (this script runs in its own process).
echo "✅ Operations complete! Open a new shell or run 'exec \$SHELL' to load the new config."
