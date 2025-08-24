$payload = '{ "config_path":"C:\\AgenteManus\\workspace\\auth-config.json" }'
& C:\AgenteManus\manus-cli.ps1 run -port 8813 -skill poll_telegram -payload $payload | Out-Null
