<#
.SYNOPSIS
    This PowerShell script prevents users from receiving suggestions for 3rd party or additional applications.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-19
    Last Modified   : 2025-03-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000390

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000390.ps1 
#>

# Define the registry path and property
$RegPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$RegName = "DisableThirdPartySuggestions"
$RegValue = 1

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type DWord

# Verify the change
$Result = Get-ItemProperty -Path $RegPath -Name $RegName
Write-Output "Registry setting applied: $RegName = $($Result.$RegName)"
