$ErrorActionPreference='SilentlyContinue'
$ok = $false
try{
  $r = Invoke-WebRequest -UseBasicParsing 'http://127.0.0.1:8813/api/health' -TimeoutSec 5
  if($r.StatusCode -eq 200){ $ok = $true }
}catch{}
if(-not $ok){ Restart-ScheduledTask -TaskName 'AgenteManus-Backend' }
