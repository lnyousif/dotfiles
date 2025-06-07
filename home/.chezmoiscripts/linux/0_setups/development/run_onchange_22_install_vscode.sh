#!/bin/bash

# Function to install VS Code on Debian-based systems
install_on_debian() {
    echo "Detected Debian-based system."
    echo "Updating package index..."
    {{ .superuser }} apt update

    echo "Installing required dependencies..."
    {{ .superuser }} apt install -y wget gpg

    echo "Downloading VS Code .deb package..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    {{ .superuser }} install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    rm -f packages.microsoft.gpg

    echo "Adding VS Code repository..."
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | {{ .superuser }} tee /etc/apt/sources.list.d/vscode.list

    echo "Updating package index again..."
    {{ .superuser }} apt update

    echo "Installing VS Code..."
    {{ .superuser }} apt install -y code

    echo "VS Code installation completed!"
}

# Function to install VS Code on RHEL-based systems
install_on_rhel() {
    echo "Detected RHEL-based system."
    echo "Installing required dependencies..."
    {{ .superuser }} yum install -y wget gpg

    echo "Adding VS Code repository..."
    {{ .superuser }} rpm --import https://packages.microsoft.com/keys/microsoft.asc
    {{ .superuser }} sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    echo "Installing VS Code..."
    {{ .superuser }} yum install -y code

    echo "VS Code installation completed!"
}

# Detect the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/debian_version ]; then
        install_on_debian
    elif [ -f /etc/redhat-release ]; then
        install_on_rhel
    else
        echo "Unsupported Linux distribution."
        exit 1
    fi
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi
