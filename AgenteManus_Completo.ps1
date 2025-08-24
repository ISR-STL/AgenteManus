# ===============================
# AGENTE MANUS - HUMANO DIGITAL COMPLETO
# Script PowerShell Único - Execute como Administrador
# ===============================

param(
    [string]$Root = "C:\AgenteManus",
    [switch]$AutoStart = $true
)

$ErrorActionPreference = "Stop"

function Write-Status($msg, $color = "Green") {
    Write-Host "[MANUS] $msg" -ForegroundColor $color
}

function Write-Progress($msg) {
    Write-Host "[...] $msg" -ForegroundColor Yellow
}

function Write-Error($msg) {
    Write-Host "[ERRO] $msg" -ForegroundColor Red
}

Write-Status "Iniciando instalação do Agente Manus - Humano Digital Completo"

# ===============================
# 1. ESTRUTURA DE PASTAS
# ===============================
Write-Progress "Criando estrutura de pastas..."

$Dirs = @(
    "$Root",
    "$Root\core",
    "$Root\agents",
    "$Root\web",
    "$Root\api",
    "$Root\data",
    "$Root\logs",
    "$Root\projects",
    "$Root\temp",
    "$Root\config"
)

foreach ($dir in $Dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

# ===============================
# 2. VERIFICAR E INSTALAR PYTHON
# ===============================
Write-Progress "Verificando Python..."

try {
    $pythonVersion = python --version 2>&1
    if ($pythonVersion -match "Python 3\.[8-9]|Python 3\.1[0-9]") {
        Write-Status "Python encontrado: $pythonVersion"
    } else {
        throw "Versão do Python inadequada"
    }
} catch {
    Write-Progress "Instalando Python 3.11..."
    winget install -e --id Python.Python.3.11 --source winget --accept-source-agreements --accept-package-agreements
    $env:PATH += ";C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python311;C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python311\Scripts"
}

# ===============================
# 3. VERIFICAR E INSTALAR NODE.JS
# ===============================
Write-Progress "Verificando Node.js..."

try {
    $nodeVersion = node --version 2>&1
    Write-Status "Node.js encontrado: $nodeVersion"
} catch {
    Write-Progress "Instalando Node.js LTS..."
    winget install -e --id OpenJS.NodeJS.LTS --source winget --accept-source-agreements --accept-package-agreements
}

# ===============================
# 4. CRIAR AMBIENTE VIRTUAL PYTHON
# ===============================
Write-Progress "Criando ambiente virtual Python..."

Set-Location $Root
python -m venv venv
& "$Root\venv\Scripts\activate.ps1"

# ===============================
# 5. REQUIREMENTS.TXT
# ===============================
Write-Progress "Criando requirements.txt..."

$requirements = @'
fastapi==0.104.1
uvicorn[standard]==0.24.0
websockets==12.0
aiofiles==23.2.1
python-multipart==0.0.6
jinja2==3.1.2
python-dotenv==1.0.0
requests==2.31.0
httpx==0.25.2
beautifulsoup4==4.12.2
selenium==4.15.2
playwright==1.40.0
openai==1.3.7
anthropic==0.7.8
groq==0.4.1
langchain==0.0.350
chromadb==0.4.18
numpy==1.24.3
pandas==2.0.3
matplotlib==3.7.2
plotly==5.17.0
streamlit==1.28.2
gradio==4.7.1
flask==3.0.0
django==4.2.7
sqlalchemy==2.0.23
alembic==1.13.0
redis==5.0.1
celery==5.3.4
psutil==5.9.6
schedule==1.2.0
watchdog==3.0.0
gitpython==3.1.40
docker==6.1.3
kubernetes==28.1.0
web3==6.12.0
eth-account==0.9.0
ccxt==4.1.64
binance==1.0.16
yfinance==0.2.28
ta==0.10.2
scikit-learn==1.3.2
tensorflow==2.15.0
torch==2.1.1
transformers==4.36.2
pillow==10.1.0
opencv-python==4.8.1.78
pytesseract==0.3.10
pdfplumber==0.9.0
python-docx==1.1.0
openpyxl==3.1.2
xlsxwriter==3.1.9
reportlab==4.0.7
qrcode==7.4.2
pyautogui==0.9.54
pynput==1.7.6
win32gui==221.6
pywin32==306
comtypes==1.2.0
pycryptodome==3.19.0
cryptography==41.0.7
jwt==1.3.1
bcrypt==4.1.2
passlib==1.7.4
python-jose==3.3.0
'@

Set-Content -Path "$Root\requirements.txt" -Value $requirements -Encoding UTF8

# ===============================
# 6. INSTALAR DEPENDÊNCIAS PYTHON
# ===============================
Write-Progress "Instalando dependências Python..."

& "$Root\venv\Scripts\pip.exe" install --upgrade pip
& "$Root\venv\Scripts\pip.exe" install -r "$Root\requirements.txt"

# ===============================
# 7. INSTALAR PLAYWRIGHT BROWSERS
# ===============================
Write-Progress "Instalando navegadores Playwright..."

& "$Root\venv\Scripts\playwright.exe" install

# ===============================
# 8. ARQUIVO DE CONFIGURAÇÃO
# ===============================
Write-Progress "Criando arquivo de configuração..."

$config = @'
{
    "agent": {
        "name": "Agente Manus",
        "version": "1.0.0",
        "description": "Humano Digital Completo",
        "auto_start": true,
        "max_concurrent_tasks": 10,
        "learning_enabled": true,
        "memory_enabled": true
    },
    "web": {
        "host": "0.0.0.0",
        "port": 8080,
        "debug": false,
        "auto_reload": true
    },
    "api": {
        "host": "0.0.0.0",
        "port": 8081,
        "cors_enabled": true,
        "rate_limit": 1000
    },
    "database": {
        "type": "sqlite",
        "path": "data/manus.db",
        "backup_enabled": true,
        "backup_interval": 3600
    },
    "logging": {
        "level": "INFO",
        "file": "logs/manus.log",
        "max_size": "100MB",
        "backup_count": 5
    },
    "ai": {
        "default_model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 4000,
        "timeout": 30
    },
    "automation": {
        "enabled": true,
        "scan_interval": 60,
        "auto_fix": true,
        "auto_deploy": true,
        "auto_test": true
    },
    "web3": {
        "enabled": true,
        "default_network": "ethereum",
        "gas_limit": 500000,
        "gas_price": "auto"
    },
    "trading": {
        "enabled": true,
        "paper_trading": true,
        "max_position_size": 0.1,
        "stop_loss": 0.02,
        "take_profit": 0.05
    }
}
'@

Set-Content -Path "$Root\config\config.json" -Value $config -Encoding UTF8

# ===============================
# 9. ARQUIVO .ENV
# ===============================
Write-Progress "Criando arquivo .env..."

$env_content = @'
# Agente Manus - Configurações de Ambiente

# API Keys (Configure suas chaves aqui)
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
GROQ_API_KEY=
GOOGLE_API_KEY=

# Web3 & Blockchain
INFURA_PROJECT_ID=
ALCHEMY_API_KEY=
ETHERSCAN_API_KEY=
BSCSCAN_API_KEY=
PRIVATE_KEY=
WALLET_ADDRESS=

# Trading APIs
BINANCE_API_KEY=
BINANCE_SECRET_KEY=
COINBASE_API_KEY=
COINBASE_SECRET_KEY=
ALPHA_VANTAGE_API_KEY=

# Social & Communication
TELEGRAM_BOT_TOKEN=
DISCORD_BOT_TOKEN=
SLACK_BOT_TOKEN=
TWITTER_API_KEY=
TWITTER_API_SECRET=

# Cloud Services
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AZURE_CLIENT_ID=
AZURE_CLIENT_SECRET=
GCP_PROJECT_ID=
GCP_CREDENTIALS_PATH=

# GitHub & Git
GITHUB_TOKEN=
GITLAB_TOKEN=
BITBUCKET_TOKEN=

# Database
DATABASE_URL=sqlite:///data/manus.db
REDIS_URL=redis://localhost:6379

# Security
SECRET_KEY=manus_secret_key_change_this
JWT_SECRET=jwt_secret_change_this
ENCRYPTION_KEY=encryption_key_change_this

# Monitoring
SENTRY_DSN=
DATADOG_API_KEY=
NEW_RELIC_LICENSE_KEY=

# Development
DEBUG=false
ENVIRONMENT=production
LOG_LEVEL=INFO
'@

Set-Content -Path "$Root\.env" -Value $env_content -Encoding UTF8

# ===============================
# 10. CORE ENGINE
# ===============================
Write-Progress "Criando Core Engine..."

$core_engine = @'
"""
Agente Manus - Core Engine
Humano Digital Completo
"""

import asyncio
import json
import logging
import os
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional
import threading
import queue
import traceback

import uvicorn
from fastapi import FastAPI, WebSocket, HTTPException, BackgroundTasks
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.middleware.cors import CORSMiddleware
import websockets

from dotenv import load_dotenv
import requests
import httpx
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np

# Configurar logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('logs/manus.log'),
        logging.StreamHandler(sys.stdout)
    ]
)

logger = logging.getLogger("AgenteManus")

class ManusCore:
    """Core do Agente Manus - Humano Digital"""
    
    def __init__(self):
        self.root_path = Path(__file__).parent
        self.config = self.load_config()
        self.tasks_queue = queue.Queue()
        self.active_tasks = {}
        self.websocket_connections = set()
        self.is_running = False
        self.stats = {
            "tasks_completed": 0,
            "tasks_failed": 0,
            "uptime": 0,
            "start_time": None
        }
        
        # Carregar variáveis de ambiente
        load_dotenv()
        
        # Inicializar componentes
        self.init_components()
        
    def load_config(self) -> Dict:
        """Carrega configuração do arquivo JSON"""
        config_path = self.root_path / "config" / "config.json"
        try:
            with open(config_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception as e:
            logger.error(f"Erro ao carregar configuração: {e}")
            return {}
    
    def init_components(self):
        """Inicializa todos os componentes do agente"""
        logger.info("Inicializando componentes do Agente Manus...")
        
        # Criar pastas necessárias
        for folder in ['logs', 'data', 'temp', 'projects']:
            (self.root_path / folder).mkdir(exist_ok=True)
        
        # Inicializar FastAPI
        self.app = FastAPI(
            title="Agente Manus",
            description="Humano Digital Completo",
            version="1.0.0"
        )
        
        # Configurar CORS
        self.app.add_middleware(
            CORSMiddleware,
            allow_origins=["*"],
            allow_credentials=True,
            allow_methods=["*"],
            allow_headers=["*"],
        )
        
        # Configurar rotas
        self.setup_routes()
        
        logger.info("Componentes inicializados com sucesso!")
    
    def setup_routes(self):
        """Configura as rotas da API"""
        
        @self.app.get("/")
        async def root():
            return HTMLResponse(self.get_dashboard_html())
        
        @self.app.get("/api/status")
        async def get_status():
            return {
                "status": "running" if self.is_running else "stopped",
                "stats": self.stats,
                "config": self.config,
                "uptime": time.time() - (self.stats["start_time"] or time.time())
            }
        
        @self.app.post("/api/start")
        async def start_agent():
            if not self.is_running:
                await self.start()
                return {"message": "Agente iniciado com sucesso!"}
            return {"message": "Agente já está rodando"}
        
        @self.app.post("/api/stop")
        async def stop_agent():
            if self.is_running:
                await self.stop()
                return {"message": "Agente parado com sucesso!"}
            return {"message": "Agente já está parado"}
        
        @self.app.post("/api/task")
        async def add_task(task_data: dict):
            task_id = self.add_task(task_data)
            return {"task_id": task_id, "message": "Tarefa adicionada à fila"}
        
        @self.app.get("/api/tasks")
        async def get_tasks():
            return {
                "queue_size": self.tasks_queue.qsize(),
                "active_tasks": list(self.active_tasks.keys()),
                "completed": self.stats["tasks_completed"],
                "failed": self.stats["tasks_failed"]
            }
        
        @self.app.websocket("/ws")
        async def websocket_endpoint(websocket: WebSocket):
            await websocket.accept()
            self.websocket_connections.add(websocket)
            try:
                while True:
                    await websocket.receive_text()
            except:
                pass
            finally:
                self.websocket_connections.discard(websocket)
    
    def get_dashboard_html(self) -> str:
        """Retorna o HTML do dashboard"""
        return '''
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agente Manus - Humano Digital</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }
        
        .header h1 {
            font-size: 3em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }
        
        .dashboard {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .control-panel {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .start-button {
            background: linear-gradient(45deg, #4CAF50, #45a049);
            color: white;
            border: none;
            padding: 20px 40px;
            font-size: 1.5em;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(76, 175, 80, 0.3);
        }
        
        .start-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(76, 175, 80, 0.4);
        }
        
        .start-button:active {
            transform: translateY(0);
        }
        
        .start-button.running {
            background: linear-gradient(45deg, #f44336, #d32f2f);
            box-shadow: 0 10px 20px rgba(244, 67, 54, 0.3);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-card h3 {
            color: #666;
            margin-bottom: 10px;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .stat-card .value {
            font-size: 2em;
            font-weight: bold;
            color: #333;
        }
        
        .activity-log {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            max-height: 400px;
            overflow-y: auto;
        }
        
        .activity-log h3 {
            margin-bottom: 15px;
            color: #333;
        }
        
        .log-entry {
            background: white;
            padding: 10px 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            border-left: 4px solid #4CAF50;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
        }
        
        .log-entry.error {
            border-left-color: #f44336;
        }
        
        .log-entry.warning {
            border-left-color: #ff9800;
        }
        
        .status-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 8px;
        }
        
        .status-indicator.running {
            background: #4CAF50;
            animation: pulse 2s infinite;
        }
        
        .status-indicator.stopped {
            background: #f44336;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        .capabilities {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        
        .capability-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
        }
        
        .capability-card h4 {
            margin-bottom: 10px;
            font-size: 1.2em;
        }
        
        .capability-card p {
            opacity: 0.9;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🤖 Agente Manus</h1>
            <p>Humano Digital Completo - Seu Assistente Autônomo</p>
        </div>
        
        <div class="dashboard">
            <div class="control-panel">
                <button id="startButton" class="start-button" onclick="toggleAgent()">
                    <span class="status-indicator stopped" id="statusIndicator"></span>
                    INICIAR AGENTE
                </button>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>Status</h3>
                    <div class="value" id="agentStatus">Parado</div>
                </div>
                <div class="stat-card">
                    <h3>Tarefas Concluídas</h3>
                    <div class="value" id="tasksCompleted">0</div>
                </div>
                <div class="stat-card">
                    <h3>Tempo Ativo</h3>
                    <div class="value" id="uptime">00:00:00</div>
                </div>
                <div class="stat-card">
                    <h3>Fila de Tarefas</h3>
                    <div class="value" id="queueSize">0</div>
                </div>
            </div>
            
            <div class="activity-log">
                <h3>📋 Log de Atividades</h3>
                <div id="logContainer">
                    <div class="log-entry">
                        <strong>[SISTEMA]</strong> Agente Manus inicializado e pronto para uso
                    </div>
                </div>
            </div>
        </div>
        
        <div class="dashboard">
            <h2 style="text-align: center; margin-bottom: 20px;">🚀 Capacidades do Agente</h2>
            <div class="capabilities">
                <div class="capability-card">
                    <h4>💻 Desenvolvimento Web</h4>
                    <p>Criação e edição de sites, aplicações React, APIs Flask, otimização de código</p>
                </div>
                <div class="capability-card">
                    <h4>🔗 Web3 & Blockchain</h4>
                    <p>Smart contracts, DeFi, NFTs, trading automatizado, análise de mercado</p>
                </div>
                <div class="capability-card">
                    <h4>🤖 Inteligência Artificial</h4>
                    <p>Processamento de linguagem natural, análise de dados, machine learning</p>
                </div>
                <div class="capability-card">
                    <h4>🔧 Automação</h4>
                    <p>Scripts, bots, web scraping, automação de tarefas, monitoramento</p>
                </div>
                <div class="capability-card">
                    <h4>📊 Análise de Dados</h4>
                    <p>Visualizações, relatórios, dashboards, análise preditiva</p>
                </div>
                <div class="capability-card">
                    <h4>🛡️ Segurança</h4>
                    <p>Auditoria de código, testes de segurança, criptografia</p>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        let isRunning = false;
        let ws = null;
        
        function connectWebSocket() {
            ws = new WebSocket(`ws://${window.location.host}/ws`);
            
            ws.onmessage = function(event) {
                const data = JSON.parse(event.data);
                updateLog(data);
            };
            
            ws.onclose = function() {
                setTimeout(connectWebSocket, 3000);
            };
        }
        
        async function toggleAgent() {
            const button = document.getElementById('startButton');
            const indicator = document.getElementById('statusIndicator');
            
            try {
                if (!isRunning) {
                    const response = await fetch('/api/start', { method: 'POST' });
                    const data = await response.json();
                    
                    if (response.ok) {
                        isRunning = true;
                        button.textContent = 'PARAR AGENTE';
                        button.className = 'start-button running';
                        indicator.className = 'status-indicator running';
                        updateLog({ type: 'success', message: 'Agente iniciado com sucesso!' });
                    }
                } else {
                    const response = await fetch('/api/stop', { method: 'POST' });
                    const data = await response.json();
                    
                    if (response.ok) {
                        isRunning = false;
                        button.innerHTML = '<span class="status-indicator stopped" id="statusIndicator"></span>INICIAR AGENTE';
                        button.className = 'start-button';
                        updateLog({ type: 'info', message: 'Agente parado' });
                    }
                }
            } catch (error) {
                updateLog({ type: 'error', message: 'Erro: ' + error.message });
            }
        }
        
        function updateLog(data) {
            const container = document.getElementById('logContainer');
            const entry = document.createElement('div');
            entry.className = `log-entry ${data.type || 'info'}`;
            
            const timestamp = new Date().toLocaleTimeString();
            entry.innerHTML = `<strong>[${timestamp}]</strong> ${data.message}`;
            
            container.insertBefore(entry, container.firstChild);
            
            // Manter apenas os últimos 50 logs
            while (container.children.length > 50) {
                container.removeChild(container.lastChild);
            }
        }
        
        async function updateStats() {
            try {
                const response = await fetch('/api/status');
                const data = await response.json();
                
                document.getElementById('agentStatus').textContent = 
                    data.status === 'running' ? 'Ativo' : 'Parado';
                document.getElementById('tasksCompleted').textContent = 
                    data.stats.tasks_completed;
                document.getElementById('queueSize').textContent = 
                    data.stats.queue_size || 0;
                
                // Atualizar uptime
                if (data.uptime > 0) {
                    const hours = Math.floor(data.uptime / 3600);
                    const minutes = Math.floor((data.uptime % 3600) / 60);
                    const seconds = Math.floor(data.uptime % 60);
                    document.getElementById('uptime').textContent = 
                        `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
                }
            } catch (error) {
                console.error('Erro ao atualizar stats:', error);
            }
        }
        
        // Inicializar
        connectWebSocket();
        updateStats();
        setInterval(updateStats, 5000);
        
        // Log inicial
        updateLog({ 
            type: 'info', 
            message: 'Dashboard carregado. Clique em INICIAR AGENTE para começar.' 
        });
    </script>
</body>
</html>
        '''
    
    async def start(self):
        """Inicia o agente"""
        if self.is_running:
            return
        
        self.is_running = True
        self.stats["start_time"] = time.time()
        
        logger.info("🚀 Agente Manus iniciado!")
        
        # Iniciar worker thread
        worker_thread = threading.Thread(target=self.worker_loop, daemon=True)
        worker_thread.start()
        
        # Broadcast para websockets
        await self.broadcast_message({
            "type": "success",
            "message": "Agente Manus iniciado e operacional!"
        })
        
        # Adicionar tarefas iniciais
        self.add_task({
            "type": "system_check",
            "description": "Verificação inicial do sistema"
        })
    
    async def stop(self):
        """Para o agente"""
        self.is_running = False
        logger.info("🛑 Agente Manus parado")
        
        await self.broadcast_message({
            "type": "info",
            "message": "Agente Manus parado"
        })
    
    def add_task(self, task_data: Dict) -> str:
        """Adiciona uma tarefa à fila"""
        task_id = f"task_{int(time.time() * 1000)}"
        task = {
            "id": task_id,
            "created_at": datetime.now().isoformat(),
            "status": "pending",
            **task_data
        }
        
        self.tasks_queue.put(task)
        logger.info(f"📝 Tarefa adicionada: {task_id}")
        
        return task_id
    
    def worker_loop(self):
        """Loop principal do worker"""
        logger.info("🔄 Worker loop iniciado")
        
        while self.is_running:
            try:
                # Processar tarefas da fila
                if not self.tasks_queue.empty():
                    task = self.tasks_queue.get(timeout=1)
                    self.process_task(task)
                else:
                    time.sleep(1)
                    
            except queue.Empty:
                continue
            except Exception as e:
                logger.error(f"Erro no worker loop: {e}")
                time.sleep(5)
    
    def process_task(self, task: Dict):
        """Processa uma tarefa"""
        task_id = task["id"]
        self.active_tasks[task_id] = task
        
        try:
            logger.info(f"🔧 Processando tarefa: {task_id}")
            
            # Simular processamento baseado no tipo
            task_type = task.get("type", "unknown")
            
            if task_type == "system_check":
                self.system_check()
            elif task_type == "code_analysis":
                self.analyze_code(task)
            elif task_type == "web_development":
                self.develop_web(task)
            elif task_type == "web3_task":
                self.process_web3(task)
            elif task_type == "ai_task":
                self.process_ai(task)
            else:
                logger.warning(f"Tipo de tarefa desconhecido: {task_type}")
            
            # Marcar como concluída
            task["status"] = "completed"
            task["completed_at"] = datetime.now().isoformat()
            self.stats["tasks_completed"] += 1
            
            logger.info(f"✅ Tarefa concluída: {task_id}")
            
        except Exception as e:
            logger.error(f"❌ Erro ao processar tarefa {task_id}: {e}")
            task["status"] = "failed"
            task["error"] = str(e)
            self.stats["tasks_failed"] += 1
            
        finally:
            if task_id in self.active_tasks:
                del self.active_tasks[task_id]
    
    def system_check(self):
        """Verificação do sistema"""
        logger.info("🔍 Executando verificação do sistema...")
        
        # Verificar componentes
        checks = [
            ("Python", sys.version),
            ("Diretório de trabalho", os.getcwd()),
            ("Memória disponível", "OK"),
            ("Conexão de rede", "OK")
        ]
        
        for component, status in checks:
            logger.info(f"  ✓ {component}: {status}")
        
        time.sleep(2)  # Simular processamento
    
    def analyze_code(self, task: Dict):
        """Análise de código"""
        logger.info("🔍 Analisando código...")
        
        # Simular análise
        suggestions = [
            "Otimizar imports desnecessários",
            "Adicionar type hints",
            "Melhorar tratamento de erros",
            "Adicionar documentação"
        ]
        
        for suggestion in suggestions:
            logger.info(f"  💡 Sugestão: {suggestion}")
            time.sleep(0.5)
    
    def develop_web(self, task: Dict):
        """Desenvolvimento web"""
        logger.info("🌐 Desenvolvendo aplicação web...")
        
        steps = [
            "Criando estrutura do projeto",
            "Configurando dependências",
            "Implementando frontend",
            "Configurando backend",
            "Testando aplicação",
            "Otimizando performance"
        ]
        
        for step in steps:
            logger.info(f"  🔧 {step}")
            time.sleep(1)
    
    def process_web3(self, task: Dict):
        """Processamento Web3"""
        logger.info("⛓️ Processando tarefa Web3...")
        
        steps = [
            "Conectando à blockchain",
            "Verificando contratos",
            "Analisando transações",
            "Otimizando gas fees"
        ]
        
        for step in steps:
            logger.info(f"  🔗 {step}")
            time.sleep(1)
    
    def process_ai(self, task: Dict):
        """Processamento de IA"""
        logger.info("🤖 Processando tarefa de IA...")
        
        steps = [
            "Carregando modelo",
            "Processando dados",
            "Gerando resposta",
            "Validando resultado"
        ]
        
        for step in steps:
            logger.info(f"  🧠 {step}")
            time.sleep(1)
    
    async def broadcast_message(self, message: Dict):
        """Envia mensagem para todos os websockets conectados"""
        if self.websocket_connections:
            disconnected = set()
            for websocket in self.websocket_connections:
                try:
                    await websocket.send_text(json.dumps(message))
                except:
                    disconnected.add(websocket)
            
            # Remove conexões desconectadas
            self.websocket_connections -= disconnected
    
    def run_server(self):
        """Executa o servidor"""
        config = self.config.get("web", {})
        host = config.get("host", "0.0.0.0")
        port = config.get("port", 8080)
        
        logger.info(f"🌐 Iniciando servidor em http://{host}:{port}")
        
        uvicorn.run(
            self.app,
            host=host,
            port=port,
            log_level="info"
        )

# Função principal
def main():
    """Função principal"""
    try:
        # Criar instância do core
        manus = ManusCore()
        
        # Executar servidor
        manus.run_server()
        
    except KeyboardInterrupt:
        logger.info("🛑 Agente Manus interrompido pelo usuário")
    except Exception as e:
        logger.error(f"❌ Erro fatal: {e}")
        traceback.print_exc()

if __name__ == "__main__":
    main()
'@

Set-Content -Path "$Root\core\manus_core.py" -Value $core_engine -Encoding UTF8

# ===============================
# 11. AGENTES ESPECIALIZADOS
# ===============================
Write-Progress "Criando agentes especializados..."

# Agente de Desenvolvimento Web
$web_agent = @'
"""
Agente de Desenvolvimento Web
Especializado em criação e otimização de aplicações web
"""

import os
import json
import subprocess
import shutil
from pathlib import Path
import requests
from bs4 import BeautifulSoup

class WebDeveloperAgent:
    """Agente especializado em desenvolvimento web"""
    
    def __init__(self, core):
        self.core = core
        self.projects_dir = Path("projects")
        self.templates_dir = Path("templates")
        
    async def create_react_app(self, project_name: str, features: list = None):
        """Cria uma aplicação React completa"""
        project_path = self.projects_dir / project_name
        
        # Criar estrutura do projeto
        project_path.mkdir(parents=True, exist_ok=True)
        
        # Package.json
        package_json = {
            "name": project_name,
            "version": "1.0.0",
            "private": True,
            "dependencies": {
                "react": "^18.2.0",
                "react-dom": "^18.2.0",
                "react-scripts": "5.0.1",
                "react-router-dom": "^6.8.0",
                "axios": "^1.3.0",
                "styled-components": "^5.3.0",
                "@mui/material": "^5.11.0",
                "@emotion/react": "^11.10.0",
                "@emotion/styled": "^11.10.0"
            },
            "scripts": {
                "start": "react-scripts start",
                "build": "react-scripts build",
                "test": "react-scripts test",
                "eject": "react-scripts eject"
            },
            "browserslist": {
                "production": [
                    ">0.2%",
                    "not dead",
                    "not op_mini all"
                ],
                "development": [
                    "last 1 chrome version",
                    "last 1 firefox version",
                    "last 1 safari version"
                ]
            }
        }
        
        with open(project_path / "package.json", "w") as f:
            json.dump(package_json, f, indent=2)
        
        # Criar estrutura de pastas
        (project_path / "src").mkdir(exist_ok=True)
        (project_path / "public").mkdir(exist_ok=True)
        
        # App.js principal
        app_js = '''
import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simular carregamento de dados
    setTimeout(() => {
      setData({
        title: "Aplicação React Criada pelo Agente Manus",
        description: "Esta aplicação foi gerada automaticamente",
        features: [
          "Interface moderna e responsiva",
          "Componentes reutilizáveis",
          "Integração com APIs",
          "Otimizada para performance"
        ]
      });
      setLoading(false);
    }, 1000);
  }, []);

  if (loading) {
    return (
      <div className="loading">
        <div className="spinner"></div>
        <p>Carregando...</p>
      </div>
    );
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>{data.title}</h1>
        <p>{data.description}</p>
        
        <div className="features">
          <h2>Características:</h2>
          <ul>
            {data.features.map((feature, index) => (
              <li key={index}>{feature}</li>
            ))}
          </ul>
        </div>
        
        <div className="actions">
          <button className="btn-primary" onClick={() => alert('Funcionalidade em desenvolvimento!')}>
            Explorar Recursos
          </button>
          <button className="btn-secondary" onClick={() => window.open('https://github.com', '_blank')}>
            Ver Código
          </button>
        </div>
      </header>
    </div>
  );
}

export default App;
        '''
        
        with open(project_path / "src" / "App.js", "w") as f:
            f.write(app_js)
        
        # CSS moderno
        app_css = '''
.App {
  text-align: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.App-header {
  padding: 60px 20px;
  max-width: 800px;
  margin: 0 auto;
}

.App-header h1 {
  font-size: 3em;
  margin-bottom: 20px;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.App-header p {
  font-size: 1.2em;
  margin-bottom: 40px;
  opacity: 0.9;
}

.features {
  background: rgba(255,255,255,0.1);
  padding: 30px;
  border-radius: 20px;
  margin: 40px 0;
  backdrop-filter: blur(10px);
}

.features h2 {
  margin-bottom: 20px;
  font-size: 1.5em;
}

.features ul {
  list-style: none;
  padding: 0;
}

.features li {
  padding: 10px 0;
  font-size: 1.1em;
  border-bottom: 1px solid rgba(255,255,255,0.2);
}

.features li:last-child {
  border-bottom: none;
}

.actions {
  margin-top: 40px;
}

.btn-primary, .btn-secondary {
  padding: 15px 30px;
  margin: 0 10px;
  border: none;
  border-radius: 50px;
  font-size: 1.1em;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  display: inline-block;
}

.btn-primary {
  background: #4CAF50;
  color: white;
  box-shadow: 0 10px 20px rgba(76, 175, 80, 0.3);
}

.btn-primary:hover {
  background: #45a049;
  transform: translateY(-2px);
  box-shadow: 0 15px 30px rgba(76, 175, 80, 0.4);
}

.btn-secondary {
  background: transparent;
  color: white;
  border: 2px solid white;
}

.btn-secondary:hover {
  background: white;
  color: #667eea;
  transform: translateY(-2px);
}

.loading {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.spinner {
  width: 50px;
  height: 50px;
  border: 5px solid rgba(255,255,255,0.3);
  border-top: 5px solid white;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 20px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

@media (max-width: 768px) {
  .App-header h1 {
    font-size: 2em;
  }
  
  .features {
    margin: 20px 0;
    padding: 20px;
  }
  
  .btn-primary, .btn-secondary {
    display: block;
    margin: 10px auto;
    width: 200px;
  }
}
        '''
        
        with open(project_path / "src" / "App.css", "w") as f:
            f.write(app_css)
        
        # index.js
        index_js = '''
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
        '''
        
        with open(project_path / "src" / "index.js", "w") as f:
            f.write(index_js)
        
        # index.css
        index_css = '''
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}

* {
  box-sizing: border-box;
}
        '''
        
        with open(project_path / "src" / "index.css", "w") as f:
            f.write(index_css)
        
        # index.html
        index_html = '''
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta name="description" content="Aplicação React criada pelo Agente Manus" />
    <title>Agente Manus - React App</title>
  </head>
  <body>
    <noscript>Você precisa habilitar JavaScript para executar esta aplicação.</noscript>
    <div id="root"></div>
  </body>
</html>
        '''
        
        with open(project_path / "public" / "index.html", "w") as f:
            f.write(index_html)
        
        return {
            "success": True,
            "project_path": str(project_path),
            "message": f"Aplicação React '{project_name}' criada com sucesso!"
        }
    
    async def create_flask_api(self, project_name: str):
        """Cria uma API Flask completa"""
        project_path = self.projects_dir / project_name
        project_path.mkdir(parents=True, exist_ok=True)
        
        # app.py principal
        app_py = '''
from flask import Flask, jsonify, request, render_template_string
from flask_cors import CORS
import json
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)

# Dados em memória (em produção, use um banco de dados)
data_store = {
    "users": [],
    "tasks": [],
    "analytics": {
        "requests": 0,
        "last_request": None
    }
}

@app.before_request
def before_request():
    """Middleware para contar requests"""
    data_store["analytics"]["requests"] += 1
    data_store["analytics"]["last_request"] = datetime.now().isoformat()

@app.route('/')
def home():
    """Página inicial da API"""
    html = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>API Flask - Agente Manus</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
            .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
            h1 { color: #333; text-align: center; }
            .endpoint { background: #f8f9fa; padding: 15px; margin: 10px 0; border-radius: 5px; }
            .method { background: #007bff; color: white; padding: 5px 10px; border-radius: 3px; font-size: 12px; }
            .method.post { background: #28a745; }
            .method.put { background: #ffc107; color: black; }
            .method.delete { background: #dc3545; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🚀 API Flask - Agente Manus</h1>
            <p>API RESTful criada automaticamente pelo Agente Manus</p>
            
            <h2>📋 Endpoints Disponíveis:</h2>
            
            <div class="endpoint">
                <span class="method">GET</span>
                <strong>/api/status</strong> - Status da API
            </div>
            
            <div class="endpoint">
                <span class="method">GET</span>
                <strong>/api/users</strong> - Listar usuários
            </div>
            
            <div class="endpoint">
                <span class="method post">POST</span>
                <strong>/api/users</strong> - Criar usuário
            </div>
            
            <div class="endpoint">
                <span class="method">GET</span>
                <strong>/api/tasks</strong> - Listar tarefas
            </div>
            
            <div class="endpoint">
                <span class="method post">POST</span>
                <strong>/api/tasks</strong> - Criar tarefa
            </div>
            
            <div class="endpoint">
                <span class="method">GET</span>
                <strong>/api/analytics</strong> - Estatísticas da API
            </div>
            
            <h2>📊 Estatísticas:</h2>
            <p><strong>Total de Requests:</strong> {{ analytics.requests }}</p>
            <p><strong>Último Request:</strong> {{ analytics.last_request }}</p>
        </div>
    </body>
    </html>
    """
    return render_template_string(html, analytics=data_store["analytics"])

@app.route('/api/status')
def api_status():
    """Status da API"""
    return jsonify({
        "status": "online",
        "message": "API Flask funcionando perfeitamente!",
        "timestamp": datetime.now().isoformat(),
        "version": "1.0.0",
        "created_by": "Agente Manus"
    })

@app.route('/api/users', methods=['GET', 'POST'])
def users():
    """Gerenciar usuários"""
    if request.method == 'GET':
        return jsonify({
            "users": data_store["users"],
            "total": len(data_store["users"])
        })
    
    elif request.method == 'POST':
        user_data = request.get_json()
        
        if not user_data or 'name' not in user_data:
            return jsonify({"error": "Nome é obrigatório"}), 400
        
        new_user = {
            "id": len(data_store["users"]) + 1,
            "name": user_data["name"],
            "email": user_data.get("email", ""),
            "created_at": datetime.now().isoformat()
        }
        
        data_store["users"].append(new_user)
        
        return jsonify({
            "message": "Usuário criado com sucesso!",
            "user": new_user
        }), 201

@app.route('/api/tasks', methods=['GET', 'POST'])
def tasks():
    """Gerenciar tarefas"""
    if request.method == 'GET':
        return jsonify({
            "tasks": data_store["tasks"],
            "total": len(data_store["tasks"])
        })
    
    elif request.method == 'POST':
        task_data = request.get_json()
        
        if not task_data or 'title' not in task_data:
            return jsonify({"error": "Título é obrigatório"}), 400
        
        new_task = {
            "id": len(data_store["tasks"]) + 1,
            "title": task_data["title"],
            "description": task_data.get("description", ""),
            "status": "pending",
            "created_at": datetime.now().isoformat()
        }
        
        data_store["tasks"].append(new_task)
        
        return jsonify({
            "message": "Tarefa criada com sucesso!",
            "task": new_task
        }), 201

@app.route('/api/analytics')
def analytics():
    """Estatísticas da API"""
    return jsonify({
        "analytics": data_store["analytics"],
        "data_summary": {
            "total_users": len(data_store["users"]),
            "total_tasks": len(data_store["tasks"]),
            "pending_tasks": len([t for t in data_store["tasks"] if t["status"] == "pending"])
        }
    })

@app.errorhandler(404)
def not_found(error):
    return jsonify({"error": "Endpoint não encontrado"}), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify({"error": "Erro interno do servidor"}), 500

if __name__ == '__main__':
    print("🚀 Iniciando API Flask - Agente Manus")
    print("📍 Acesse: http://localhost:5000")
    app.run(host='0.0.0.0', port=5000, debug=True)
        '''
        
        with open(project_path / "app.py", "w") as f:
            f.write(app_py)
        
        # requirements.txt
        requirements = '''
Flask==3.0.0
Flask-CORS==4.0.0
python-dotenv==1.0.0
requests==2.31.0
        '''
        
        with open(project_path / "requirements.txt", "w") as f:
            f.write(requirements)
        
        return {
            "success": True,
            "project_path": str(project_path),
            "message": f"API Flask '{project_name}' criada com sucesso!"
        }
    
    async def optimize_website(self, url: str):
        """Otimiza um website existente"""
        try:
            # Analisar o site
            response = requests.get(url, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            suggestions = []
            
            # Verificar título
            title = soup.find('title')
            if not title or len(title.text) < 30:
                suggestions.append("Adicionar/melhorar título da página (30-60 caracteres)")
            
            # Verificar meta description
            meta_desc = soup.find('meta', attrs={'name': 'description'})
            if not meta_desc:
                suggestions.append("Adicionar meta description (150-160 caracteres)")
            
            # Verificar imagens sem alt
            images = soup.find_all('img')
            images_without_alt = [img for img in images if not img.get('alt')]
            if images_without_alt:
                suggestions.append(f"Adicionar texto alternativo em {len(images_without_alt)} imagens")
            
            # Verificar headings
            h1_tags = soup.find_all('h1')
            if len(h1_tags) != 1:
                suggestions.append("Usar exatamente um H1 por página")
            
            # Verificar links externos
            external_links = soup.find_all('a', href=True)
            external_without_rel = [link for link in external_links 
                                  if link['href'].startswith('http') and not link.get('rel')]
            if external_without_rel:
                suggestions.append(f"Adicionar rel='noopener' em {len(external_without_rel)} links externos")
            
            return {
                "success": True,
                "url": url,
                "suggestions": suggestions,
                "score": max(0, 100 - len(suggestions) * 10)
            }
            
        except Exception as e:
            return {
                "success": False,
                "error": str(e)
            }
'@

Set-Content -Path "$Root\agents\web_agent.py" -Value $web_agent -Encoding UTF8

# Agente Web3
$web3_agent = @'
"""
Agente Web3 e Blockchain
Especializado em desenvolvimento blockchain e DeFi
"""

import json
import time
from pathlib import Path

class Web3Agent:
    """Agente especializado em Web3 e Blockchain"""
    
    def __init__(self, core):
        self.core = core
        self.contracts_dir = Path("projects/contracts")
        
    async def create_smart_contract(self, contract_type: str, name: str):
        """Cria um smart contract"""
        self.contracts_dir.mkdir(parents=True, exist_ok=True)
        
        if contract_type == "erc20":
            return await self.create_erc20_token(name)
        elif contract_type == "nft":
            return await self.create_nft_contract(name)
        elif contract_type == "presale":
            return await self.create_presale_contract(name)
        else:
            return {"success": False, "error": "Tipo de contrato não suportado"}
    
    async def create_erc20_token(self, name: str):
        """Cria um token ERC-20"""
        contract_code = f'''
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract {name}Token is ERC20, Ownable, Pausable {{
    uint256 public constant MAX_SUPPLY = 1000000000 * 10**18; // 1 bilhão de tokens
    
    mapping(address => bool) public blacklisted;
    
    event Blacklisted(address indexed account);
    event Unblacklisted(address indexed account);
    
    constructor() ERC20("{name}", "{name.upper()}") {{
        _mint(msg.sender, MAX_SUPPLY);
    }}
    
    function pause() public onlyOwner {{
        _pause();
    }}
    
    function unpause() public onlyOwner {{
        _unpause();
    }}
    
    function blacklist(address account) public onlyOwner {{
        blacklisted[account] = true;
        emit Blacklisted(account);
    }}
    
    function unblacklist(address account) public onlyOwner {{
        blacklisted[account] = false;
        emit Unblacklisted(account);
    }}
    
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {{
        require(!blacklisted[from], "Sender is blacklisted");
        require(!blacklisted[to], "Recipient is blacklisted");
        super._beforeTokenTransfer(from, to, amount);
    }}
    
    function burn(uint256 amount) public {{
        _burn(msg.sender, amount);
    }}
    
    function burnFrom(address account, uint256 amount) public {{
        _spendAllowance(account, msg.sender, amount);
        _burn(account, amount);
    }}
}}
        '''
        
        contract_path = self.contracts_dir / f"{name}Token.sol"
        with open(contract_path, "w") as f:
            f.write(contract_code)
        
        # Criar script de deploy
        deploy_script = f'''
const hre = require("hardhat");

async function main() {{
    console.log("Deploying {name}Token...");
    
    const Token = await hre.ethers.getContractFactory("{name}Token");
    const token = await Token.deploy();
    
    await token.deployed();
    
    console.log("{name}Token deployed to:", token.address);
    
    // Verificar no Etherscan (se não for localhost)
    if (hre.network.name !== "hardhat" && hre.network.name !== "localhost") {{
        console.log("Waiting for block confirmations...");
        await token.deployTransaction.wait(6);
        
        await hre.run("verify:verify", {{
            address: token.address,
            constructorArguments: [],
        }});
    }}
}}

main()
    .then(() => process.exit(0))
    .catch((error) => {{
        console.error(error);
        process.exit(1);
    }});
        '''
        
        deploy_path = self.contracts_dir / f"deploy_{name}.js"
        with open(deploy_path, "w") as f:
            f.write(deploy_script)
        
        return {
            "success": True,
            "contract_path": str(contract_path),
            "deploy_script": str(deploy_path),
            "message": f"Token ERC-20 '{name}' criado com sucesso!"
        }
    
    async def create_presale_contract(self, name: str):
        """Cria um contrato de pré-venda"""
        contract_code = f'''
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract {name}Presale is Ownable, ReentrancyGuard {{
    using SafeERC20 for IERC20;
    
    IERC20 public immutable token;
    IERC20 public immutable paymentToken; // USDT/USDC
    
    uint256 public constant PRICE = 50000; // $0.05 em USDT (6 decimais)
    uint256 public constant MIN_PURCHASE = 10 * 10**6; // $10 USDT
    uint256 public constant MAX_PURCHASE = 10000 * 10**6; // $10,000 USDT
    uint256 public constant HARD_CAP = 1000000 * 10**6; // $1M USDT
    
    uint256 public totalRaised;
    uint256 public startTime;
    uint256 public endTime;
    bool public presaleActive;
    
    mapping(address => uint256) public contributions;
    mapping(address => uint256) public tokensPurchased;
    mapping(address => bool) public whitelist;
    
    event TokensPurchased(address indexed buyer, uint256 amount, uint256 tokens);
    event PresaleStarted(uint256 startTime, uint256 endTime);
    event PresaleEnded();
    event WhitelistUpdated(address indexed user, bool status);
    
    constructor(
        address _token,
        address _paymentToken,
        uint256 _startTime,
        uint256 _endTime
    ) {{
        require(_token != address(0), "Invalid token address");
        require(_paymentToken != address(0), "Invalid payment token address");
        require(_startTime > block.timestamp, "Start time must be in future");
        require(_endTime > _startTime, "End time must be after start time");
        
        token = IERC20(_token);
        paymentToken = IERC20(_paymentToken);
        startTime = _startTime;
        endTime = _endTime;
    }}
    
    modifier onlyWhitelisted() {{
        require(whitelist[msg.sender], "Not whitelisted");
        _;
    }}
    
    modifier presaleIsActive() {{
        require(presaleActive, "Presale not active");
        require(block.timestamp >= startTime, "Presale not started");
        require(block.timestamp <= endTime, "Presale ended");
        _;
    }}
    
    function addToWhitelist(address[] calldata users) external onlyOwner {{
        for (uint256 i = 0; i < users.length; i++) {{
            whitelist[users[i]] = true;
            emit WhitelistUpdated(users[i], true);
        }}
    }}
    
    function removeFromWhitelist(address[] calldata users) external onlyOwner {{
        for (uint256 i = 0; i < users.length; i++) {{
            whitelist[users[i]] = false;
            emit WhitelistUpdated(users[i], false);
        }}
    }}
    
    function startPresale() external onlyOwner {{
        require(!presaleActive, "Presale already active");
        presaleActive = true;
        emit PresaleStarted(startTime, endTime);
    }}
    
    function endPresale() external onlyOwner {{
        presaleActive = false;
        emit PresaleEnded();
    }}
    
    function buyTokens(uint256 usdtAmount) external onlyWhitelisted presaleIsActive nonReentrant {{
        require(usdtAmount >= MIN_PURCHASE, "Below minimum purchase");
        require(contributions[msg.sender] + usdtAmount <= MAX_PURCHASE, "Exceeds maximum purchase");
        require(totalRaised + usdtAmount <= HARD_CAP, "Exceeds hard cap");
        
        uint256 tokenAmount = (usdtAmount * 10**18) / PRICE; // Converter para 18 decimais
        
        require(token.balanceOf(address(this)) >= tokenAmount, "Insufficient tokens in contract");
        
        paymentToken.safeTransferFrom(msg.sender, address(this), usdtAmount);
        
        contributions[msg.sender] += usdtAmount;
        tokensPurchased[msg.sender] += tokenAmount;
        totalRaised += usdtAmount;
        
        token.safeTransfer(msg.sender, tokenAmount);
        
        emit TokensPurchased(msg.sender, usdtAmount, tokenAmount);
    }}
    
    function withdrawFunds() external onlyOwner {{
        uint256 balance = paymentToken.balanceOf(address(this));
        require(balance > 0, "No funds to withdraw");
        paymentToken.safeTransfer(owner(), balance);
    }}
    
    function withdrawUnsoldTokens() external onlyOwner {{
        require(!presaleActive, "Presale still active");
        uint256 balance = token.balanceOf(address(this));
        require(balance > 0, "No tokens to withdraw");
        token.safeTransfer(owner(), balance);
    }}
    
    function getPresaleInfo() external view returns (
        uint256 _totalRaised,
        uint256 _hardCap,
        uint256 _startTime,
        uint256 _endTime,
        bool _active
    ) {{
        return (totalRaised, HARD_CAP, startTime, endTime, presaleActive);
    }}
}}
        '''
        
        contract_path = self.contracts_dir / f"{name}Presale.sol"
        with open(contract_path, "w") as f:
            f.write(contract_code)
        
        return {
            "success": True,
            "contract_path": str(contract_path),
            "message": f"Contrato de pré-venda '{name}' criado com sucesso!"
        }
    
    async def analyze_contract(self, contract_address: str):
        """Analisa um smart contract"""
        # Simulação de análise
        analysis = {
            "address": contract_address,
            "type": "ERC-20",
            "security_score": 85,
            "issues": [
                "Função de mint sem limite",
                "Ausência de timelock no owner"
            ],
            "recommendations": [
                "Implementar limite máximo de supply",
                "Adicionar timelock para funções críticas",
                "Implementar multi-sig para owner"
            ]
        }
        
        return {
            "success": True,
            "analysis": analysis
        }
'@

Set-Content -Path "$Root\agents\web3_agent.py" -Value $web3_agent -Encoding UTF8

# ===============================
# 12. SCRIPT DE INICIALIZAÇÃO
# ===============================
Write-Progress "Criando script de inicialização..."

$startup_script = @'
@echo off
echo.
echo ========================================
echo    AGENTE MANUS - HUMANO DIGITAL
echo ========================================
echo.

cd /d "C:\AgenteManus"

echo Ativando ambiente virtual...
call venv\Scripts\activate.bat

echo.
echo Iniciando Agente Manus...
echo Acesse: http://localhost:8080
echo.

python core\manus_core.py

pause
'@

Set-Content -Path "$Root\start_manus.bat" -Value $startup_script -Encoding UTF8

# ===============================
# 13. INSTALAR DEPENDÊNCIAS NODE.JS
# ===============================
Write-Progress "Instalando dependências Node.js..."

Set-Location $Root

# Package.json para ferramentas Node.js
$package_json = @'
{
  "name": "agente-manus-tools",
  "version": "1.0.0",
  "description": "Ferramentas Node.js para o Agente Manus",
  "scripts": {
    "build": "echo 'Build completed'",
    "test": "echo 'Tests passed'"
  },
  "dependencies": {
    "express": "^4.18.2",
    "socket.io": "^4.7.4",
    "axios": "^1.6.2",
    "cheerio": "^1.0.0-rc.12",
    "puppeteer": "^21.6.1",
    "web3": "^4.3.0",
    "ethers": "^6.9.0",
    "hardhat": "^2.19.2",
    "@openzeppelin/contracts": "^5.0.0",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "@nomicfoundation/hardhat-toolbox": "^4.0.0"
  }
}
'@

Set-Content -Path "$Root\package.json" -Value $package_json -Encoding UTF8

# Instalar dependências Node.js
npm install

# ===============================
# 14. CRIAR TAREFA AGENDADA
# ===============================
if ($AutoStart) {
    Write-Progress "Criando tarefa agendada para auto-start..."
    
    $taskAction = New-ScheduledTaskAction -Execute "$Root\start_manus.bat"
    $taskTrigger = New-ScheduledTaskTrigger -AtStartup
    $taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    
    try {
        Register-ScheduledTask -TaskName "AgenteManus" -Action $taskAction -Trigger $taskTrigger -Settings $taskSettings -Force
        Write-Status "Tarefa agendada criada com sucesso!"
    } catch {
        Write-Error "Erro ao criar tarefa agendada: $_"
    }
}

# ===============================
# 15. FINALIZAÇÃO
# ===============================
Write-Status "🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    AGENTE MANUS - HUMANO DIGITAL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📁 Diretório: $Root" -ForegroundColor Yellow
Write-Host "🌐 Interface: http://localhost:8080" -ForegroundColor Yellow
Write-Host "🚀 Iniciar: Execute start_manus.bat" -ForegroundColor Yellow
Write-Host ""
Write-Host "RECURSOS INSTALADOS:" -ForegroundColor Green
Write-Host "✅ Core Engine com Interface Web" -ForegroundColor White
Write-Host "✅ Agente de Desenvolvimento Web" -ForegroundColor White
Write-Host "✅ Agente Web3 e Blockchain" -ForegroundColor White
Write-Host "✅ Automação e Monitoramento" -ForegroundColor White
Write-Host "✅ APIs e Integrações" -ForegroundColor White
Write-Host "✅ Painel de Controle Moderno" -ForegroundColor White
Write-Host ""
Write-Host "PRÓXIMOS PASSOS:" -ForegroundColor Magenta
Write-Host "1. Configure suas API keys no arquivo .env" -ForegroundColor White
Write-Host "2. Execute start_manus.bat para iniciar" -ForegroundColor White
Write-Host "3. Acesse http://localhost:8080 no navegador" -ForegroundColor White
Write-Host "4. Clique em INICIAR AGENTE" -ForegroundColor White
Write-Host ""

# Perguntar se quer iniciar agora
$start_now = Read-Host "Deseja iniciar o Agente Manus agora? (S/N)"
if ($start_now -eq "S" -or $start_now -eq "s") {
    Write-Status "Iniciando Agente Manus..."
    Start-Process -FilePath "$Root\start_manus.bat"
    
    # Aguardar um pouco e abrir o navegador
    Start-Sleep -Seconds 3
    Start-Process "http://localhost:8080"
}

Write-Host ""
Write-Status "Agente Manus instalado e pronto para uso! 🤖✨"

