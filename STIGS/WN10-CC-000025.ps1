<#
.SYNOPSIS
    This PowerShell script prevents IP source routing.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-19
    Last Modified   : 2025-03-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000025.ps1 
#>

# Define the registry path
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$RegName = "DisableIPSourceRouting"
$RegValue = 2

# Check if the registry key exists
if (!(Test-Path $RegPath)) {
    Write-Output "Registry path does not exist. Creating path..."
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type DWord
Write-Output "Registry value '$RegName' set to '$RegValue'."

# Confirm the change
Get-ItemProperty -Path $RegPath -Name $RegName

# Restart required for changes to take effect
Write-Output "A system restart may be required for the changes to apply."
