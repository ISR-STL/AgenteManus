$env:PYTHONUTF8=1
$env:PYTHONPATH='C:\AgenteManus'
Start-Process -FilePath 'C:\AgenteManus\venv\Scripts\python.exe' -WorkingDirectory 'C:\AgenteManus' -ArgumentList @(
  '-m','uvicorn','app.main:app','--host','127.0.0.1','--port','8811','--log-level','info'
) -WindowStyle Minimized
