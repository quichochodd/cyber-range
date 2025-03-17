<#
.SYNOPSIS
    This PowerShell script renames the guest account to "DisabledGuest", you can change it to whatever you want.

.NOTES
    Author          : David Quichocho
    LinkedIn        : linkedin.com/in/quichochodavid/
    GitHub          : github.com/quichochodd
    Date Created    : 2025-03-17
    Last Modified   : 2025-03-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000025.ps1 
#>

# Get the current name of the Guest account
$GuestAccount = Get-WmiObject -Class Win32_UserAccount | Where-Object { $_.SID -like "S-1-5-*-501" }

if ($GuestAccount -and $GuestAccount.Name -eq "Guest") {
    # Define the new name for the Guest account
    $NewName = "DisabledGuest"  # Change this to the desired name
    
    # Rename the Guest account
    Rename-LocalUser -Name "Guest" -NewName $NewName

    Write-Host "Guest account renamed to '$NewName' for security compliance."
} else {
    Write-Host "Guest account is already renamed or does not exist."
}
