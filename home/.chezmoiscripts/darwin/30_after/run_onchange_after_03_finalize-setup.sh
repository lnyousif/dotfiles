#!/bin/bash

echo "====================================================="
echo "🧹 Almost done! Performing final cleanup operations..."
echo "====================================================="

# Enable Podman socket for user (Linux only)
if command -v systemctl &> /dev/null; then
  systemctl --user enable podman.socket
  loginctl enable-linger $(whoami)
fi

echo "✅ Cleanup complete!"
