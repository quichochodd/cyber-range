<#
.SYNOPSIS
    This PowerShell script ensures that ECC curves with longer key lengths are required to be prioritized first, which ensures that more secure algorithms are used.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-14
    Last Modified   : 2025-03-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000052.ps1 
#>

# Define registry path and value name
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$ValueName = "EccCurves"
$ExpectedValues = @("NistP384", "NistP256")  # Expected multi-string values

# Check if the registry path exists
if (-not (Test-Path $RegPath)) {
    Write-Output "Registry path does not exist. Creating it..."
    New-Item -Path $RegPath -Force | Out-Null
}

# Check if the registry value exists
$ExistingValue = Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue

if ($ExistingValue -and ($ExistingValue.$ValueName -eq $ExpectedValues)) {
    Write-Output "Registry value is already configured correctly."
} else {
    Write-Output "Registry value is missing or incorrect. Setting it now..."
    Set-ItemProperty -Path $RegPath -Name $ValueName -Type MultiString -Value $ExpectedValues
    Write-Output "Registry value updated successfully."
}
