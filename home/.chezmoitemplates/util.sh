#!/bin/bash

# Function to download and install a .deb or .rpm package
# Usage: install_package <URL>
install_package() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: install_package <URL>"
        return 1
    fi

    local package_url="$1"
    local package_file=$(basename "$package_url")
    local temp_dir="/tmp"
    local local_path="$temp_dir/$package_file"

    echo "Downloading $package_file from $package_url..."
    # Use curl or wget to download the file. Using curl with -L for redirects
    if command -v curl &> /dev/null; then
        curl -L -o "$local_path" "$package_url"
    elif command -v wget &> /dev/null; then
        wget -O "$local_path" "$package_url"
    else
        echo "Error: curl or wget is required to download files. Please install one."
        return 1
    fi

    if [ $? -ne 0 ]; then
        echo "Error: Download failed for $package_url"
        return 1
    fi

    echo "Download complete. Identifying package type and installing..."

    if [[ "$package_file" == *.deb ]]; then
        # Handle .deb package
        if command -v apt &> /dev/null; then
            # Use apt to install local .deb files and handle dependencies automatically
            sudo apt install "$local_path" -y
        elif command -v dpkg &> /dev/null; then
            # Fallback to dpkg, but this won't auto-resolve dependencies
            sudo dpkg -i "$local_path"
            echo "Note: Dependencies might need to be installed manually with 'sudo apt install -f'"
        else
            echo "Error: Neither apt nor dpkg found for .deb installation."
            return 1
        fi
    elif [[ "$package_file" == *.rpm ]]; then
        # Handle .rpm package
        if command -v dnf &> /dev/null; then
            sudo dnf install "$local_path" -y
        elif command -v yum &> /dev/null; then
            sudo yum install "$local_path" -y
        elif command -v rpm &> /dev/null; then
            # Fallback to rpm, but this won't auto-resolve dependencies
            sudo rpm -i "$local_path"
            echo "Note: Dependencies might need to be installed manually."
        else
            echo "Error: Neither dnf, yum nor rpm found for .rpm installation."
            return 1
        fi
    else
        echo "Error: Unrecognized package file format. Only .deb and .rpm supported."
        return 1
    fi

    # Clean up the downloaded file
    rm "$local_path"
    echo "Installation process finished and temporary file removed."
}

# Example Usage (uncomment the line below to test):
# install_package "http://example.com/path/to/your-package.deb"
# install_package "http://example.com/path/to/your-package.rpm"
