try {
  $ok = (Invoke-RestMethod http://127.0.0.1:8813/health -TimeoutSec 3).ok
  if(-not $ok){ schtasks /Run /TN ManusBackend8813 | Out-Null }
} catch {
  schtasks /Run /TN ManusBackend8813 | Out-Null
}
