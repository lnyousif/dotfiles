New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force

New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "EnableDynamicContentInWSB" -PropertyType DWORD -Value 0

Add-Content -Path $PROFILE -Value 'Invoke-Expression (&starship init powershell)'