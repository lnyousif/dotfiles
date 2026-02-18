# Improved Windows Installation Script for Dotfiles

# Stop on first error
$ErrorActionPreference = "Stop"

Write-Host "======================================================"
Write-Host "      Dotfiles Installation Script for Windows"
Write-Host "======================================================"

# Function for error handling
function Exit-WithError {
    param(
        [string]$ErrorMessage
    )
    Write-Host "ERROR: $ErrorMessage" -ForegroundColor Red
    Exit 1
}

# Function to check if running as Administrator
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Check if running as Administrator
if (-not (Test-Administrator)) {
    Write-Host "WARNING: This script should be run as Administrator for full functionality." -ForegroundColor Yellow
    $response = Read-Host "Continue anyway? (y/N)"
    if ($response.ToLower() -ne "y") {
        Exit
    }
}

# Function to install dependencies
function Install-Dependencies {
    Write-Host "Installing required dependencies..."

    # Check if winget is installed
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "winget is not installed. Attempting to install winget..."
        try {
            # Install winget via App Installer package
            Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile "$env:TEMP\AppInstaller.msixbundle" -UseBasicParsing
            Add-AppxPackage -Path "$env:TEMP\AppInstaller.msixbundle"
        }
        catch {
            Exit-WithError "Failed to install winget. $($_.Exception.Message)"
        }
    }

    # Install chezmoi or update if already installed
    if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
        Write-Host "Installing chezmoi using winget..."
        try {
            winget install -e --id twpayne.chezmoi -h
        }
        catch {
            Exit-WithError "Failed to install chezmoi using winget. $($_.Exception.Message)"
        }
    }
    else {
        Write-Host "chezmoi is already installed"
        try {
            Write-Host "Upgrading chezmoi using winget..."
            winget upgrade -e --id twpayne.chezmoi -h
        }
        catch {
            Write-Host "Warning: Could not upgrade chezmoi using winget" -ForegroundColor Yellow
        }
    }
}

# Function to switch git remote between HTTPS and SSH
function Switch-GitRemote {
    chezmoi cd
    # Script to toggle origin remote between HTTPS and SSH
    Write-Host "Toggling origin remote between HTTPS and SSH..."

    # Get the current origin URL
    $currentUrl = git remote get-url origin

    # Check if the URL is HTTPS or SSH
    if ($currentUrl -like "https://*") {
        # Convert HTTPS URL to SSH URL
        $sshUrl = $currentUrl -replace "https://", "git@" -replace "/", ":" -replace "\.com/", ".com:"

        # Set the new SSH URL as the origin remote
        git remote set-url origin "$sshUrl"
        Write-Host "Origin remote switched to SSH: $sshUrl"
    }
    elseif ($currentUrl -like "git@*") {
        # Convert SSH URL to HTTPS URL
        $httpsUrl = $currentUrl -replace "git@", "https://" -replace ":", "/" -replace "\.com:", ".com/"

        # Set the new HTTPS URL as the origin remote
        git remote set-url origin "$httpsUrl"
        Write-Host "Origin remote switched to HTTPS: $httpsUrl"
    }
    else {
        Write-Host "Origin remote URL format not recognized. No changes made."
    }
}

# Main installation process
function Install-Dotfiles {
    Write-Host "This script will setup .dotfiles for you."
    Write-Host "    Press any key to continue or Ctrl+C to abort..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Write-Host ""

    Install-Dependencies

    Write-Host "Installing dotfiles with chezmoi..."

    # Create backup of existing configuration
    $backupDir = Join-Path $env:USERPROFILE "dotfiles_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Write-Host "Creating backup of existing configuration to $backupDir"
    New-Item -Path $backupDir -ItemType Directory -Force | Out-Null

    # Backup important existing dotfiles (PowerShell profiles and configuration files)
    $filesToBackup = @(
        "$env:USERPROFILE\.gitconfig",
        "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
        "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    )

    foreach ($file in $filesToBackup) {
        if (Test-Path $file) {
            try {
                Copy-Item -Path $file -Destination $backupDir -Force
            }
            catch {
                Write-Host "Warning: Failed to backup $file" -ForegroundColor Yellow
            }
        }
    }

    # Initialize and apply chezmoi
    Write-Host "Initializing chezmoi..."
    try {
        chezmoi init --apply
    }
    catch {
        Exit-WithError "Failed to initialize and apply chezmoi. $($_.Exception.Message)"
    }

    # Perform Windows specific post-installation tasks
    if (Test-Path "$env:USERPROFILE\.windows-settings.ps1") {
        Write-Host "Applying Windows specific settings..."
        try {
            & "$env:USERPROFILE\.windows-settings.ps1"
        }
        catch {
            Write-Host "Warning: Failed to apply some Windows settings" -ForegroundColor Yellow
        }
    }

    Write-Host "======================================================"
    Write-Host "Dotfiles setup complete!" -ForegroundColor Green
    Write-Host "   Backup of previous configuration saved to: $backupDir"
    Write-Host "======================================================"

    Write-Host "Switching git remote to SSH..."
    # Switch git remote to SSH
    Switch-GitRemote
    Write-Host "Git remote switched successfully."
}

# Run the main function
Install-Dotfiles
