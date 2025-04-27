# To run this script:
# 1. Run Windows PowerShell as Administrator
# 2. Run `Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process`
# 3. Run `chezmoi apply ~/.chezmoiscripts/windows/remove-bloat.ps1`
#
# Automate running this script as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "This script must be run as Administrator. Relaunching..."
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File \"$PSCommandPath\"" -Verb RunAs
    exit
}


{{- range .packages.basic.windows.pips -}}
pip install {{ . | quote }}
{{ end -}}


{{- range .packages.basic.windows.junk -}}
    Write-Output "Attempting to remove $item"
    Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*{{ . | quote }}*" } | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like "*{{ . | quote }}*" } | Remove-AppxProvisionedPackage -Online -AllUsers -ErrorAction SilentlyContinue

{{ end -}}


