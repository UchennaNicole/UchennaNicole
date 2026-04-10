 <#
.SYNOPSIS
  STIG WN11-CC-000325 — DConfigures Windows 11 to prevent automatic user sign-in following a system-initiated restart by setting the DisableAutomaticRestartSignOn registry value to 1. This ensures that after a restart triggered by Windows Update or other system processes, the user is required to manually authenticate rather than being signed in automatically, preventing unauthorized access to an unattended system in compliance with DOD requirements.

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2024-10-04
    Last Modified   : 2024-10-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000325

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000325..ps1 
#><#

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$RegName  = 'DisableAutomaticRestartSignOn'
$RegValue = 1
$RegType  = 'DWord'

if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType -Force
