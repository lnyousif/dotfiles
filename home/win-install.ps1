# Windows Installation Script for Dotfiles

# Install Chocolatey if not installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install chezmoi
choco install chezmoi -y

# Initialize chezmoi
chezmoi init --apply

# Post-installation steps
# Add any additional setup commands here

Write-Host "Dotfiles setup complete!"