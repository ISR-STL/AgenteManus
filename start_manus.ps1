$ErrorActionPreference='Stop'
$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repo
$py  = Join-Path $repo 'venv\Scripts\python.exe'
if(!(Test-Path $py)){ $py = 'python.exe' }
$log = Join-Path $repo 'logs\backend.log'
$arg = "-m uvicorn app.main:app --host 0.0.0.0 --port 8813 --no-access-log --log-level warning"
Start-Process -FilePath $py -ArgumentList $arg -WindowStyle Hidden 
  -RedirectStandardOutput $log -RedirectStandardError $log
