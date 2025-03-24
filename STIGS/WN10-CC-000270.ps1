<#
.SYNOPSIS
    This PowerShell script prevents passwords from being saved in the Remote Desktop Client.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-24
    Last Modified   : 2025-03-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000270

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000270.ps1 
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

# Registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$RegName = "DisablePasswordSaving"
$RegValue = 0x00000001  # Hexadecimal 1

# Ensure the registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type DWord

Write-Host "Registry setting applied successfully!" -ForegroundColor Green
