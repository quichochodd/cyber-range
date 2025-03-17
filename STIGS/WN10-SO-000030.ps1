<#
.SYNOPSIS
    This PowerShell script enables audit policy using subcategories.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-17
    Last Modified   : 2025-03-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000030.ps1 
#>

# Define the registry path and key for Lsa
$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegistryKey = "SCENoApplyLegacyAuditPolicy"
$Value = 1  # Set to 1 to enable the policy

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force
}

# Set the registry key for SCENoApplyLegacyAuditPolicy
Set-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $Value

Write-Host "'SCENoApplyLegacyAuditPolicy' registry key has been set to 1."
