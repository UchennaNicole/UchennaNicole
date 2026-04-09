 <#
.SYNOPSIS
  STIG WN11-CC-000038 — Disable WDigest Authentication (UseLogonCredential)

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2024-09-04
    Last Modified   : 2024-09-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000038

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000038.ps1 
#><#

.DESCRIPTION
    Sets HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest\UseLogonCredential
    to 0 (REG_DWORD), preventing Windows from storing plaintext credentials in memory
    for the WDigest authentication provider.

.NOTES
    Requires: PowerShell 5.1+ (native to Windows 11)
    Run As:   Administrator
    STIG:     WN11-CC-000038 | V2R7
#>

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest'
$RegName  = 'UseLogonCredential'
$RegValue = 0
$RegType  = 'DWord'

try {
    if (-not (Test-Path -Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
        Write-Host "[CREATED] Registry key: $RegPath" -ForegroundColor Yellow
    }

    Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType -Force

    $actual = (Get-ItemProperty -Path $RegPath -Name $RegName).$RegName

    if ($actual -eq $RegValue) {
        $hex = '0x{0:X8}' -f $actual
        Write-Host "[PASS] $RegName = $actual ($hex)" -ForegroundColor Green
    } else {
        Write-Warning "[FAIL] $RegName = $actual — expected $RegValue"
        exit 1
    }
}
catch {
    Write-Error "[ERROR] $_"
    exit 2
}
