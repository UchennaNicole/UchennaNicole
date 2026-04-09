 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Uchenna Nwankwo
    LinkedIn        : linkedin.com/in/uchennanwankwo/
    GitHub          : github.com/uchennanicole
    Date Created    : 2026-09-04
    Last Modified   : 2026-09-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500.ps1 
#>

# WN11-AU-000500: Application Event Log Size must be configured to 32768 KB or greater
# Sets MaxSize to 0x8000 (32768 KB) under the EventLog Application policy key

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName    = "MaxSize"
$valueData    = 0x00008000
$valueType    = "DWord"

# Create the key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Registry path created: $registryPath"
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type $valueType

# Verify the change was applied
$result = Get-ItemProperty -Path $registryPath -Name $valueName
Write-Host "Registry value set successfully."
Write-Host "Path  : $registryPath"
Write-Host "Name  : $valueName"
Write-Host "Value : 0x$('{0:X8}' -f $result.$valueName) ($($result.$valueName) decimal)"
