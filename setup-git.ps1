$ErrorActionPreference = "Stop"

# ----- SETUP GIT -----
Write-Host "`n=== Configuração do Git ==="
$repoDir  = Read-Host "Pasta do repositório (ENTER = C:\AgenteManus)"; if(-not $repoDir){ $repoDir='C:\AgenteManus' }
$gitUser  = Read-Host "Seu usuário do GitHub (sem @)"
$gitEmail = Read-Host "Seu e-mail do GitHub"
$repoName = Read-Host "Nome do repositório no GitHub (ex: AgenteManus)"
$remoteIn = Read-Host "URL remota completa (ENTER = https://github.com/<user>/<repo>.git)"
$remoteUrl = if($remoteIn){ $remoteIn } else { "https://github.com/$gitUser/$repoName.git" }

git --version | Out-Null
git config --global user.name  $gitUser
git config --global user.email $gitEmail
git config --global init.defaultBranch main
git config --global credential.helper manager

if(!(Test-Path $repoDir)){ New-Item -ItemType Directory -Force -Path $repoDir | Out-Null }
Set-Location $repoDir
if(!(Test-Path "$repoDir\.git")){ git init | Out-Null }
git branch -M main 2>$null

# .gitignore básico p/ evitar vazar segredos
$gi = Join-Path $repoDir ".gitignore"
if(!(Test-Path $gi)){
@"
workspace/auth-config.json
workspace/*.secret
*.sqlite*
*.db
.env
__pycache__/
*.pyc
"@ | Set-Content -Encoding UTF8 $gi
}

# remoto
if((git remote) -contains "origin"){ git remote remove origin }
git remote add origin $remoteUrl

# Guardar PAT no Windows Credential Manager (sem mostrar na tela)
function Read-Secret([string]$prompt){
  $sec = Read-Host $prompt -AsSecureString
  $ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec)
  $s   = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
  [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
  return $s
}
$pat = Read-Secret "Cole seu GitHub TOKEN (senha oculta)"
$stdin = "protocol=https`nhost=github.com`nusername=$gitUser`npassword=$pat`n"
$stdin | git credential-manager store | Out-Null
$pat = $null

git add .
git commit -m "Primeiro commit" --allow-empty | Out-Null
git push -u origin main
Write-Host "`nOK: Git configurado e push executado." -ForegroundColor Green
