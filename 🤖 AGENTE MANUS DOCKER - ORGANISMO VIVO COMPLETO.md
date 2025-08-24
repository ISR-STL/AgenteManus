# 🤖 AGENTE MANUS DOCKER - ORGANISMO VIVO COMPLETO

## 📋 INSTRUÇÕES COMPLETAS DE INSTALAÇÃO E USO

### 🎯 O QUE É O AGENTE MANUS DOCKER

O Agente Manus Docker é um **organismo vivo digital** completo que funciona como um assistente autônomo especializado em múltiplas áreas. Ele roda em containers Docker para máxima confiabilidade e opera 24/7 sem interrupções.

### 🔧 ESPECIALIDADES INTEGRADAS

✅ **Marketing Tático** - Campanhas, SEO, Social Media, Analytics
✅ **Trading & Arbitragem** - Análise técnica, Bots, Gestão de risco
✅ **Saúde & Bem-estar** - Diagnósticos, Sintomas, Prevenção
✅ **Personal Trainer** - Treinos, Musculação, Condicionamento
✅ **Nutricionista IA** - Dietas, Cardápios, Suplementação
✅ **Office Automation** - Excel, Word, PowerPoint, PDF, Dashboards
✅ **Automação Windows** - Scripts, Tarefas, Monitoramento, Integração
✅ **IA Geral** - Análise, Pesquisa, Criação, Consultoria

---

## 🚀 INSTALAÇÃO RÁPIDA

### 1️⃣ MÉTODO MAIS FÁCIL (Recomendado)

1. **Baixe o arquivo:** `AGENTE_MANUS_DOCKER_COMPLETO.ps1`
2. **Clique com botão direito** → "Executar com PowerShell"
3. **Aguarde a instalação** (5-10 minutos)
4. **Clique no atalho** "🤖 Agente Manus Docker" na área de trabalho

### 2️⃣ MÉTODO MANUAL

```powershell
# Execute no PowerShell como Administrador
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\AGENTE_MANUS_DOCKER_COMPLETO.ps1
```

---

## 🎮 COMANDOS DE ATIVAÇÃO

### 📱 INÍCIO RÁPIDO (Mais Fácil)

```bash
# Clique duas vezes no atalho da área de trabalho:
🤖 Agente Manus Docker
```

### 💻 VIA POWERSHELL

```powershell
# Navegar para pasta de instalação
cd "C:\AgenteManus"

# Iniciar agente (modo background)
.\start.ps1

# Iniciar com logs visíveis
.\start.ps1 -Logs

# Reconstruir e iniciar (após mudanças)
.\start.ps1 -Build
```

### 🖥️ VIA PROMPT DE COMANDO

```cmd
# Navegar para pasta
cd /d "C:\AgenteManus"

# Iniciar agente
start.bat
```

### 🐳 COMANDOS DOCKER DIRETOS

```bash
# Verificar status
docker-compose ps

# Ver logs em tempo real
docker-compose logs -f

# Parar agente
docker-compose down

# Parar e limpar tudo
docker-compose down -v --remove-orphans

# Atualizar agente
docker-compose pull && docker-compose up -d
```

---

## 🌐 ACESSO E INTERFACE

### 🔗 URLs de Acesso

- **Interface Principal:** http://localhost:8080
- **API Documentation:** http://localhost:8080/docs
- **Health Check:** http://localhost:8080/health
- **WebSocket:** ws://localhost:8080/ws

### 🎛️ Como Usar a Interface

1. **Abra o navegador** em http://localhost:8080
2. **Clique em "INICIAR ORGANISMO"** para ativar todas as especialidades
3. **Selecione um especialista** clicando nos cards coloridos
4. **Digite seu pedido** na caixa de texto
5. **Clique em "Executar Pedido"** e aguarde o resultado

---

## 💬 EXEMPLOS DE PEDIDOS POR ESPECIALIDADE

### 📈 MARKETING TÁTICO
```
"Crie uma campanha completa para lançamento de produto"
"Desenvolva estratégia de SEO para meu site"
"Monte calendário de conteúdo para redes sociais"
"Analise concorrentes e sugira melhorias"
```

### 💹 TRADING & ARBITRAGEM
```
"Encontre oportunidades de arbitragem em crypto"
"Faça análise técnica do Bitcoin"
"Crie um bot de trading automatizado"
"Analise riscos do meu portfólio"
```

### 🏥 SAÚDE & BEM-ESTAR
```
"Analise meus sintomas: dor de cabeça e fadiga"
"Recomende exames preventivos para minha idade"
"Crie plano de prevenção personalizado"
"Interprete meus exames de sangue"
```

### 💪 PERSONAL TRAINER
```
"Crie treino de musculação para iniciantes"
"Monte plano de condicionamento físico"
"Desenvolva programa de HIIT"
"Faça avaliação física completa"
```

### 🥗 NUTRICIONISTA IA
```
"Monte dieta para ganho de massa muscular"
"Crie cardápio semanal balanceado"
"Calcule minhas necessidades calóricas"
"Recomende suplementação adequada"
```

### 📊 OFFICE AUTOMATION
```
"Crie planilha de controle financeiro avançada"
"Desenvolva dashboard executivo"
"Automatize relatórios mensais"
"Monte apresentação de vendas"
```

### 🔧 AUTOMAÇÃO WINDOWS
```
"Automatize backup de arquivos importantes"
"Crie script de limpeza do sistema"
"Configure monitoramento de performance"
"Integre sistemas via API"
```

### 🧠 IA GERAL
```
"Pesquise tendências de mercado em IA"
"Analise este documento e extraia insights"
"Otimize meu processo de trabalho"
"Crie estratégia de inovação"
```

---

## 🔧 SOLUÇÃO DE PROBLEMAS

### ❌ Problemas Comuns

#### 🐳 Docker não está rodando
```bash
# Solução:
1. Abra Docker Desktop
2. Aguarde inicializar completamente
3. Execute novamente: .\start.ps1
```

#### 🔌 Porta 8080 ocupada
```bash
# Verificar o que está usando a porta:
netstat -ano | findstr :8080

# Parar processo:
taskkill /PID [número_do_processo] /F

# Ou editar docker-compose.yml para usar outra porta
```

#### 📁 Erro de permissão
```bash
# Execute PowerShell como Administrador:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### 🔄 Container não inicia
```bash
# Ver logs detalhados:
docker-compose logs agente-manus

# Reconstruir imagem:
docker-compose build --no-cache
docker-compose up -d
```

### 🛠️ Comandos de Diagnóstico

```bash
# Verificar Docker
docker --version
docker-compose --version

# Status dos containers
docker-compose ps

# Logs detalhados
docker-compose logs -f agente-manus

# Recursos do sistema
docker stats

# Acessar container
docker exec -it agente-manus bash
```

---

## 📁 ESTRUTURA DE ARQUIVOS

```
C:\AgenteManus\
├── 📄 docker-compose.yml          # Configuração Docker
├── 📄 Dockerfile                  # Imagem Docker
├── 📄 requirements.txt            # Dependências Python
├── 📄 start.ps1                   # Script PowerShell
├── 📄 start.bat                   # Script Batch
├── 📁 app\                        # Código da aplicação
│   ├── 📄 main.py                 # Aplicação principal
│   └── 📁 modules\                # Módulos especializados
├── 📁 data\                       # Dados persistentes
├── 📁 logs\                       # Logs do sistema
├── 📁 config\                     # Configurações
└── 📁 scripts\                    # Scripts auxiliares
```

---

## 🔐 SEGURANÇA E BACKUP

### 🛡️ Configurações de Segurança

- **Containers isolados** - Ambiente seguro e controlado
- **Dados persistentes** - Informações salvas em volumes Docker
- **Logs auditáveis** - Registro completo de atividades
- **Acesso local** - Interface disponível apenas localmente

### 💾 Backup Automático

```bash
# Backup manual dos dados
docker run --rm -v agentmanus_data:/data -v C:\Backup:/backup alpine tar czf /backup/backup_$(date +%Y%m%d_%H%M%S).tar.gz -C /data .

# Restaurar backup
docker run --rm -v agentmanus_data:/data -v C:\Backup:/backup alpine tar xzf /backup/backup_YYYYMMDD_HHMMSS.tar.gz -C /data
```

---

## 📊 MONITORAMENTO E MÉTRICAS

### 📈 Métricas Disponíveis

- **Status do sistema** - CPU, memória, disco
- **Performance dos módulos** - Tempo de resposta
- **Logs de atividade** - Histórico completo
- **Estatísticas de uso** - Pedidos por especialidade

### 🔍 Endpoints de Monitoramento

```bash
# Status geral
curl http://localhost:8080/health

# Métricas detalhadas
curl http://localhost:8080/api/status

# Logs via API
curl http://localhost:8080/api/logs
```

---

## 🚀 ATUALIZAÇÕES E MANUTENÇÃO

### 🔄 Atualizar o Sistema

```bash
# Parar agente
docker-compose down

# Baixar atualizações
docker-compose pull

# Reconstruir se necessário
docker-compose build --no-cache

# Iniciar atualizado
docker-compose up -d
```

### 🧹 Limpeza de Sistema

```bash
# Limpar containers antigos
docker system prune -f

# Limpar volumes não utilizados
docker volume prune -f

# Limpar imagens antigas
docker image prune -a -f
```

---

## 📞 SUPORTE E RECURSOS

### 🆘 Onde Buscar Ajuda

1. **Logs do sistema** - `docker-compose logs -f`
2. **Health check** - http://localhost:8080/health
3. **Documentação API** - http://localhost:8080/docs
4. **Arquivo de comandos** - `C:\AgenteManus\COMANDOS_ATIVACAO.txt`

### 📚 Recursos Adicionais

- **Docker Documentation** - https://docs.docker.com/
- **PowerShell Guide** - https://docs.microsoft.com/powershell/
- **FastAPI Docs** - https://fastapi.tiangolo.com/

---

## 🎉 CONCLUSÃO

O **Agente Manus Docker** é seu assistente digital completo, funcionando como um organismo vivo que:

✅ **Opera 24/7** sem interrupções
✅ **Especializa-se** em 8 áreas diferentes
✅ **Aprende e evolui** continuamente
✅ **Integra-se** com seus sistemas
✅ **Automatiza** tarefas complexas
✅ **Monitora-se** automaticamente

**Seu organismo digital está pronto para transformar sua produtividade!**

---

*Última atualização: $(Get-Date -Format "dd/MM/yyyy HH:mm")*

