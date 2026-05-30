# setup.ps1 — Windows helper for Daybreak
# Hermes Agent installs in a Linux environment, so this script sets up WSL,
# then runs the Linux setup.sh inside it.

$ErrorActionPreference = "Stop"

Write-Host "==> Checking for WSL..." -ForegroundColor Cyan
$wsl = Get-Command wsl -ErrorAction SilentlyContinue
if (-not $wsl) {
    Write-Host "WSL not found. Install it (admin PowerShell): wsl --install" -ForegroundColor Yellow
    Write-Host "Then restart and re-run this script." -ForegroundColor Yellow
    exit 1
}

Write-Host "==> WSL found. Running the Linux setup inside WSL..." -ForegroundColor Cyan
# Run from the repo root so the skill file path resolves.
wsl bash -c "cd `"$(($PWD.Path -replace '\\','/') -replace '^([A-Za-z]):','/mnt/`$(echo `$1 | tr A-Z a-z)')`" 2>/dev/null || cd ~; bash setup.sh"

Write-Host ""
Write-Host "If the path translation failed, open WSL manually and run:" -ForegroundColor Yellow
Write-Host "  cd /mnt/d/Hackathon/daybreak && bash setup.sh" -ForegroundColor Yellow
