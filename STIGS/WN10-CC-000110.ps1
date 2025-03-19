<#
.SYNOPSIS
    This PowerShell script prevents printing over HTTP.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-19
    Last Modified   : 2025-03-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000110.ps1 
#>

# Function to check if script is running as Administrator
function Check-Admin {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($user)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$RegName = "DisableHTTPPrinting"
$RegValue = 1

# Ensure the registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type DWord

Write-Host "Registry setting applied successfully!" -ForegroundColor Green
