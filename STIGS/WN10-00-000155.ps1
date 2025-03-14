<#
.SYNOPSIS
    This PowerShell script mitigates against a downgrade attack.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-14
    Last Modified   : 2025-03-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000155

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-00-000155.ps1 
#>

# Run this script with elevated privileges (Admin)

# Get the status of PowerShell 2.0 features
$psv2Features = Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -like "*PowerShellv2*" }

# Check if either feature is enabled
$enabledFeatures = $psv2Features | Where-Object { $_.State -eq "Enabled" }

if ($enabledFeatures) {
    Write-Host "PowerShell 2.0 is enabled. Disabling it now..." -ForegroundColor Yellow
    
    # Disable PowerShell 2.0 and PowerShell 2.0 Engine
    foreach ($feature in $enabledFeatures) {
        Disable-WindowsOptionalFeature -Online -FeatureName $feature.FeatureName -NoRestart
        Write-Host "Disabled: $($feature.FeatureName)" -ForegroundColor Green
    }

    Write-Host "PowerShell 2.0 has been disabled. A restart is recommended." -ForegroundColor Cyan
} else {
    Write-Host "PowerShell 2.0 is already disabled. No action needed." -ForegroundColor Green
}
