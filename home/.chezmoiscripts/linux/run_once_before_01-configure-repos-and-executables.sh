#!/usr/bin/env bash
# shellcheck disable=SC2312
set -e
LINE="-------------------------------------------"


if command -v apt &>/dev/null; then
  echo "Debian based system found!"
  # Install Nala
  if command -v nala &>/dev/null; then
    echo "Nala is already installed. Skipping"
  else
    curl https://gitlab.com/volian/volian-archive/-/raw/main/install-nala.sh | bash
    sudo apt install -t nala nala
  fi

  # Setup Nala
  sudo nala fetch --auto -y --https-only --non-free
  sudo nala install --update -y curl wget git ca-certificates libfuse2 gnupg2

elif command -v dnf &>/dev/null; then

  # Install dnf5 for faster downloads
  sudo dnf install dnf5

  # modify dnf settings for faster downloads
  CONF_FILE=/etc/dnf/dnf.conf

  if ! grep -q "max_parallel_downloads=10" "${CONF_FILE}"; then
    echo "max_parallel_downloads=10" | sudo tee -a "${CONF_FILE}"
    echo "dnf downloads are now parallel!"
  fi

  if ! grep -q "fastestmirror=True" "${CONF_FILE}"; then
    echo "fastestmirror=True" | sudo tee -a "${CONF_FILE}"
    echo "dnf downloads are now faster!"
  fi

  if ! grep -q 'alias dnf="dnf5"' "${HOME}/.bashrc"; then
    echo 'alias dnf="dnf5"' | sudo tee -a ~/.bashrc
    echo "dnf is now an alias for dnf5!"
  fi

  # Update System
  sudo dnf update -y

  # Add Repositories
  echo "Setting up repositories"
  sudo dnf -y install dnf-plugins-core


  trap 'rm -fr /tmp/dra' EXIT
  ## Download dra executable
  curl -s https://api.github.com/repos/devmatteini/dra/releases/latest | grep browser_download_url | cut -d : -f 2,3 | tr -d \" | grep linux | grep gnu | grep x86 | wget -P /tmp/dra -qi -
  filename=$(ls /tmp/dra)
  tarfile="${filename%.*}"
  filedir="${tarfile%.*}"
  tar -xvzf /tmp/dra/"${filename}" -C /tmp/dra
  mkdir -p "${HOME}"/.local/bin
  cp /tmp/dra/"${filedir}"/dra "${HOME}"/.local/bin
  rm -fr /tmp/dra

elif command -v pacman &>/dev/null; then
  if ! grep -q '\[chaotic-aur\]' /etc/pacman.conf; then
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    sudo echo '[chaotic-aur]' | sudo tee -a /etc/pacman.conf
    sudo echo 'Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf
    echo "Chaotic AUR Repo added!"
  else
    echo "Chaotic AUR Repo already present."
  fi
else
  echo "Nothing to do on non unknown systems."
fi
