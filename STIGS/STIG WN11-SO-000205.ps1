<#
.SYNOPSIS
    STIG WN11-SO-000205 — Set LAN Manager Authentication Level to NTLMv2 Only

.DESCRIPTION
    Ensures LmCompatibilityLevel is set to 5, forcing the system to use NTLMv2
    authentication only and refuse LM and NTLM authentication requests.

    Registry value set:
      HKLM:\SYSTEM\CurrentControlSet\Control\Lsa
      LmCompatibilityLevel = 5 (REG_DWORD)

    LmCompatibilityLevel values:
      0 = Send LM and NTLM responses
      1 = Send LM and NTLM, use NTLMv2 session security if negotiated
      2 = Send NTLM response only
      3 = Send NTLMv2 response only
      4 = Send NTLMv2 only, refuse LM
      5 = Send NTLMv2 only, refuse LM and NTLM (required)

.NOTES
    Requires: PowerShell 5.1+ (native to Windows 11)
    Run As:   Administrator
    STIG:     WN11-SO-000205 | V2R7
#>

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'
$RegName  = 'LmCompatibilityLevel'
$RegValue = 5
$RegType  = 'DWord'

$LevelMap = @{
    0 = 'Send LM and NTLM responses'
    1 = 'Send LM and NTLM, use NTLMv2 session security if negotiated'
    2 = 'Send NTLM response only'
    3 = 'Send NTLMv2 response only'
    4 = 'Send NTLMv2 only, refuse LM'
    5 = 'Send NTLMv2 only, refuse LM and NTLM (compliant)'
}

# --- Step 1: Pre-Remediation State -------------------------------------------
Write-Host "`n[STEP 1] Checking pre-remediation state..." -ForegroundColor Cyan

try {
    $before = (Get-ItemProperty -Path $RegPath -Name $RegName -ErrorAction SilentlyContinue).$RegName

    if ($null -eq $before) {
        Write-Host "  [FINDING] $RegName does not exist — will be created." -ForegroundColor Red
    } elseif ($before -ne $RegValue) {
        $beforeLabel = if ($LevelMap.ContainsKey([int]$before)) { $LevelMap[[int]$before] } else { "Unknown" }
        Write-Host "  [FINDING] $RegName = $before ($beforeLabel)" -ForegroundColor Red
        Write-Host "  Non-compliant value detected — remediation required." -ForegroundColor Red
    } else {
        $beforeLabel = $LevelMap[[int]$before]
        Write-Host "  [PASS] $RegName = $before ($beforeLabel)" -ForegroundColor Green
        Write-Host "  Already compliant — remediation will still be applied to confirm." -ForegroundColor Yellow
    }
}
catch {
    Write-Warning "  [WARN] Could not read pre-remediation state: $_"
}

# --- Step 2: Apply Remediation -----------------------------------------------
Write-Host "`n[STEP 2] Applying remediation..." -ForegroundColor Cyan

try {
    if (-not (Test-Path -Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
        Write-Host "  [CREATED] Registry key: $RegPath" -ForegroundColor Yellow
    }

    Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType -Force
    Write-Host "  [DONE] $RegName set to $RegValue." -ForegroundColor Green
}
catch {
    Write-Error "  [ERROR] Failed to apply remediation: $_"
    exit 2
}

# --- Step 3: Post-Remediation Verification -----------------------------------
Write-Host "`n[STEP 3] Verifying post-remediation state..." -ForegroundColor Cyan

try {
    $after = (Get-ItemProperty -Path $RegPath -Name $RegName -ErrorAction Stop).$RegName

    if ($after -eq $RegValue) {
        $afterLabel = $LevelMap[[int]$after]
        Write-Host "  [PASS] $RegName = $after ($afterLabel)" -ForegroundColor Green
    } else {
        Write-Warning "  [FAIL] $RegName = $after — expected $RegValue. Remediation may not have applied."
        exit 1
    }
}
catch {
    Write-Error "  [ERROR] Could not verify post-remediation state: $_"
    exit 2
}

# --- Step 4: Confirm Registry Type -------------------------------------------
Write-Host "`n[STEP 4] Confirming registry value type..." -ForegroundColor Cyan

try {
    $regItem = Get-Item -Path $RegPath
    $valType = $regItem.GetValueKind($RegName)

    if ($valType -eq 'DWord') {
        Write-Host "  [PASS] Value type is REG_DWORD — correct." -ForegroundColor Green
    } else {
        Write-Warning "  [WARN] Value type is $valType — expected REG_DWORD."
    }
}
catch {
    Write-Warning "  [WARN] Could not confirm value type: $_"
}

# --- Summary -----------------------------------------------------------------
Write-Host "`n[SUMMARY]" -ForegroundColor Cyan
Write-Host "  Path  : $RegPath" -ForegroundColor White
Write-Host "  Name  : $RegName" -ForegroundColor White
Write-Host "  Type  : REG_DWORD" -ForegroundColor White
Write-Host "  Value : $RegValue ($($LevelMap[$RegValue]))" -ForegroundColor White
Write-Host ""
Write-Host "  STIG WN11-SO-000205: COMPLIANT" -ForegroundColor Green
Write-Host ""
Write-Host "  NOTE: Setting LmCompatibilityLevel to 5 will refuse LM and NTLM" -ForegroundColor Yellow
Write-Host "  authentication requests. Ensure all systems and applications" -ForegroundColor Yellow
Write-Host "  on your network support NTLMv2 before applying in production." -ForegroundColor Yellow
