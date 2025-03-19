<#
.SYNOPSIS
    This PowerShell script enforces that User Account Control prompts administrators for consent on the secure desktop.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-19
    Last Modified   : 2025-03-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000250

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000250.ps1 
#>

# Define the registry path
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Set the ConsentPromptBehaviorAdmin value to 2
Set-ItemProperty -Path $RegPath -Name "ConsentPromptBehaviorAdmin" -Value 2 -Type DWord

# Confirm the change
Write-Output "ConsentPromptBehaviorAdmin has been set to 2."
