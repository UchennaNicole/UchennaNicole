 <#
.SYNOPSIS
  STIG WN11-CC-000252—CConfigures Windows 11 to disable the Xbox Game Bar and Game DVR feature by setting the AllowGameDVR registry value to 0. This prevents users from recording, broadcasting, and capturing gameplay, reducing unnecessary background processes and eliminating a potential data exfiltration vector in compliance with DOD requirements. Not applicable on Windows 11 LTSC installations.

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2026-10-04
    Last Modified   : 2026-10-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000252

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000252.ps1 
#><#

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR'
$RegName  = 'AllowGameDVR'
$RegValue = 0
$RegType  = 'DWord'

if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType -Force
