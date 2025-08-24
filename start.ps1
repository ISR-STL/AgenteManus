param([switch]$Logs,[switch]$Build)
$ErrorActionPreference="Stop"
Set-Location $PSScriptRoot
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) { throw "Docker Desktop não encontrado. Instale e tente novamente." }
$composeCmd = if (Get-Command docker-compose -ErrorAction SilentlyContinue) { "docker-compose" } else { "docker compose" }
if ($Build) { & $composeCmd build --no-cache }
& $composeCmd up -d
if ($Logs) { & $composeCmd logs -f }
