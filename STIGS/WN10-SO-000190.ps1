<#
.SYNOPSIS
    This PowerShell script enforces a minimum encryption type for Kerberos.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-17
    Last Modified   : 2025-03-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000190

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000190.ps1 
#>

# Define the registry paths and the value to be added
$registryPath1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos"
$registryPath2 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$registryKey = "SupportedEncryptionTypes"
$registryValue = 2147483640 # Equivalent to dword:7ffffff8

# Check if the registry path exists, if not create it
if (-not (Test-Path $registryPath1)) {
    New-Item -Path $registryPath1 -Force
}

if (-not (Test-Path $registryPath2)) {
    New-Item -Path $registryPath2 -Force
}

# Set the registry value for SupportedEncryptionTypes
Set-ItemProperty -Path $registryPath2 -Name $registryKey -Value $registryValue

Write-Output "Registry key $registryKey has been set to $registryValue"
