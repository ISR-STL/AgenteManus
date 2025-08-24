$ErrorActionPreference = "Stop"
Write-Host "`n=== Preenchendo C:\AgenteManus\workspace\auth-config.json ==="
$cfgPath = 'C:\AgenteManus\workspace\auth-config.json'
New-Item -ItemType Directory -Force -Path (Split-Path $cfgPath) | Out-Null

function Read-Secret([string]$prompt){
  $sec = Read-Host $prompt -AsSecureString
  $ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec)
  $s   = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
  [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
  return $s
}

# --- Telegram ---
$tgToken = Read-Secret "Telegram BOT token (ENTER para pular)"
$tgChat  = Read-Host  "chat_id_default (pode ser negativo; ENTER p/ pular)"

# --- GitHub / Vercel / Railway ---
$ghTok = Read-Secret "GitHub PAT (ENTER p/ pular)"
$vcTok = Read-Secret "Vercel token (ENTER p/ pular)"
$rwTok = Read-Secret "Railway token (ENTER p/ pular)"

# --- Observabilidade (opcional) ---
$lokiUrl = Read-Host "Loki push URL (ex: http://host:3100/loki/api/v1/push; ENTER p/ pular)"
$grafUrl = Read-Host "Grafana URL (ex: https://grafana.seu.dom; ENTER p/ pular)"
$grafKey = Read-Secret "Grafana API Key (ENTER p/ pular)"

# Monta estrutura somente com o que foi informado
$cfg = @{ config = @{ auth = @{}; obs = @{} } }

if($tgToken -or $tgChat){
  $tg = @{}
  if($tgToken){ $tg.bot_token = $tgToken }
  if($tgChat){
    if($tgChat -as [int]){ $tg.chat_id_default = [int]$tgChat } else { $tg.chat_id_default = $tgChat }
  }
  $cfg.config.auth.telegram = $tg
}
if($ghTok){ $cfg.config.auth.github  = @{ token = $ghTok } }
if($vcTok){ $cfg.config.auth.vercel  = @{ token = $vcTok } }
if($rwTok){ $cfg.config.auth.railway = @{ token = $rwTok } }

if($lokiUrl){  $cfg.config.obs.loki    = @{ url = $lokiUrl } }
if($grafUrl -or $grafKey){
  $g = @{}
  if($grafUrl){ $g.url = $grafUrl }
  if($grafKey){ $g.api_key = $grafKey }
  $cfg.config.obs.grafana = $g
}

$cfg | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $cfgPath
Write-Host "OK: auth-config salvo em $cfgPath" -ForegroundColor Green
