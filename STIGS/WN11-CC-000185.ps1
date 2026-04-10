<#
.SYNOPSIS
    STIG WN11-CC-000185 — This command writes a single registry value that prevents Windows from automatically executing autorun commands when removable media (USB drives, CDs, etc.) is inserted. Without this setting, an attacker could craft a malicious drive that silently runs code the moment it's plugged in. Setting NoAutorun to 1 under the Explorer policies key tells Windows to ignore autorun instructions entirely, closing that attack vector.

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2024-09-04
    Last Modified   : 2024-09-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000185.

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000185.ps1 
    
#><#

<#Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoAutorun" -Value 1 -Type DWord -Force
