<#
.SYNOPSIS
    This PowerShell script enforces password prompting on resume from sleep (plugged in).

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-24
    Last Modified   : 2025-03-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000150

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000150.ps1 
#>

# Function to check if script is running as Administrator
function Check-Admin {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($user)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Alert and exit if not running as Administrator
if (-not (Check-Admin)) {
    Write-Host "Error: This script must be run as Administrator!" -ForegroundColor Red
    exit
}

# Registry paths
$BasePath = "HKLM:\SOFTWARE\Policies\Microsoft\Power"
$PowerSettingsPath = "$BasePath\PowerSettings"
$SettingPath = "$PowerSettingsPath\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"

# Registry value name and value
$RegName = "ACSettingIndex"
$RegValue = 0x00000001  # Hexadecimal 1

# Ensure the registry paths exist
foreach ($Path in @($BasePath, $PowerSettingsPath, $SettingPath)) {
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
}

# Set the registry value
Set-ItemProperty -Path $SettingPath -Name $RegName -Value $RegValue -Type DWord

Write-Host "Registry setting applied successfully!" -ForegroundColor Green
