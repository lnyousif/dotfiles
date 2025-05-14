# Add commands to install tools here

# Cleanup operations
Write-Host -ForegroundColor Cyan "======================================================"
Write-Host -ForegroundColor Cyan "🧹 Almost done! Performing final cleanup operations..."
Write-Host -ForegroundColor Cyan "======================================================"

Write-Host -ForegroundColor Yellow "Removing temporary directory..."
if (Test-Path "$env:USERPROFILE\.temp") {
    Remove-Item -Path "$env:USERPROFILE\.temp" -Recurse -Force
    Write-Host -ForegroundColor Green "✅ Cleanup complete!"
} else {
    Write-Host -ForegroundColor Yellow "Temp directory not found. Skipping cleanup."
}

Write-Host -ForegroundColor Magenta "Windows machine setup completed."
