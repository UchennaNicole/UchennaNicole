 <#
.SYNOPSIS
  STIG WN11-CC-000197 —Configures Windows 11 to disable Microsoft consumer features by setting the DisableWindowsConsumerFeatures registry value to 1. This prevents Microsoft from automatically installing suggested apps, displaying third-party app suggestions on the Start menu, and pushing consumer-oriented content to the system — reducing unsolicited software installation and data sharing in compliance with DOD requirements.

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2026-10-04
    Last Modified   : 2026-10-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WWN11-CC-000197.ps1 
#><#

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
$RegName  = 'DisableWindowsConsumerFeatures'
$RegValue = 1
$RegType  = 'DWord'

if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType -Force
