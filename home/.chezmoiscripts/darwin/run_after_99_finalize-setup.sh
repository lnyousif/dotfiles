#!/bin/bash

echo "====================================================="
echo "🧹 Almost done! Performing final cleanup operations..."
echo "====================================================="

# Enable Podman socket for user
systemctl --user enable podman.socket
loginctl enable-linger $(whoami)

echo "✅ Cleanup complete!"
