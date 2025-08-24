# start_manus.ps1 - inicia backend oculto, sem flicker, com log
$ErrorActionPreference='SilentlyContinue'
$repo = 'C:\AgenteManus'
$log  = Join-Path $repo 'logs\backend.log'
$py   = Join-Path $repo 'venv\Scripts\python.exe'
if(-not (Test-Path $py)){ & py -3 -m venv (Join-Path $repo 'venv') }
& $py -m pip -q install -U pip >$null 2>&1
if(Test-Path (Join-Path $repo 'requirements.txt')){ & $py -m pip -q install -r (Join-Path $repo 'requirements.txt') >$null 2>&1 }
$env:PYTHONPATH=$repo; $env:PYTHONUNBUFFERED='1'
# tenta alguns alvos ASGI conhecidos e usa o primeiro que subir
$targets = @('app.main:app','core.agent_core:app','app:app','main:app')
foreach($t in $targets){
  $args = @('-m','uvicorn',$t,'--host','127.0.0.1','--port','8813','--no-access-log','--log-level','warning','--no-server-header')
  try{
    Start-Process -FilePath $py -ArgumentList ($args -join ' ') -WindowStyle Hidden 
      -RedirectStandardOutput $log -RedirectStandardError $log
    break
  }catch{}
}
