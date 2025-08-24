param(
  [ValidateSet('list','run')][string]$cmd='run',
  [string]$skill,
  [string]$payload='{}',
  [int]$port=8813,
  [switch]$wait
)
function _get($u){
  try { Invoke-RestMethod -Uri $u -TimeoutSec 10 }
  catch { Write-Error "Falha no GET: $($_.Exception.Message)"; throw }
}
if($cmd -eq 'list'){
  (_get "http://127.0.0.1:$port/list_skills").skills -join ', '
  exit
}
try{
  $pl = if($payload){ ConvertFrom-Json $payload } else { @{} }
} catch{
  Write-Error 'Payload JSON inválido'; exit 1
}
$body  = @{ skill=$skill; payload=$pl } | ConvertTo-Json -Depth 20
$bytes = [Text.Encoding]::UTF8.GetBytes($body)
try{
  $job = Invoke-RestMethod "http://127.0.0.1:$port/run" -Method POST -ContentType 'application/json; charset=utf-8' -Body $bytes
} catch{
  Write-Error "Falha no POST /run: $($_.Exception.Message)"; exit 1
}
if(-not $wait){
  (_get "http://127.0.0.1:$port/status/$($job.job_id)")
  exit
}
$deadline=(Get-Date).AddSeconds(90)
do{
  try{ $st = _get "http://127.0.0.1:$port/status/$($job.job_id)" } catch { Write-Error 'Falha no GET /status'; break }
  if($st.status -in 'DONE','ERROR','FAILED'){ break }
  Start-Sleep -Milliseconds 300
} while((Get-Date) -lt $deadline)
$st
