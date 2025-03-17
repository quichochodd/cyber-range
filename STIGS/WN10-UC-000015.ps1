<#
.SYNOPSIS
    This PowerShell script enforces turning off toast notifications to the lock screen.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-17
    Last Modified   : 2025-03-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-UC-000015

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-UC-000015.ps1 
#>

# Define the registry path and key for Push Notifications
$RegistryPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
$RegistryKey = "NoToastApplicationNotificationOnLockScreen"
$Value = 1  # Set to 1 to disable toast notifications on the lock screen

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force
}

# Set the registry key for NoToastApplicationNotificationOnLockScreen
Set-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $Value

Write-Host "'NoToastApplicationNotificationOnLockScreen' registry key has been set to disable toast notifications on the lock screen."
