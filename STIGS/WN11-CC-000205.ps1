 <#
.SYNOPSIS
  STIG WN11-CC-000205 — Restrict Windows Telemetry. Configures Windows 11 to limit the amount of diagnostic data sent to Microsoft by setting the `AllowTelemetry` registry value to `0` (Security level), the most restrictive setting. This prevents the OS from transmitting full diagnostic and usage data to Microsoft servers, reducing the system's data exposure footprint in compliance with DOD requirements.

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2026-10-04
    Last Modified   : 2026-10-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WWN11-CC-000205 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000205.ps1 
#><#

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
$RegName  = 'AllowTelemetry'
$RegValue = 0
$RegType  = 'DWord'

if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType -Force
