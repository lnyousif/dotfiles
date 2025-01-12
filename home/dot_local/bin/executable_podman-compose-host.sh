#!/bin/sh
exec flatpak-spawn --host podman-compose "${@}"
