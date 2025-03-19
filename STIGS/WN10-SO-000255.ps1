<#
.SYNOPSIS
    This PowerShell script enforces User Account Control to automatically deny elevation requests for standard users.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-19
    Last Modified   : 2025-03-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000255.ps1 
#>

# Define the registry path
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Set the ConsentPromptBehaviorUser value to 0
Set-ItemProperty -Path $RegPath -Name "ConsentPromptBehaviorUser" -Value 0 -Type DWord

# Confirm the change
Write-Output "ConsentPromptBehaviorUser has been set to 0."
