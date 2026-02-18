#!/bin/bash

echo "====================================================="
echo "Almost done! Performing final cleanup operations..."
echo "====================================================="

# Start Podman machine on macOS (Podman runs inside a VM)
if command -v podman >/dev/null 2>&1; then
	podman machine init >/dev/null 2>&1 || true
	podman machine start
fi

echo "Cleanup complete!"
