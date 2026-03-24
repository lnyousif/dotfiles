#!/bin/bash

echo "====================================================="
echo "🧹 Almost done! Performing final cleanup operations..."
echo "====================================================="

# Enable Podman socket and linger where systemd tools are available.
if command -v systemctl &> /dev/null; then
  systemctl --user enable podman.socket
fi

if command -v loginctl &> /dev/null; then
  loginctl enable-linger "$USER"
fi

echo "✅ Cleanup complete!"
