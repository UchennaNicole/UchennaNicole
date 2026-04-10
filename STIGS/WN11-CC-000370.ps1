 <#
.SYNOPSIS
    Configures Windows 11 to disable the convenience PIN login option for domain accounts by setting the AllowDomainPINLogon registry value to 0. This ensures users cannot authenticate using a simple numeric PIN in place of their domain password or smartcard, enforcing stronger authentication methods and reducing the risk of unauthorized access through weak credentials in compliance with DOD requirements.

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2026-10-04
    Last Modified   : 2026-10-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000370.ps1 
#>

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\Software\Policies\Microsoft\Windows\System'
$RegName  = 'AllowDomainPINLogon'
$RegValue = 0
$RegType  = 'DWord'

if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType -Force
