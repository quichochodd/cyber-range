<#
.SYNOPSIS
    This PowerShell script disables autoplay for all drives.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-20
    Last Modified   : 2025-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000190

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000190.ps1 
#>

# Function to check if script is running as Administrator
function Check-Admin {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($user)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Relaunch as Administrator if not already running with elevated privileges
if (-not (Check-Admin)) {
    Write-Host "Run script with Administrator privileges..." -ForegroundColor Yellow
    exit
}

# Registry path
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$RegName = "NoDriveTypeAutoRun"
$RegValue = 0x000000ff  # Hexadecimal FF (255 in decimal)

# Ensure the registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type DWord

Write-Host "Registry setting applied successfully!" -ForegroundColor Green
