#!/bin/bash

export PATH="$HOME/.local/bin/:$PATH"
{{ $package_group := . }}

mkdir -p "$HOME/Downloads/AppImages"

# Accept a string argument, default to "base" if empty
echo "installing from data packages"

# Linux self installing packages
echo "Installing self installing packages"
range .packages.powerful.linux.common.flatpak
    code --install-extension {{ . }}
end 

range .packages["$package_group"].linux.common.linux_url
    bash -c {{ . | quote }}
end 