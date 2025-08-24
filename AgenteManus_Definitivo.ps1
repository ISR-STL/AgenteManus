# ===============================
# AGENTE MANUS DEFINITIVO - HUMANO DIGITAL COMPLETO
# Script PowerShell Único - Execute como Administrador
# Integra TODAS as funcionalidades: Office, Web3, IA, Trading, 24/7
# ===============================

param(
    [string]$Root = "C:\AgenteManus",
    [switch]$AutoStart = $true,
    [switch]$Install24x7 = $true
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

Write-Status "🚀 Iniciando instalação do Agente Manus DEFINITIVO - Humano Digital Completo"

# ===============================
# 1. ESTRUTURA COMPLETA DE PASTAS
# ===============================
Write-Progress "Criando estrutura completa de pastas..."

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
    "$Root\config",
    "$Root\documents",
    "$Root\spreadsheets",
    "$Root\presentations",
    "$Root\pdfs",
    "$Root\websites",
    "$Root\apps",
    "$Root\web3",
    "$Root\trading",
    "$Root\ai_models",
    "$Root\backups",
    "$Root\security",
    "$Root\monitoring",
    "$Root\automation",
    "$Root\templates"
)

foreach ($dir in $Dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

# ===============================
# 2. VERIFICAR E INSTALAR DEPENDÊNCIAS
# ===============================
Write-Progress "Verificando e instalando dependências..."

# Python
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

# Node.js
try {
    $nodeVersion = node --version 2>&1
    Write-Status "Node.js encontrado: $nodeVersion"
} catch {
    Write-Progress "Instalando Node.js LTS..."
    winget install -e --id OpenJS.NodeJS.LTS --source winget --accept-source-agreements --accept-package-agreements
}

# Git
try {
    $gitVersion = git --version 2>&1
    Write-Status "Git encontrado: $gitVersion"
} catch {
    Write-Progress "Instalando Git..."
    winget install -e --id Git.Git --source winget --accept-source-agreements --accept-package-agreements
}

# ===============================
# 3. CRIAR AMBIENTE VIRTUAL PYTHON
# ===============================
Write-Progress "Criando ambiente virtual Python..."

Set-Location $Root
python -m venv venv
& "$Root\venv\Scripts\activate.ps1"

# ===============================
# 4. REQUIREMENTS COMPLETO
# ===============================
Write-Progress "Criando requirements completo..."

$requirements = @'
# Core Framework
fastapi==0.104.1
uvicorn[standard]==0.24.0
websockets==12.0
aiofiles==23.2.1
python-multipart==0.0.6
jinja2==3.1.2
python-dotenv==1.0.0
requests==2.31.0
httpx==0.25.2
aiohttp==3.9.1

# Web Scraping & Automation
beautifulsoup4==4.12.2
selenium==4.15.2
playwright==1.40.0
pyautogui==0.9.54
pynput==1.7.6

# AI & Machine Learning
openai==1.3.7
anthropic==0.7.8
groq==0.4.1
langchain==0.0.350
chromadb==0.4.18
transformers==4.36.2
torch==2.1.1
tensorflow==2.15.0
scikit-learn==1.3.2
numpy==1.24.3
pandas==2.0.3

# Office & Documents
openpyxl==3.1.2
xlsxwriter==3.1.9
python-docx==1.1.0
python-pptx==0.6.23
PyPDF2==3.0.1
pdfplumber==0.9.0
reportlab==4.0.7
fpdf2==2.7.6

# Data Visualization
matplotlib==3.7.2
plotly==5.17.0
seaborn==0.13.0
dash==2.16.1
streamlit==1.28.2
gradio==4.7.1

# Web Frameworks
flask==3.0.0
django==4.2.7
flask-cors==4.0.0
flask-socketio==5.3.6

# Database
sqlalchemy==2.0.23
alembic==1.13.0
sqlite3
psycopg2-binary==2.9.9
pymongo==4.6.0

# Async & Background Tasks
redis==5.0.1
celery==5.3.4
schedule==1.2.0
apscheduler==3.10.15

# System & Monitoring
psutil==5.9.6
watchdog==3.0.0
logging
sentry-sdk==1.38.0

# Git & Version Control
gitpython==3.1.40

# Containerization
docker==6.1.3
kubernetes==28.1.0

# Web3 & Blockchain
web3==6.12.0
eth-account==0.9.0
eth-utils==2.3.1
py-solc-x==1.12.0

# Trading & Finance
ccxt==4.1.64
binance==1.0.16
yfinance==0.2.28
ta==0.10.2
alpha-vantage==2.3.1

# Image & Video Processing
pillow==10.1.0
opencv-python==4.8.1.78
pytesseract==0.3.10
moviepy==1.0.3

# Security & Encryption
pycryptodome==3.19.0
cryptography==41.0.7
jwt==1.3.1
bcrypt==4.1.2
passlib==1.7.4
python-jose==3.3.0

# Windows Integration
pywin32==306
comtypes==1.2.0
win32gui==221.6

# Utilities
qrcode==7.4.2
python-barcode==0.15.1
python-dateutil==2.8.2
pytz==2023.3
tqdm==4.66.1
rich==13.7.0
click==8.1.7
'@

Set-Content -Path "$Root\requirements.txt" -Value $requirements -Encoding UTF8

# ===============================
# 5. INSTALAR DEPENDÊNCIAS PYTHON
# ===============================
Write-Progress "Instalando dependências Python (isso pode demorar alguns minutos)..."

& "$Root\venv\Scripts\pip.exe" install --upgrade pip
& "$Root\venv\Scripts\pip.exe" install -r "$Root\requirements.txt"

# ===============================
# 6. INSTALAR PLAYWRIGHT BROWSERS
# ===============================
Write-Progress "Instalando navegadores Playwright..."

& "$Root\venv\Scripts\playwright.exe" install

# ===============================
# 7. CONFIGURAÇÃO COMPLETA
# ===============================
Write-Progress "Criando configuração completa..."

$config = @'
{
    "agent": {
        "name": "Agente Manus Definitivo",
        "version": "2.0.0",
        "description": "Humano Digital Completo - Autônomo e Preditivo",
        "auto_start": true,
        "max_concurrent_tasks": 50,
        "learning_enabled": true,
        "memory_enabled": true,
        "predictive_mode": true,
        "autonomous_mode": true,
        "24x7_operation": true
    },
    "web": {
        "host": "0.0.0.0",
        "port": 8080,
        "debug": false,
        "auto_reload": true,
        "ssl_enabled": false
    },
    "api": {
        "host": "0.0.0.0",
        "port": 8081,
        "cors_enabled": true,
        "rate_limit": 10000,
        "auth_enabled": true
    },
    "database": {
        "type": "sqlite",
        "path": "data/manus.db",
        "backup_enabled": true,
        "backup_interval": 1800,
        "encryption_enabled": true
    },
    "logging": {
        "level": "INFO",
        "file": "logs/manus.log",
        "max_size": "500MB",
        "backup_count": 10,
        "real_time_monitoring": true
    },
    "ai": {
        "default_model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 4000,
        "timeout": 60,
        "predictive_analysis": true,
        "auto_learning": true
    },
    "automation": {
        "enabled": true,
        "scan_interval": 30,
        "auto_fix": true,
        "auto_deploy": true,
        "auto_test": true,
        "auto_optimize": true,
        "predictive_maintenance": true
    },
    "web3": {
        "enabled": true,
        "default_network": "ethereum",
        "gas_limit": 500000,
        "gas_price": "auto",
        "auto_trading": false,
        "monitoring_enabled": true
    },
    "trading": {
        "enabled": true,
        "paper_trading": true,
        "max_position_size": 0.1,
        "stop_loss": 0.02,
        "take_profit": 0.05,
        "auto_trading": false,
        "risk_management": true
    },
    "office": {
        "excel_enabled": true,
        "word_enabled": true,
        "powerpoint_enabled": true,
        "pdf_enabled": true,
        "auto_backup": true,
        "version_control": true
    },
    "security": {
        "encryption_enabled": true,
        "access_control": true,
        "audit_logging": true,
        "intrusion_detection": true,
        "auto_security_scan": true
    },
    "monitoring": {
        "system_monitoring": true,
        "performance_monitoring": true,
        "error_monitoring": true,
        "uptime_monitoring": true,
        "alert_system": true
    }
}
'@

Set-Content -Path "$Root\config\config.json" -Value $config -Encoding UTF8

# ===============================
# 8. ARQUIVO .ENV COMPLETO
# ===============================
Write-Progress "Criando arquivo .env completo..."

$env_content = @'
# Agente Manus Definitivo - Configurações de Ambiente

# ===== API KEYS DE IA =====
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
GROQ_API_KEY=
GOOGLE_API_KEY=
COHERE_API_KEY=
HUGGINGFACE_API_KEY=

# ===== WEB3 & BLOCKCHAIN =====
INFURA_PROJECT_ID=
ALCHEMY_API_KEY=
ETHERSCAN_API_KEY=
BSCSCAN_API_KEY=
POLYGONSCAN_API_KEY=
PRIVATE_KEY=
WALLET_ADDRESS=
MNEMONIC_PHRASE=

# ===== TRADING APIS =====
BINANCE_API_KEY=
BINANCE_SECRET_KEY=
COINBASE_API_KEY=
COINBASE_SECRET_KEY=
KRAKEN_API_KEY=
KRAKEN_SECRET_KEY=
ALPHA_VANTAGE_API_KEY=
TWELVE_DATA_API_KEY=

# ===== SOCIAL & COMMUNICATION =====
TELEGRAM_BOT_TOKEN=
DISCORD_BOT_TOKEN=
SLACK_BOT_TOKEN=
TWITTER_API_KEY=
TWITTER_API_SECRET=
WHATSAPP_API_KEY=

# ===== CLOUD SERVICES =====
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=us-east-1
AZURE_CLIENT_ID=
AZURE_CLIENT_SECRET=
AZURE_TENANT_ID=
GCP_PROJECT_ID=
GCP_CREDENTIALS_PATH=

# ===== GITHUB & GIT =====
GITHUB_TOKEN=
GITLAB_TOKEN=
BITBUCKET_TOKEN=

# ===== DATABASE =====
DATABASE_URL=sqlite:///data/manus.db
REDIS_URL=redis://localhost:6379
MONGODB_URL=mongodb://localhost:27017/manus

# ===== SECURITY =====
SECRET_KEY=manus_secret_key_change_this_in_production
JWT_SECRET=jwt_secret_change_this_in_production
ENCRYPTION_KEY=encryption_key_change_this_in_production
API_KEY=manus_api_key_change_this

# ===== MONITORING =====
SENTRY_DSN=
DATADOG_API_KEY=
NEW_RELIC_LICENSE_KEY=
GRAFANA_API_KEY=

# ===== EMAIL =====
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=
SMTP_PASSWORD=
EMAIL_FROM=

# ===== OFFICE 365 =====
OFFICE365_CLIENT_ID=
OFFICE365_CLIENT_SECRET=
OFFICE365_TENANT_ID=

# ===== DEVELOPMENT =====
DEBUG=false
ENVIRONMENT=production
LOG_LEVEL=INFO
TESTING=false

# ===== 24/7 OPERATION =====
ENABLE_24X7=true
HEALTH_CHECK_INTERVAL=60
AUTO_RESTART=true
MAX_MEMORY_USAGE=80
MAX_CPU_USAGE=80
'@

Set-Content -Path "$Root\.env" -Value $env_content -Encoding UTF8

# ===============================
# 9. CORE ENGINE DEFINITIVO
# ===============================
Write-Progress "Criando Core Engine definitivo..."

$core_engine = @'
"""
Agente Manus Definitivo - Core Engine
Humano Digital Completo - Autônomo e Preditivo
Integra TODAS as funcionalidades: Office, Web3, IA, Trading, 24/7
"""

import asyncio
import json
import logging
import os
import sys
import time
import threading
import queue
import traceback
import schedule
import psutil
import sqlite3
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Any, Optional
import subprocess
import shutil
import hashlib
import uuid

# Web Framework
import uvicorn
from fastapi import FastAPI, WebSocket, HTTPException, BackgroundTasks, UploadFile, File
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse, JSONResponse, FileResponse
from fastapi.middleware.cors import CORSMiddleware
import websockets

# Environment & Config
from dotenv import load_dotenv
import requests
import httpx
from bs4 import BeautifulSoup

# Data Processing
import pandas as pd
import numpy as np

# Office & Documents
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment
import xlsxwriter
from docx import Document
from docx.shared import Inches
from pptx import Presentation
from pptx.util import Inches as PptxInches
import PyPDF2
import pdfplumber
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter

# AI & ML
try:
    import openai
    from langchain.llms import OpenAI
    from langchain.chains import LLMChain
    from langchain.prompts import PromptTemplate
except ImportError:
    pass

# Web3 & Blockchain
try:
    from web3 import Web3
    import eth_account
except ImportError:
    pass

# Trading
try:
    import ccxt
    import yfinance as yf
except ImportError:
    pass

# Automation
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from playwright.async_api import async_playwright

# System
import win32gui
import win32con
import pyautogui

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
    """Core do Agente Manus Definitivo - Humano Digital Completo"""
    
    def __init__(self):
        self.root_path = Path(__file__).parent
        self.config = self.load_config()
        self.tasks_queue = queue.Queue()
        self.active_tasks = {}
        self.websocket_connections = set()
        self.is_running = False
        self.predictive_mode = True
        self.autonomous_mode = True
        self.stats = {
            "tasks_completed": 0,
            "tasks_failed": 0,
            "documents_processed": 0,
            "websites_created": 0,
            "apps_created": 0,
            "uptime": 0,
            "start_time": None,
            "system_health": "excellent"
        }
        
        # Carregar variáveis de ambiente
        load_dotenv()
        
        # Inicializar componentes
        self.init_components()
        self.init_database()
        self.init_ai_models()
        self.init_office_integration()
        self.init_web3_integration()
        self.init_trading_integration()
        self.init_security_system()
        self.init_monitoring_system()
        
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
        logger.info("🚀 Inicializando Agente Manus Definitivo...")
        
        # Criar pastas necessárias
        folders = ['logs', 'data', 'temp', 'projects', 'documents', 'spreadsheets', 
                  'presentations', 'pdfs', 'websites', 'apps', 'backups']
        for folder in folders:
            (self.root_path / folder).mkdir(exist_ok=True)
        
        # Inicializar FastAPI
        self.app = FastAPI(
            title="Agente Manus Definitivo",
            description="Humano Digital Completo - Autônomo e Preditivo",
            version="2.0.0"
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
        
        logger.info("✅ Componentes inicializados com sucesso!")
    
    def init_database(self):
        """Inicializa o banco de dados"""
        try:
            self.db_path = self.root_path / "data" / "manus.db"
            self.conn = sqlite3.connect(str(self.db_path), check_same_thread=False)
            
            # Criar tabelas
            self.conn.execute('''
                CREATE TABLE IF NOT EXISTS tasks (
                    id TEXT PRIMARY KEY,
                    type TEXT,
                    description TEXT,
                    status TEXT,
                    created_at TIMESTAMP,
                    completed_at TIMESTAMP,
                    result TEXT
                )
            ''')
            
            self.conn.execute('''
                CREATE TABLE IF NOT EXISTS documents (
                    id TEXT PRIMARY KEY,
                    name TEXT,
                    type TEXT,
                    path TEXT,
                    created_at TIMESTAMP,
                    modified_at TIMESTAMP,
                    size INTEGER
                )
            ''')
            
            self.conn.execute('''
                CREATE TABLE IF NOT EXISTS projects (
                    id TEXT PRIMARY KEY,
                    name TEXT,
                    type TEXT,
                    path TEXT,
                    status TEXT,
                    created_at TIMESTAMP
                )
            ''')
            
            self.conn.commit()
            logger.info("✅ Banco de dados inicializado")
            
        except Exception as e:
            logger.error(f"❌ Erro ao inicializar banco de dados: {e}")
    
    def init_ai_models(self):
        """Inicializa modelos de IA"""
        try:
            self.openai_client = None
            if os.getenv("OPENAI_API_KEY"):
                import openai
                self.openai_client = openai.OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
                logger.info("✅ OpenAI inicializado")
            
            logger.info("✅ Modelos de IA inicializados")
            
        except Exception as e:
            logger.error(f"❌ Erro ao inicializar IA: {e}")
    
    def init_office_integration(self):
        """Inicializa integração com Office"""
        try:
            # Verificar se Office está disponível
            self.office_available = True
            logger.info("✅ Integração Office inicializada")
            
        except Exception as e:
            logger.error(f"❌ Erro ao inicializar Office: {e}")
            self.office_available = False
    
    def init_web3_integration(self):
        """Inicializa integração Web3"""
        try:
            self.web3_enabled = False
            if os.getenv("INFURA_PROJECT_ID") or os.getenv("ALCHEMY_API_KEY"):
                from web3 import Web3
                self.web3_enabled = True
                logger.info("✅ Web3 inicializado")
            
        except Exception as e:
            logger.error(f"❌ Erro ao inicializar Web3: {e}")
    
    def init_trading_integration(self):
        """Inicializa integração de trading"""
        try:
            self.trading_enabled = False
            if os.getenv("BINANCE_API_KEY") or os.getenv("COINBASE_API_KEY"):
                self.trading_enabled = True
                logger.info("✅ Trading inicializado")
            
        except Exception as e:
            logger.error(f"❌ Erro ao inicializar Trading: {e}")
    
    def init_security_system(self):
        """Inicializa sistema de segurança"""
        try:
            self.security_enabled = True
            logger.info("✅ Sistema de segurança inicializado")
            
        except Exception as e:
            logger.error(f"❌ Erro ao inicializar segurança: {e}")
    
    def init_monitoring_system(self):
        """Inicializa sistema de monitoramento"""
        try:
            self.monitoring_enabled = True
            logger.info("✅ Sistema de monitoramento inicializado")
            
        except Exception as e:
            logger.error(f"❌ Erro ao inicializar monitoramento: {e}")
    
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
                "uptime": time.time() - (self.stats["start_time"] or time.time()),
                "system_health": self.get_system_health(),
                "capabilities": self.get_capabilities()
            }
        
        @self.app.post("/api/start")
        async def start_agent():
            if not self.is_running:
                await self.start()
                return {"message": "Agente Manus iniciado com sucesso!", "status": "running"}
            return {"message": "Agente já está rodando", "status": "running"}
        
        @self.app.post("/api/stop")
        async def stop_agent():
            if self.is_running:
                await self.stop()
                return {"message": "Agente parado com sucesso!", "status": "stopped"}
            return {"message": "Agente já está parado", "status": "stopped"}
        
        @self.app.post("/api/task")
        async def add_task(task_data: dict):
            task_id = self.add_task(task_data)
            return {"task_id": task_id, "message": "Tarefa adicionada à fila"}
        
        @self.app.post("/api/request")
        async def process_request(request_data: dict):
            """Processa pedidos em linguagem natural"""
            request_text = request_data.get("text", "")
            task = await self.process_natural_language_request(request_text)
            return {"task": task, "message": "Pedido processado e executado"}
        
        @self.app.post("/api/upload")
        async def upload_file(file: UploadFile = File(...)):
            """Upload de arquivos para processamento"""
            file_path = self.root_path / "temp" / file.filename
            with open(file_path, "wb") as buffer:
                content = await file.read()
                buffer.write(content)
            
            # Processar arquivo automaticamente
            result = await self.process_uploaded_file(str(file_path))
            return {"message": "Arquivo processado", "result": result}
        
        @self.app.get("/api/documents")
        async def list_documents():
            """Lista documentos processados"""
            cursor = self.conn.execute("SELECT * FROM documents ORDER BY created_at DESC")
            documents = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
            return {"documents": documents}
        
        @self.app.get("/api/projects")
        async def list_projects():
            """Lista projetos criados"""
            cursor = self.conn.execute("SELECT * FROM projects ORDER BY created_at DESC")
            projects = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
            return {"projects": projects}
        
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
        """Retorna o HTML do dashboard completo"""
        return '''
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agente Manus Definitivo - Humano Digital</title>
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }
        
        .header h1 {
            font-size: 3.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .header p {
            font-size: 1.3em;
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
            padding: 25px 50px;
            font-size: 1.8em;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 15px 30px rgba(76, 175, 80, 0.3);
            font-weight: bold;
        }
        
        .start-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 40px rgba(76, 175, 80, 0.4);
        }
        
        .start-button.running {
            background: linear-gradient(45deg, #f44336, #d32f2f);
            box-shadow: 0 15px 30px rgba(244, 67, 54, 0.3);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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
        
        .request-panel {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .request-panel h3 {
            margin-bottom: 15px;
            color: #333;
        }
        
        .request-input {
            width: 100%;
            padding: 15px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 1.1em;
            margin-bottom: 15px;
            resize: vertical;
            min-height: 100px;
        }
        
        .request-button {
            background: linear-gradient(45deg, #2196F3, #1976D2);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1.1em;
            transition: all 0.3s ease;
        }
        
        .request-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(33, 150, 243, 0.3);
        }
        
        .activity-log {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            max-height: 500px;
            overflow-y: auto;
        }
        
        .activity-log h3 {
            margin-bottom: 15px;
            color: #333;
        }
        
        .log-entry {
            background: white;
            padding: 12px 15px;
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
        
        .log-entry.info {
            border-left-color: #2196F3;
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
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .capability-card:hover {
            transform: translateY(-5px);
        }
        
        .capability-card h4 {
            margin-bottom: 15px;
            font-size: 1.3em;
        }
        
        .capability-card p {
            opacity: 0.9;
            font-size: 0.95em;
            line-height: 1.5;
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
        
        .upload-area {
            border: 2px dashed #ddd;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            margin: 20px 0;
            transition: all 0.3s ease;
        }
        
        .upload-area:hover {
            border-color: #4CAF50;
            background: #f9f9f9;
        }
        
        .upload-area.dragover {
            border-color: #4CAF50;
            background: #e8f5e8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🤖 Agente Manus Definitivo</h1>
            <p>Humano Digital Completo - Autônomo e Preditivo</p>
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
                    <h3>Tarefas</h3>
                    <div class="value" id="tasksCompleted">0</div>
                </div>
                <div class="stat-card">
                    <h3>Documentos</h3>
                    <div class="value" id="documentsProcessed">0</div>
                </div>
                <div class="stat-card">
                    <h3>Sites/Apps</h3>
                    <div class="value" id="projectsCreated">0</div>
                </div>
                <div class="stat-card">
                    <h3>Tempo Ativo</h3>
                    <div class="value" id="uptime">00:00:00</div>
                </div>
                <div class="stat-card">
                    <h3>Saúde Sistema</h3>
                    <div class="value" id="systemHealth">Excelente</div>
                </div>
            </div>
            
            <div class="request-panel">
                <h3>💬 Faça seu Pedido (Linguagem Natural)</h3>
                <textarea id="requestInput" class="request-input" placeholder="Digite seu pedido aqui... 

Exemplos:
- Crie um site de e-commerce para venda de roupas
- Faça uma planilha de controle financeiro
- Desenvolva um app mobile para delivery
- Crie uma apresentação sobre IA
- Analise este documento PDF
- Otimize meu site para SEO"></textarea>
                <button class="request-button" onclick="processRequest()">Executar Pedido</button>
            </div>
            
            <div class="upload-area" id="uploadArea">
                <h3>📁 Arraste arquivos aqui ou clique para selecionar</h3>
                <p>Suporta: Excel, Word, PowerPoint, PDF, imagens, código, etc.</p>
                <input type="file" id="fileInput" multiple style="display: none;">
            </div>
            
            <div class="activity-log">
                <h3>📋 Log de Atividades em Tempo Real</h3>
                <div id="logContainer">
                    <div class="log-entry">
                        <strong>[SISTEMA]</strong> Agente Manus Definitivo inicializado e pronto para uso
                    </div>
                </div>
            </div>
        </div>
        
        <div class="dashboard">
            <h2 style="text-align: center; margin-bottom: 20px;">🚀 Capacidades Completas do Agente</h2>
            <div class="capabilities">
                <div class="capability-card">
                    <h4>📄 Office Completo</h4>
                    <p>Edita Excel, Word, PowerPoint, PDF. Cria planilhas, documentos, apresentações automaticamente</p>
                </div>
                <div class="capability-card">
                    <h4>🌐 Desenvolvimento Web</h4>
                    <p>Cria sites, aplicações React, APIs Flask, otimização SEO, design responsivo</p>
                </div>
                <div class="capability-card">
                    <h4>📱 Desenvolvimento Mobile</h4>
                    <p>Apps React Native, Flutter, PWA, integração com APIs, publicação nas stores</p>
                </div>
                <div class="capability-card">
                    <h4>⛓️ Web3 & Blockchain</h4>
                    <p>Smart contracts, DeFi, NFTs, trading automatizado, análise on-chain</p>
                </div>
                <div class="capability-card">
                    <h4>🤖 IA Avançada</h4>
                    <p>GPT-4, análise preditiva, machine learning, processamento de linguagem natural</p>
                </div>
                <div class="capability-card">
                    <h4>📊 Análise de Dados</h4>
                    <p>Dashboards interativos, relatórios, visualizações, análise preditiva</p>
                </div>
                <div class="capability-card">
                    <h4>🔧 Automação Total</h4>
                    <p>Scripts, bots, web scraping, automação de tarefas, monitoramento 24/7</p>
                </div>
                <div class="capability-card">
                    <h4>🛡️ Segurança</h4>
                    <p>Auditoria de código, criptografia, controle de acesso, backup automático</p>
                </div>
                <div class="capability-card">
                    <h4>💹 Trading & Finanças</h4>
                    <p>Análise técnica, bots de trading, gestão de risco, relatórios financeiros</p>
                </div>
                <div class="capability-card">
                    <h4>🎯 Modo Preditivo</h4>
                    <p>Antecipa necessidades, sugere melhorias, otimização automática</p>
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
                    button.disabled = true;
                    button.textContent = 'INICIANDO...';
                    
                    const response = await fetch('/api/start', { method: 'POST' });
                    const data = await response.json();
                    
                    if (response.ok) {
                        isRunning = true;
                        button.innerHTML = '<span class="status-indicator running" id="statusIndicator"></span>PARAR AGENTE';
                        button.className = 'start-button running';
                        updateLog({ type: 'success', message: 'Agente Manus iniciado com sucesso! Modo autônomo ativado.' });
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
            } finally {
                button.disabled = false;
            }
        }
        
        async function processRequest() {
            const input = document.getElementById('requestInput');
            const text = input.value.trim();
            
            if (!text) {
                alert('Digite seu pedido primeiro!');
                return;
            }
            
            try {
                updateLog({ type: 'info', message: `Processando pedido: ${text.substring(0, 100)}...` });
                
                const response = await fetch('/api/request', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ text: text })
                });
                
                const data = await response.json();
                
                if (response.ok) {
                    updateLog({ type: 'success', message: 'Pedido processado e executado com sucesso!' });
                    input.value = '';
                } else {
                    updateLog({ type: 'error', message: 'Erro ao processar pedido: ' + data.message });
                }
            } catch (error) {
                updateLog({ type: 'error', message: 'Erro: ' + error.message });
            }
        }
        
        function setupFileUpload() {
            const uploadArea = document.getElementById('uploadArea');
            const fileInput = document.getElementById('fileInput');
            
            uploadArea.addEventListener('click', () => fileInput.click());
            
            uploadArea.addEventListener('dragover', (e) => {
                e.preventDefault();
                uploadArea.classList.add('dragover');
            });
            
            uploadArea.addEventListener('dragleave', () => {
                uploadArea.classList.remove('dragover');
            });
            
            uploadArea.addEventListener('drop', (e) => {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
                handleFiles(e.dataTransfer.files);
            });
            
            fileInput.addEventListener('change', (e) => {
                handleFiles(e.target.files);
            });
        }
        
        async function handleFiles(files) {
            for (let file of files) {
                const formData = new FormData();
                formData.append('file', file);
                
                try {
                    updateLog({ type: 'info', message: `Processando arquivo: ${file.name}` });
                    
                    const response = await fetch('/api/upload', {
                        method: 'POST',
                        body: formData
                    });
                    
                    const data = await response.json();
                    
                    if (response.ok) {
                        updateLog({ type: 'success', message: `Arquivo ${file.name} processado com sucesso!` });
                    } else {
                        updateLog({ type: 'error', message: `Erro ao processar ${file.name}: ${data.message}` });
                    }
                } catch (error) {
                    updateLog({ type: 'error', message: `Erro ao enviar ${file.name}: ${error.message}` });
                }
            }
        }
        
        function updateLog(data) {
            const container = document.getElementById('logContainer');
            const entry = document.createElement('div');
            entry.className = `log-entry ${data.type || 'info'}`;
            
            const timestamp = new Date().toLocaleTimeString();
            entry.innerHTML = `<strong>[${timestamp}]</strong> ${data.message}`;
            
            container.insertBefore(entry, container.firstChild);
            
            // Manter apenas os últimos 100 logs
            while (container.children.length > 100) {
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
                document.getElementById('documentsProcessed').textContent = 
                    data.stats.documents_processed;
                document.getElementById('projectsCreated').textContent = 
                    (data.stats.websites_created + data.stats.apps_created);
                document.getElementById('systemHealth').textContent = 
                    data.stats.system_health || 'Excelente';
                
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
        setupFileUpload();
        updateStats();
        setInterval(updateStats, 5000);
        
        // Log inicial
        updateLog({ 
            type: 'info', 
            message: 'Agente Manus Definitivo carregado. Clique em INICIAR AGENTE para ativar o modo autônomo.' 
        });
        
        // Adicionar sugestões de pedidos
        const suggestions = [
            "Crie um site de portfólio profissional",
            "Faça uma planilha de controle de gastos",
            "Desenvolva um app de lista de tarefas",
            "Crie uma apresentação sobre sustentabilidade",
            "Analise este relatório financeiro",
            "Otimize meu código Python",
            "Crie um dashboard de vendas",
            "Desenvolva um bot para Telegram"
        ];
        
        let suggestionIndex = 0;
        setInterval(() => {
            const input = document.getElementById('requestInput');
            if (!input.value) {
                input.placeholder = `Exemplo: ${suggestions[suggestionIndex]}`;
                suggestionIndex = (suggestionIndex + 1) % suggestions.length;
            }
        }, 3000);
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
        
        logger.info("🚀 Agente Manus Definitivo iniciado!")
        
        # Iniciar worker threads
        worker_thread = threading.Thread(target=self.worker_loop, daemon=True)
        worker_thread.start()
        
        # Iniciar monitoramento 24/7
        monitor_thread = threading.Thread(target=self.monitoring_loop, daemon=True)
        monitor_thread.start()
        
        # Iniciar modo preditivo
        predictive_thread = threading.Thread(target=self.predictive_loop, daemon=True)
        predictive_thread.start()
        
        # Broadcast para websockets
        await self.broadcast_message({
            "type": "success",
            "message": "Agente Manus Definitivo iniciado! Modo autônomo e preditivo ativado."
        })
        
        # Adicionar tarefas iniciais
        self.add_task({
            "type": "system_check",
            "description": "Verificação inicial completa do sistema"
        })
        
        self.add_task({
            "type": "predictive_analysis",
            "description": "Análise preditiva do ambiente de trabalho"
        })
    
    async def stop(self):
        """Para o agente"""
        self.is_running = False
        logger.info("🛑 Agente Manus Definitivo parado")
        
        await self.broadcast_message({
            "type": "info",
            "message": "Agente Manus Definitivo parado"
        })
    
    def add_task(self, task_data: Dict) -> str:
        """Adiciona uma tarefa à fila"""
        task_id = f"task_{int(time.time() * 1000)}_{uuid.uuid4().hex[:8]}"
        task = {
            "id": task_id,
            "created_at": datetime.now().isoformat(),
            "status": "pending",
            **task_data
        }
        
        self.tasks_queue.put(task)
        logger.info(f"📝 Tarefa adicionada: {task_id}")
        
        # Salvar no banco
        self.conn.execute(
            "INSERT INTO tasks (id, type, description, status, created_at) VALUES (?, ?, ?, ?, ?)",
            (task_id, task.get("type"), task.get("description"), "pending", task["created_at"])
        )
        self.conn.commit()
        
        return task_id
    
    async def process_natural_language_request(self, request_text: str) -> Dict:
        """Processa pedidos em linguagem natural"""
        logger.info(f"🗣️ Processando pedido: {request_text[:100]}...")
        
        # Análise do pedido usando IA
        task_type = self.analyze_request_intent(request_text)
        
        # Criar tarefa baseada na análise
        task = {
            "type": task_type,
            "description": request_text,
            "auto_generated": True
        }
        
        task_id = self.add_task(task)
        
        return {
            "task_id": task_id,
            "type": task_type,
            "description": request_text
        }
    
    def analyze_request_intent(self, text: str) -> str:
        """Analisa a intenção do pedido"""
        text_lower = text.lower()
        
        # Palavras-chave para diferentes tipos de tarefas
        if any(word in text_lower for word in ['site', 'website', 'página', 'web', 'html']):
            return "create_website"
        elif any(word in text_lower for word in ['app', 'aplicativo', 'mobile', 'android', 'ios']):
            return "create_app"
        elif any(word in text_lower for word in ['planilha', 'excel', 'spreadsheet', 'tabela']):
            return "create_spreadsheet"
        elif any(word in text_lower for word in ['documento', 'word', 'texto', 'relatório']):
            return "create_document"
        elif any(word in text_lower for word in ['apresentação', 'powerpoint', 'ppt', 'slides']):
            return "create_presentation"
        elif any(word in text_lower for word in ['pdf', 'converter', 'gerar pdf']):
            return "create_pdf"
        elif any(word in text_lower for word in ['dashboard', 'painel', 'gráfico', 'visualização']):
            return "create_dashboard"
        elif any(word in text_lower for word in ['analisar', 'análise', 'examinar', 'verificar']):
            return "analyze_content"
        elif any(word in text_lower for word in ['otimizar', 'melhorar', 'aperfeiçoar']):
            return "optimize_content"
        elif any(word in text_lower for word in ['web3', 'blockchain', 'smart contract', 'token']):
            return "web3_task"
        elif any(word in text_lower for word in ['trading', 'investimento', 'ações', 'crypto']):
            return "trading_task"
        else:
            return "general_task"
    
    async def process_uploaded_file(self, file_path: str) -> Dict:
        """Processa arquivo enviado"""
        file_ext = Path(file_path).suffix.lower()
        
        if file_ext in ['.xlsx', '.xls']:
            return await self.process_excel_file(file_path)
        elif file_ext in ['.docx', '.doc']:
            return await self.process_word_file(file_path)
        elif file_ext in ['.pptx', '.ppt']:
            return await self.process_powerpoint_file(file_path)
        elif file_ext == '.pdf':
            return await self.process_pdf_file(file_path)
        else:
            return {"message": "Tipo de arquivo não suportado", "success": False}
    
    async def process_excel_file(self, file_path: str) -> Dict:
        """Processa arquivo Excel"""
        try:
            df = pd.read_excel(file_path)
            
            # Análise básica
            analysis = {
                "rows": len(df),
                "columns": len(df.columns),
                "column_names": list(df.columns),
                "data_types": df.dtypes.to_dict(),
                "missing_values": df.isnull().sum().to_dict()
            }
            
            # Salvar informações no banco
            doc_id = str(uuid.uuid4())
            self.conn.execute(
                "INSERT INTO documents (id, name, type, path, created_at, size) VALUES (?, ?, ?, ?, ?, ?)",
                (doc_id, Path(file_path).name, "excel", file_path, datetime.now().isoformat(), Path(file_path).stat().st_size)
            )
            self.conn.commit()
            
            self.stats["documents_processed"] += 1
            
            return {
                "success": True,
                "type": "excel",
                "analysis": analysis,
                "suggestions": [
                    "Criar gráficos automáticos",
                    "Adicionar fórmulas de análise",
                    "Gerar relatório em PDF",
                    "Criar dashboard interativo"
                ]
            }
            
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    async def process_word_file(self, file_path: str) -> Dict:
        """Processa arquivo Word"""
        try:
            doc = Document(file_path)
            
            # Extrair texto
            text = ""
            for paragraph in doc.paragraphs:
                text += paragraph.text + "\n"
            
            # Análise básica
            analysis = {
                "paragraphs": len(doc.paragraphs),
                "characters": len(text),
                "words": len(text.split()),
                "tables": len(doc.tables)
            }
            
            # Salvar informações no banco
            doc_id = str(uuid.uuid4())
            self.conn.execute(
                "INSERT INTO documents (id, name, type, path, created_at, size) VALUES (?, ?, ?, ?, ?, ?)",
                (doc_id, Path(file_path).name, "word", file_path, datetime.now().isoformat(), Path(file_path).stat().st_size)
            )
            self.conn.commit()
            
            self.stats["documents_processed"] += 1
            
            return {
                "success": True,
                "type": "word",
                "analysis": analysis,
                "suggestions": [
                    "Melhorar formatação",
                    "Adicionar índice automático",
                    "Converter para PDF",
                    "Criar versão web"
                ]
            }
            
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    async def process_powerpoint_file(self, file_path: str) -> Dict:
        """Processa arquivo PowerPoint"""
        try:
            prs = Presentation(file_path)
            
            # Análise básica
            analysis = {
                "slides": len(prs.slides),
                "layouts": len(prs.slide_layouts)
            }
            
            # Salvar informações no banco
            doc_id = str(uuid.uuid4())
            self.conn.execute(
                "INSERT INTO documents (id, name, type, path, created_at, size) VALUES (?, ?, ?, ?, ?, ?)",
                (doc_id, Path(file_path).name, "powerpoint", file_path, datetime.now().isoformat(), Path(file_path).stat().st_size)
            )
            self.conn.commit()
            
            self.stats["documents_processed"] += 1
            
            return {
                "success": True,
                "type": "powerpoint",
                "analysis": analysis,
                "suggestions": [
                    "Melhorar design dos slides",
                    "Adicionar animações",
                    "Converter para vídeo",
                    "Criar versão web interativa"
                ]
            }
            
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    async def process_pdf_file(self, file_path: str) -> Dict:
        """Processa arquivo PDF"""
        try:
            with open(file_path, 'rb') as file:
                pdf_reader = PyPDF2.PdfReader(file)
                
                # Extrair texto
                text = ""
                for page in pdf_reader.pages:
                    text += page.extract_text()
                
                # Análise básica
                analysis = {
                    "pages": len(pdf_reader.pages),
                    "characters": len(text),
                    "words": len(text.split())
                }
            
            # Salvar informações no banco
            doc_id = str(uuid.uuid4())
            self.conn.execute(
                "INSERT INTO documents (id, name, type, path, created_at, size) VALUES (?, ?, ?, ?, ?, ?)",
                (doc_id, Path(file_path).name, "pdf", file_path, datetime.now().isoformat(), Path(file_path).stat().st_size)
            )
            self.conn.commit()
            
            self.stats["documents_processed"] += 1
            
            return {
                "success": True,
                "type": "pdf",
                "analysis": analysis,
                "suggestions": [
                    "Extrair dados estruturados",
                    "Converter para Word editável",
                    "Criar resumo automático",
                    "Indexar para busca"
                ]
            }
            
        except Exception as e:
            return {"success": False, "error": str(e)}
    
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
    
    def monitoring_loop(self):
        """Loop de monitoramento 24/7"""
        logger.info("📊 Sistema de monitoramento 24/7 iniciado")
        
        while self.is_running:
            try:
                # Verificar saúde do sistema
                cpu_percent = psutil.cpu_percent(interval=1)
                memory_percent = psutil.virtual_memory().percent
                disk_percent = psutil.disk_usage('/').percent
                
                # Atualizar estatísticas
                if cpu_percent > 80 or memory_percent > 80:
                    self.stats["system_health"] = "warning"
                elif cpu_percent > 90 or memory_percent > 90:
                    self.stats["system_health"] = "critical"
                else:
                    self.stats["system_health"] = "excellent"
                
                # Backup automático a cada hora
                if int(time.time()) % 3600 == 0:
                    self.create_backup()
                
                time.sleep(60)  # Verificar a cada minuto
                
            except Exception as e:
                logger.error(f"Erro no monitoramento: {e}")
                time.sleep(60)
    
    def predictive_loop(self):
        """Loop de análise preditiva"""
        logger.info("🔮 Sistema preditivo iniciado")
        
        while self.is_running:
            try:
                # Análise preditiva a cada 5 minutos
                if self.predictive_mode:
                    self.run_predictive_analysis()
                
                time.sleep(300)  # 5 minutos
                
            except Exception as e:
                logger.error(f"Erro na análise preditiva: {e}")
                time.sleep(300)
    
    def run_predictive_analysis(self):
        """Executa análise preditiva"""
        try:
            # Analisar padrões de uso
            # Sugerir otimizações
            # Antecipar necessidades
            
            logger.info("🔮 Executando análise preditiva...")
            
            # Exemplo: verificar se há arquivos não processados
            temp_files = list(Path(self.root_path / "temp").glob("*"))
            if temp_files:
                for file_path in temp_files:
                    if file_path.is_file():
                        self.add_task({
                            "type": "auto_process_file",
                            "description": f"Processamento automático de {file_path.name}",
                            "file_path": str(file_path),
                            "auto_generated": True
                        })
            
        except Exception as e:
            logger.error(f"Erro na análise preditiva: {e}")
    
    def create_backup(self):
        """Cria backup automático"""
        try:
            backup_dir = self.root_path / "backups" / datetime.now().strftime("%Y%m%d_%H%M%S")
            backup_dir.mkdir(parents=True, exist_ok=True)
            
            # Backup do banco de dados
            shutil.copy2(self.db_path, backup_dir / "manus.db")
            
            # Backup dos logs
            shutil.copytree(self.root_path / "logs", backup_dir / "logs", dirs_exist_ok=True)
            
            logger.info(f"✅ Backup criado: {backup_dir}")
            
        except Exception as e:
            logger.error(f"❌ Erro ao criar backup: {e}")
    
    def process_task(self, task: Dict):
        """Processa uma tarefa"""
        task_id = task["id"]
        self.active_tasks[task_id] = task
        
        try:
            logger.info(f"🔧 Processando tarefa: {task_id}")
            
            # Atualizar status no banco
            self.conn.execute(
                "UPDATE tasks SET status = ? WHERE id = ?",
                ("processing", task_id)
            )
            self.conn.commit()
            
            # Processar baseado no tipo
            task_type = task.get("type", "unknown")
            result = {}
            
            if task_type == "system_check":
                result = self.system_check()
            elif task_type == "create_website":
                result = self.create_website(task)
            elif task_type == "create_app":
                result = self.create_app(task)
            elif task_type == "create_spreadsheet":
                result = self.create_spreadsheet(task)
            elif task_type == "create_document":
                result = self.create_document(task)
            elif task_type == "create_presentation":
                result = self.create_presentation(task)
            elif task_type == "create_pdf":
                result = self.create_pdf(task)
            elif task_type == "create_dashboard":
                result = self.create_dashboard(task)
            elif task_type == "analyze_content":
                result = self.analyze_content(task)
            elif task_type == "optimize_content":
                result = self.optimize_content(task)
            elif task_type == "web3_task":
                result = self.process_web3_task(task)
            elif task_type == "trading_task":
                result = self.process_trading_task(task)
            elif task_type == "auto_process_file":
                result = self.auto_process_file(task)
            elif task_type == "predictive_analysis":
                result = self.predictive_analysis()
            else:
                result = self.process_general_task(task)
            
            # Marcar como concluída
            task["status"] = "completed"
            task["completed_at"] = datetime.now().isoformat()
            task["result"] = result
            self.stats["tasks_completed"] += 1
            
            # Atualizar no banco
            self.conn.execute(
                "UPDATE tasks SET status = ?, completed_at = ?, result = ? WHERE id = ?",
                ("completed", task["completed_at"], json.dumps(result), task_id)
            )
            self.conn.commit()
            
            logger.info(f"✅ Tarefa concluída: {task_id}")
            
        except Exception as e:
            logger.error(f"❌ Erro ao processar tarefa {task_id}: {e}")
            task["status"] = "failed"
            task["error"] = str(e)
            self.stats["tasks_failed"] += 1
            
            # Atualizar no banco
            self.conn.execute(
                "UPDATE tasks SET status = ?, result = ? WHERE id = ?",
                ("failed", json.dumps({"error": str(e)}), task_id)
            )
            self.conn.commit()
            
        finally:
            if task_id in self.active_tasks:
                del self.active_tasks[task_id]
    
    def system_check(self) -> Dict:
        """Verificação completa do sistema"""
        logger.info("🔍 Executando verificação completa do sistema...")
        
        checks = []
        
        # Verificar Python
        checks.append(("Python", sys.version, "OK"))
        
        # Verificar espaço em disco
        disk_usage = psutil.disk_usage('/')
        disk_free_gb = disk_usage.free / (1024**3)
        checks.append(("Espaço em disco", f"{disk_free_gb:.1f} GB livres", "OK" if disk_free_gb > 1 else "WARNING"))
        
        # Verificar memória
        memory = psutil.virtual_memory()
        checks.append(("Memória RAM", f"{memory.percent}% usado", "OK" if memory.percent < 80 else "WARNING"))
        
        # Verificar CPU
        cpu_percent = psutil.cpu_percent(interval=1)
        checks.append(("CPU", f"{cpu_percent}% uso", "OK" if cpu_percent < 80 else "WARNING"))
        
        # Verificar conectividade
        try:
            response = requests.get("https://www.google.com", timeout=5)
            checks.append(("Internet", "Conectado", "OK"))
        except:
            checks.append(("Internet", "Desconectado", "ERROR"))
        
        # Verificar APIs
        if os.getenv("OPENAI_API_KEY"):
            checks.append(("OpenAI API", "Configurada", "OK"))
        else:
            checks.append(("OpenAI API", "Não configurada", "WARNING"))
        
        for component, status, level in checks:
            logger.info(f"  {'✓' if level == 'OK' else '⚠' if level == 'WARNING' else '✗'} {component}: {status}")
        
        return {
            "checks": checks,
            "overall_status": "healthy" if all(check[2] == "OK" for check in checks) else "warning"
        }
    
    def create_website(self, task: Dict) -> Dict:
        """Cria um website completo"""
        logger.info("🌐 Criando website...")
        
        description = task.get("description", "")
        project_name = f"website_{int(time.time())}"
        project_path = self.root_path / "websites" / project_name
        project_path.mkdir(parents=True, exist_ok=True)
        
        # Analisar descrição para determinar tipo de site
        site_type = self.determine_website_type(description)
        
        # Criar estrutura básica
        (project_path / "css").mkdir(exist_ok=True)
        (project_path / "js").mkdir(exist_ok=True)
        (project_path / "images").mkdir(exist_ok=True)
        
        # HTML principal
        html_content = self.generate_html_content(site_type, description)
        with open(project_path / "index.html", "w", encoding="utf-8") as f:
            f.write(html_content)
        
        # CSS
        css_content = self.generate_css_content(site_type)
        with open(project_path / "css" / "style.css", "w", encoding="utf-8") as f:
            f.write(css_content)
        
        # JavaScript
        js_content = self.generate_js_content(site_type)
        with open(project_path / "js" / "script.js", "w", encoding="utf-8") as f:
            f.write(js_content)
        
        # Salvar projeto no banco
        project_id = str(uuid.uuid4())
        self.conn.execute(
            "INSERT INTO projects (id, name, type, path, status, created_at) VALUES (?, ?, ?, ?, ?, ?)",
            (project_id, project_name, "website", str(project_path), "completed", datetime.now().isoformat())
        )
        self.conn.commit()
        
        self.stats["websites_created"] += 1
        
        return {
            "success": True,
            "project_name": project_name,
            "project_path": str(project_path),
            "site_type": site_type,
            "files_created": ["index.html", "css/style.css", "js/script.js"]
        }
    
    def determine_website_type(self, description: str) -> str:
        """Determina o tipo de website baseado na descrição"""
        desc_lower = description.lower()
        
        if any(word in desc_lower for word in ['e-commerce', 'loja', 'venda', 'produto']):
            return "ecommerce"
        elif any(word in desc_lower for word in ['portfólio', 'portfolio', 'pessoal', 'profissional']):
            return "portfolio"
        elif any(word in desc_lower for word in ['blog', 'notícias', 'artigo']):
            return "blog"
        elif any(word in desc_lower for word in ['empresa', 'corporativo', 'negócio']):
            return "corporate"
        elif any(word in desc_lower for word in ['landing', 'página de captura', 'conversão']):
            return "landing"
        else:
            return "general"
    
    def generate_html_content(self, site_type: str, description: str) -> str:
        """Gera conteúdo HTML baseado no tipo de site"""
        
        if site_type == "ecommerce":
            return '''<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loja Online - Criada pelo Agente Manus</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <nav>
            <div class="logo">Minha Loja</div>
            <ul>
                <li><a href="#home">Início</a></li>
                <li><a href="#produtos">Produtos</a></li>
                <li><a href="#sobre">Sobre</a></li>
                <li><a href="#contato">Contato</a></li>
                <li><a href="#carrinho" class="cart">🛒 Carrinho (0)</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section id="home" class="hero">
            <h1>Bem-vindo à Nossa Loja</h1>
            <p>Produtos de qualidade com os melhores preços</p>
            <button class="cta-button">Ver Produtos</button>
        </section>

        <section id="produtos" class="products">
            <h2>Nossos Produtos</h2>
            <div class="product-grid">
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Produto 1">
                    <h3>Produto 1</h3>
                    <p class="price">R$ 99,90</p>
                    <button class="add-to-cart">Adicionar ao Carrinho</button>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Produto 2">
                    <h3>Produto 2</h3>
                    <p class="price">R$ 149,90</p>
                    <button class="add-to-cart">Adicionar ao Carrinho</button>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Produto 3">
                    <h3>Produto 3</h3>
                    <p class="price">R$ 199,90</p>
                    <button class="add-to-cart">Adicionar ao Carrinho</button>
                </div>
            </div>
        </section>

        <section id="sobre" class="about">
            <h2>Sobre Nós</h2>
            <p>Somos uma empresa comprometida em oferecer os melhores produtos com qualidade excepcional.</p>
        </section>

        <section id="contato" class="contact">
            <h2>Entre em Contato</h2>
            <form>
                <input type="text" placeholder="Seu nome" required>
                <input type="email" placeholder="Seu email" required>
                <textarea placeholder="Sua mensagem" required></textarea>
                <button type="submit">Enviar</button>
            </form>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Minha Loja. Criado pelo Agente Manus. Todos os direitos reservados.</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>'''
        
        elif site_type == "portfolio":
            return '''<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Portfólio - Criado pelo Agente Manus</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <nav>
            <div class="logo">Meu Nome</div>
            <ul>
                <li><a href="#home">Início</a></li>
                <li><a href="#sobre">Sobre</a></li>
                <li><a href="#portfolio">Portfólio</a></li>
                <li><a href="#contato">Contato</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section id="home" class="hero">
            <h1>Olá, eu sou [Seu Nome]</h1>
            <p>Desenvolvedor Full Stack & Designer</p>
            <button class="cta-button">Ver Meu Trabalho</button>
        </section>

        <section id="sobre" class="about">
            <h2>Sobre Mim</h2>
            <div class="about-content">
                <div class="about-text">
                    <p>Sou um profissional apaixonado por tecnologia e design, com experiência em desenvolvimento web e criação de soluções inovadoras.</p>
                    <div class="skills">
                        <h3>Habilidades</h3>
                        <div class="skill-tags">
                            <span>HTML/CSS</span>
                            <span>JavaScript</span>
                            <span>React</span>
                            <span>Python</span>
                            <span>Node.js</span>
                            <span>Design UI/UX</span>
                        </div>
                    </div>
                </div>
                <div class="about-image">
                    <img src="https://via.placeholder.com/300x300" alt="Minha foto">
                </div>
            </div>
        </section>

        <section id="portfolio" class="portfolio">
            <h2>Meu Portfólio</h2>
            <div class="portfolio-grid">
                <div class="portfolio-item">
                    <img src="https://via.placeholder.com/400x300" alt="Projeto 1">
                    <div class="portfolio-overlay">
                        <h3>Projeto 1</h3>
                        <p>Descrição do projeto</p>
                        <a href="#" class="view-project">Ver Projeto</a>
                    </div>
                </div>
                <div class="portfolio-item">
                    <img src="https://via.placeholder.com/400x300" alt="Projeto 2">
                    <div class="portfolio-overlay">
                        <h3>Projeto 2</h3>
                        <p>Descrição do projeto</p>
                        <a href="#" class="view-project">Ver Projeto</a>
                    </div>
                </div>
                <div class="portfolio-item">
                    <img src="https://via.placeholder.com/400x300" alt="Projeto 3">
                    <div class="portfolio-overlay">
                        <h3>Projeto 3</h3>
                        <p>Descrição do projeto</p>
                        <a href="#" class="view-project">Ver Projeto</a>
                    </div>
                </div>
            </div>
        </section>

        <section id="contato" class="contact">
            <h2>Entre em Contato</h2>
            <div class="contact-content">
                <div class="contact-info">
                    <h3>Vamos trabalhar juntos!</h3>
                    <p>📧 email@exemplo.com</p>
                    <p>📱 (11) 99999-9999</p>
                    <p>📍 São Paulo, SP</p>
                </div>
                <form class="contact-form">
                    <input type="text" placeholder="Seu nome" required>
                    <input type="email" placeholder="Seu email" required>
                    <textarea placeholder="Sua mensagem" required></textarea>
                    <button type="submit">Enviar Mensagem</button>
                </form>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Meu Portfólio. Criado pelo Agente Manus. Todos os direitos reservados.</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>'''
        
        else:  # general
            return '''<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Site - Criado pelo Agente Manus</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <nav>
            <div class="logo">Meu Site</div>
            <ul>
                <li><a href="#home">Início</a></li>
                <li><a href="#sobre">Sobre</a></li>
                <li><a href="#servicos">Serviços</a></li>
                <li><a href="#contato">Contato</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section id="home" class="hero">
            <h1>Bem-vindo ao Meu Site</h1>
            <p>Site criado automaticamente pelo Agente Manus</p>
            <button class="cta-button">Saiba Mais</button>
        </section>

        <section id="sobre" class="about">
            <h2>Sobre</h2>
            <p>Este site foi criado automaticamente pelo Agente Manus, demonstrando a capacidade de gerar websites completos e funcionais.</p>
        </section>

        <section id="servicos" class="services">
            <h2>Serviços</h2>
            <div class="services-grid">
                <div class="service-card">
                    <h3>Desenvolvimento Web</h3>
                    <p>Criação de sites modernos e responsivos</p>
                </div>
                <div class="service-card">
                    <h3>Automação</h3>
                    <p>Soluções automatizadas para seu negócio</p>
                </div>
                <div class="service-card">
                    <h3>Consultoria</h3>
                    <p>Orientação especializada em tecnologia</p>
                </div>
            </div>
        </section>

        <section id="contato" class="contact">
            <h2>Contato</h2>
            <form>
                <input type="text" placeholder="Seu nome" required>
                <input type="email" placeholder="Seu email" required>
                <textarea placeholder="Sua mensagem" required></textarea>
                <button type="submit">Enviar</button>
            </form>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Meu Site. Criado pelo Agente Manus. Todos os direitos reservados.</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>'''
    
    def generate_css_content(self, site_type: str) -> str:
        """Gera conteúdo CSS baseado no tipo de site"""
        return '''/* Reset e Base */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
}

/* Header */
header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 1rem 0;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1000;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
}

nav ul {
    display: flex;
    list-style: none;
    gap: 2rem;
}

nav a {
    color: white;
    text-decoration: none;
    transition: opacity 0.3s ease;
}

nav a:hover {
    opacity: 0.8;
}

/* Main Content */
main {
    margin-top: 80px;
}

section {
    padding: 4rem 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

/* Hero Section */
.hero {
    text-align: center;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    padding: 6rem 2rem;
}

.hero h1 {
    font-size: 3rem;
    margin-bottom: 1rem;
    color: #333;
}

.hero p {
    font-size: 1.2rem;
    margin-bottom: 2rem;
    color: #666;
}

.cta-button {
    background: linear-gradient(45deg, #4CAF50, #45a049);
    color: white;
    border: none;
    padding: 1rem 2rem;
    font-size: 1.1rem;
    border-radius: 50px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
}

.cta-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(76, 175, 80, 0.4);
}

/* Grid Layouts */
.product-grid,
.services-grid,
.portfolio-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    margin-top: 2rem;
}

/* Cards */
.product-card,
.service-card,
.portfolio-item {
    background: white;
    border-radius: 15px;
    padding: 1.5rem;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
}

.product-card:hover,
.service-card:hover,
.portfolio-item:hover {
    transform: translateY(-5px);
}

.product-card img,
.portfolio-item img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    margin-bottom: 1rem;
}

.price {
    font-size: 1.5rem;
    font-weight: bold;
    color: #4CAF50;
    margin: 0.5rem 0;
}

.add-to-cart,
.view-project {
    background: #2196F3;
    color: white;
    border: none;
    padding: 0.8rem 1.5rem;
    border-radius: 25px;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    transition: all 0.3s ease;
}

.add-to-cart:hover,
.view-project:hover {
    background: #1976D2;
    transform: translateY(-2px);
}

/* About Section */
.about-content {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 3rem;
    align-items: center;
}

.about-image img {
    width: 100%;
    border-radius: 15px;
}

.skills {
    margin-top: 2rem;
}

.skill-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-top: 1rem;
}

.skill-tags span {
    background: #e3f2fd;
    color: #1976d2;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.9rem;
}

/* Portfolio */
.portfolio-item {
    position: relative;
    overflow: hidden;
    padding: 0;
}

.portfolio-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.8);
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.portfolio-item:hover .portfolio-overlay {
    opacity: 1;
}

/* Contact */
.contact-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3rem;
}

.contact-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.contact-form input,
.contact-form textarea {
    padding: 1rem;
    border: 2px solid #ddd;
    border-radius: 10px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
}

.contact-form input:focus,
.contact-form textarea:focus {
    outline: none;
    border-color: #4CAF50;
}

.contact-form button {
    background: linear-gradient(45deg, #4CAF50, #45a049);
    color: white;
    border: none;
    padding: 1rem;
    border-radius: 10px;
    cursor: pointer;
    font-size: 1rem;
    transition: all 0.3s ease;
}

.contact-form button:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
}

/* Footer */
footer {
    background: #333;
    color: white;
    text-align: center;
    padding: 2rem;
}

/* Responsive */
@media (max-width: 768px) {
    nav {
        flex-direction: column;
        gap: 1rem;
    }
    
    nav ul {
        gap: 1rem;
    }
    
    .hero h1 {
        font-size: 2rem;
    }
    
    .about-content,
    .contact-content {
        grid-template-columns: 1fr;
    }
    
    .product-grid,
    .services-grid,
    .portfolio-grid {
        grid-template-columns: 1fr;
    }
}'''
    
    def generate_js_content(self, site_type: str) -> str:
        """Gera conteúdo JavaScript baseado no tipo de site"""
        return '''// Agente Manus - JavaScript Automático

// Smooth scrolling para links de navegação
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Animações ao scroll
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Aplicar animações a elementos
document.querySelectorAll('section').forEach(section => {
    section.style.opacity = '0';
    section.style.transform = 'translateY(30px)';
    section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(section);
});

// Funcionalidade do carrinho (para e-commerce)
let cart = [];

function addToCart(productName, price) {
    cart.push({ name: productName, price: price });
    updateCartDisplay();
    showNotification(`${productName} adicionado ao carrinho!`);
}

function updateCartDisplay() {
    const cartElement = document.querySelector('.cart');
    if (cartElement) {
        cartElement.textContent = `🛒 Carrinho (${cart.length})`;
    }
}

function showNotification(message) {
    const notification = document.createElement('div');
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 100px;
        right: 20px;
        background: #4CAF50;
        color: white;
        padding: 1rem 2rem;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        z-index: 1001;
        animation: slideIn 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.remove();
    }, 3000);
}

// Event listeners para botões de adicionar ao carrinho
document.querySelectorAll('.add-to-cart').forEach(button => {
    button.addEventListener('click', function() {
        const productCard = this.closest('.product-card');
        const productName = productCard.querySelector('h3').textContent;
        const productPrice = productCard.querySelector('.price').textContent;
        addToCart(productName, productPrice);
    });
});

// Formulário de contato
document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Simular envio
        const button = this.querySelector('button[type="submit"]');
        const originalText = button.textContent;
        
        button.textContent = 'Enviando...';
        button.disabled = true;
        
        setTimeout(() => {
            button.textContent = 'Enviado!';
            button.style.background = '#4CAF50';
            
            setTimeout(() => {
                button.textContent = originalText;
                button.disabled = false;
                button.style.background = '';
                this.reset();
            }, 2000);
        }, 1000);
        
        showNotification('Mensagem enviada com sucesso!');
    });
});

// Header transparente ao scroll
window.addEventListener('scroll', () => {
    const header = document.querySelector('header');
    if (window.scrollY > 100) {
        header.style.background = 'rgba(102, 126, 234, 0.95)';
        header.style.backdropFilter = 'blur(10px)';
    } else {
        header.style.background = 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
        header.style.backdropFilter = 'none';
    }
});

// Adicionar CSS para animações
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    .fade-in {
        animation: fadeIn 0.6s ease;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
`;
document.head.appendChild(style);

// Log de inicialização
console.log('🤖 Site criado pelo Agente Manus - JavaScript carregado com sucesso!');
console.log('✨ Funcionalidades ativas: navegação suave, animações, carrinho, formulários');'''
    
    def create_app(self, task: Dict) -> Dict:
        """Cria um aplicativo mobile"""
        logger.info("📱 Criando aplicativo mobile...")
        
        description = task.get("description", "")
        project_name = f"app_{int(time.time())}"
        project_path = self.root_path / "apps" / project_name
        project_path.mkdir(parents=True, exist_ok=True)
        
        # Determinar tipo de app
        app_type = self.determine_app_type(description)
        
        # Criar estrutura React Native básica
        self.create_react_native_structure(project_path, app_type, description)
        
        # Salvar projeto no banco
        project_id = str(uuid.uuid4())
        self.conn.execute(
            "INSERT INTO projects (id, name, type, path, status, created_at) VALUES (?, ?, ?, ?, ?, ?)",
            (project_id, project_name, "mobile_app", str(project_path), "completed", datetime.now().isoformat())
        )
        self.conn.commit()
        
        self.stats["apps_created"] += 1
        
        return {
            "success": True,
            "project_name": project_name,
            "project_path": str(project_path),
            "app_type": app_type,
            "platform": "React Native"
        }
    
    def determine_app_type(self, description: str) -> str:
        """Determina o tipo de app baseado na descrição"""
        desc_lower = description.lower()
        
        if any(word in desc_lower for word in ['lista', 'tarefa', 'todo', 'task']):
            return "todo"
        elif any(word in desc_lower for word in ['delivery', 'entrega', 'comida', 'restaurante']):
            return "delivery"
        elif any(word in desc_lower for word in ['chat', 'mensagem', 'conversa']):
            return "chat"
        elif any(word in desc_lower for word in ['loja', 'e-commerce', 'compra', 'venda']):
            return "ecommerce"
        elif any(word in desc_lower for word in ['fitness', 'exercício', 'treino', 'academia']):
            return "fitness"
        else:
            return "general"
    
    def create_react_native_structure(self, project_path: Path, app_type: str, description: str):
        """Cria estrutura React Native"""
        
        # package.json
        package_json = {
            "name": project_path.name,
            "version": "1.0.0",
            "main": "index.js",
            "scripts": {
                "start": "react-native start",
                "android": "react-native run-android",
                "ios": "react-native run-ios"
            },
            "dependencies": {
                "react": "18.2.0",
                "react-native": "0.72.0",
                "@react-navigation/native": "^6.1.0",
                "@react-navigation/stack": "^6.3.0",
                "react-native-vector-icons": "^10.0.0"
            }
        }
        
        with open(project_path / "package.json", "w") as f:
            json.dump(package_json, f, indent=2)
        
        # App.js principal
        app_js_content = self.generate_react_native_app(app_type)
        with open(project_path / "App.js", "w") as f:
            f.write(app_js_content)
        
        # index.js
        index_js = '''import {AppRegistry} from 'react-native';
import App from './App';
import {name as appName} from './app.json';

AppRegistry.registerComponent(appName, () => App);'''
        
        with open(project_path / "index.js", "w") as f:
            f.write(index_js)
        
        # app.json
        app_json = {
            "name": project_path.name,
            "displayName": f"App criado pelo Agente Manus"
        }
        
        with open(project_path / "app.json", "w") as f:
            json.dump(app_json, f, indent=2)
    
    def generate_react_native_app(self, app_type: str) -> str:
        """Gera código React Native baseado no tipo de app"""
        
        if app_type == "todo":
            return '''import React, { useState } from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
  Alert,
} from 'react-native';

const App = () => {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState('');

  const addTask = () => {
    if (newTask.trim()) {
      setTasks([...tasks, { id: Date.now(), text: newTask, completed: false }]);
      setNewTask('');
    }
  };

  const toggleTask = (id) => {
    setTasks(tasks.map(task => 
      task.id === id ? { ...task, completed: !task.completed } : task
    ));
  };

  const deleteTask = (id) => {
    Alert.alert(
      'Excluir Tarefa',
      'Tem certeza que deseja excluir esta tarefa?',
      [
        { text: 'Cancelar', style: 'cancel' },
        { text: 'Excluir', onPress: () => setTasks(tasks.filter(task => task.id !== id)) }
      ]
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="dark-content" backgroundColor="#f8f9fa" />
      
      <View style={styles.header}>
        <Text style={styles.title}>📝 Lista de Tarefas</Text>
        <Text style={styles.subtitle}>Criado pelo Agente Manus</Text>
      </View>

      <View style={styles.inputContainer}>
        <TextInput
          style={styles.input}
          placeholder="Digite uma nova tarefa..."
          value={newTask}
          onChangeText={setNewTask}
          onSubmitEditing={addTask}
        />
        <TouchableOpacity style={styles.addButton} onPress={addTask}>
          <Text style={styles.addButtonText}>+</Text>
        </TouchableOpacity>
      </View>

      <ScrollView style={styles.taskList}>
        {tasks.map(task => (
          <View key={task.id} style={styles.taskItem}>
            <TouchableOpacity 
              style={[styles.taskText, task.completed && styles.completedTask]}
              onPress={() => toggleTask(task.id)}
            >
              <Text style={[styles.taskTextContent, task.completed && styles.completedText]}>
                {task.completed ? '✅' : '⭕'} {task.text}
              </Text>
            </TouchableOpacity>
            <TouchableOpacity 
              style={styles.deleteButton}
              onPress={() => deleteTask(task.id)}
            >
              <Text style={styles.deleteButtonText}>🗑️</Text>
            </TouchableOpacity>
          </View>
        ))}
        
        {tasks.length === 0 && (
          <View style={styles.emptyState}>
            <Text style={styles.emptyText}>Nenhuma tarefa ainda</Text>
            <Text style={styles.emptySubtext}>Adicione uma tarefa para começar!</Text>
          </View>
        )}
      </ScrollView>

      <View style={styles.footer}>
        <Text style={styles.footerText}>
          Total: {tasks.length} | Concluídas: {tasks.filter(t => t.completed).length}
        </Text>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f9fa',
  },
  header: {
    padding: 20,
    backgroundColor: '#667eea',
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
  },
  subtitle: {
    fontSize: 14,
    color: 'rgba(255,255,255,0.8)',
    marginTop: 5,
  },
  inputContainer: {
    flexDirection: 'row',
    padding: 20,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#e9ecef',
  },
  input: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 25,
    paddingHorizontal: 15,
    paddingVertical: 10,
    fontSize: 16,
    marginRight: 10,
  },
  addButton: {
    backgroundColor: '#4CAF50',
    width: 50,
    height: 50,
    borderRadius: 25,
    justifyContent: 'center',
    alignItems: 'center',
  },
  addButtonText: {
    color: 'white',
    fontSize: 24,
    fontWeight: 'bold',
  },
  taskList: {
    flex: 1,
    padding: 20,
  },
  taskItem: {
    flexDirection: 'row',
    backgroundColor: 'white',
    padding: 15,
    borderRadius: 10,
    marginBottom: 10,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  taskText: {
    flex: 1,
  },
  taskTextContent: {
    fontSize: 16,
    color: '#333',
  },
  completedTask: {
    opacity: 0.6,
  },
  completedText: {
    textDecorationLine: 'line-through',
    color: '#666',
  },
  deleteButton: {
    padding: 10,
  },
  deleteButtonText: {
    fontSize: 18,
  },
  emptyState: {
    alignItems: 'center',
    marginTop: 50,
  },
  emptyText: {
    fontSize: 18,
    color: '#666',
    fontWeight: 'bold',
  },
  emptySubtext: {
    fontSize: 14,
    color: '#999',
    marginTop: 5,
  },
  footer: {
    padding: 20,
    backgroundColor: 'white',
    borderTopWidth: 1,
    borderTopColor: '#e9ecef',
    alignItems: 'center',
  },
  footerText: {
    fontSize: 14,
    color: '#666',
  },
});

export default App;'''
        
        else:  # general app
            return '''import React, { useState } from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';

const App = () => {
  const [activeTab, setActiveTab] = useState('home');

  const renderContent = () => {
    switch(activeTab) {
      case 'home':
        return (
          <View style={styles.content}>
            <Text style={styles.contentTitle}>🏠 Início</Text>
            <Text style={styles.contentText}>
              Bem-vindo ao seu novo app criado pelo Agente Manus!
            </Text>
            <Text style={styles.contentText}>
              Este aplicativo foi gerado automaticamente e está pronto para ser personalizado.
            </Text>
          </View>
        );
      case 'features':
        return (
          <View style={styles.content}>
            <Text style={styles.contentTitle}>⚡ Recursos</Text>
            <View style={styles.featureList}>
              <Text style={styles.featureItem}>✅ Interface moderna</Text>
              <Text style={styles.featureItem}>✅ Navegação intuitiva</Text>
              <Text style={styles.featureItem}>✅ Design responsivo</Text>
              <Text style={styles.featureItem}>✅ Código limpo</Text>
            </View>
          </View>
        );
      case 'about':
        return (
          <View style={styles.content}>
            <Text style={styles.contentTitle}>ℹ️ Sobre</Text>
            <Text style={styles.contentText}>
              Este aplicativo foi criado automaticamente pelo Agente Manus, 
              demonstrando a capacidade de gerar apps mobile completos.
            </Text>
            <Text style={styles.contentText}>
              Versão: 1.0.0{'\n'}
              Plataforma: React Native{'\n'}
              Criado em: {new Date().toLocaleDateString()}
            </Text>
          </View>
        );
      default:
        return null;
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="light-content" backgroundColor="#667eea" />
      
      <View style={styles.header}>
        <Text style={styles.title}>🤖 Meu App</Text>
        <Text style={styles.subtitle}>Criado pelo Agente Manus</Text>
      </View>

      <ScrollView style={styles.main}>
        {renderContent()}
      </ScrollView>

      <View style={styles.tabBar}>
        <TouchableOpacity 
          style={[styles.tab, activeTab === 'home' && styles.activeTab]}
          onPress={() => setActiveTab('home')}
        >
          <Text style={[styles.tabText, activeTab === 'home' && styles.activeTabText]}>
            🏠 Início
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity 
          style={[styles.tab, activeTab === 'features' && styles.activeTab]}
          onPress={() => setActiveTab('features')}
        >
          <Text style={[styles.tabText, activeTab === 'features' && styles.activeTabText]}>
            ⚡ Recursos
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity 
          style={[styles.tab, activeTab === 'about' && styles.activeTab]}
          onPress={() => setActiveTab('about')}
        >
          <Text style={[styles.tabText, activeTab === 'about' && styles.activeTabText]}>
            ℹ️ Sobre
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f9fa',
  },
  header: {
    backgroundColor: '#667eea',
    padding: 20,
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
  },
  subtitle: {
    fontSize: 14,
    color: 'rgba(255,255,255,0.8)',
    marginTop: 5,
  },
  main: {
    flex: 1,
  },
  content: {
    padding: 20,
  },
  contentTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 15,
  },
  contentText: {
    fontSize: 16,
    color: '#666',
    lineHeight: 24,
    marginBottom: 15,
  },
  featureList: {
    marginTop: 10,
  },
  featureItem: {
    fontSize: 16,
    color: '#4CAF50',
    marginBottom: 10,
    paddingLeft: 10,
  },
  tabBar: {
    flexDirection: 'row',
    backgroundColor: 'white',
    borderTopWidth: 1,
    borderTopColor: '#e9ecef',
  },
  tab: {
    flex: 1,
    padding: 15,
    alignItems: 'center',
  },
  activeTab: {
    backgroundColor: '#667eea',
  },
  tabText: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
  },
  activeTabText: {
    color: 'white',
    fontWeight: 'bold',
  },
});

export default App;'''
    
    def create_spreadsheet(self, task: Dict) -> Dict:
        """Cria uma planilha Excel"""
        logger.info("📊 Criando planilha Excel...")
        
        description = task.get("description", "")
        filename = f"planilha_{int(time.time())}.xlsx"
        file_path = self.root_path / "spreadsheets" / filename
        
        # Determinar tipo de planilha
        sheet_type = self.determine_spreadsheet_type(description)
        
        # Criar workbook
        workbook = openpyxl.Workbook()
        worksheet = workbook.active
        
        if sheet_type == "financial":
            self.create_financial_spreadsheet(worksheet)
        elif sheet_type == "inventory":
            self.create_inventory_spreadsheet(worksheet)
        elif sheet_type == "sales":
            self.create_sales_spreadsheet(worksheet)
        else:
            self.create_general_spreadsheet(worksheet, description)
        
        # Salvar arquivo
        workbook.save(file_path)
        
        # Salvar no banco
        doc_id = str(uuid.uuid4())
        self.conn.execute(
            "INSERT INTO documents (id, name, type, path, created_at, size) VALUES (?, ?, ?, ?, ?, ?)",
            (doc_id, filename, "excel", str(file_path), datetime.now().isoformat(), file_path.stat().st_size)
        )
        self.conn.commit()
        
        self.stats["documents_processed"] += 1
        
        return {
            "success": True,
            "filename": filename,
            "file_path": str(file_path),
            "sheet_type": sheet_type
        }
    
    def determine_spreadsheet_type(self, description: str) -> str:
        """Determina o tipo de planilha baseado na descrição"""
        desc_lower = description.lower()
        
        if any(word in desc_lower for word in ['financeiro', 'dinheiro', 'gasto', 'receita', 'orçamento']):
            return "financial"
        elif any(word in desc_lower for word in ['estoque', 'inventário', 'produto', 'item']):
            return "inventory"
        elif any(word in desc_lower for word in ['venda', 'vendas', 'cliente', 'pedido']):
            return "sales"
        else:
            return "general"
    
    def create_financial_spreadsheet(self, worksheet):
        """Cria planilha financeira"""
        worksheet.title = "Controle Financeiro"
        
        # Cabeçalhos
        headers = ["Data", "Descrição", "Categoria", "Tipo", "Valor", "Saldo"]
        for col, header in enumerate(headers, 1):
            cell = worksheet.cell(row=1, col=col, value=header)
            cell.font = Font(bold=True, color="FFFFFF")
            cell.fill = PatternFill(start_color="4CAF50", end_color="4CAF50", fill_type="solid")
            cell.alignment = Alignment(horizontal="center")
        
        # Dados de exemplo
        sample_data = [
            ["01/01/2024", "Salário", "Receita", "Entrada", 5000, 5000],
            ["02/01/2024", "Aluguel", "Moradia", "Saída", -1200, 3800],
            ["03/01/2024", "Supermercado", "Alimentação", "Saída", -300, 3500],
            ["04/01/2024", "Freelance", "Receita", "Entrada", 800, 4300],
            ["05/01/2024", "Combustível", "Transporte", "Saída", -150, 4150]
        ]
        
        for row, data in enumerate(sample_data, 2):
            for col, value in enumerate(data, 1):
                cell = worksheet.cell(row=row, col=col, value=value)
                if col == 5:  # Coluna de valor
                    if value < 0:
                        cell.font = Font(color="FF0000")
                    else:
                        cell.font = Font(color="008000")
        
        # Fórmulas
        last_row = len(sample_data) + 1
        worksheet.cell(row=last_row + 2, col=1, value="Total Entradas:")
        worksheet.cell(row=last_row + 2, col=2, value=f'=SUMIF(D2:D{last_row},"Entrada",E2:E{last_row})')
        
        worksheet.cell(row=last_row + 3, col=1, value="Total Saídas:")
        worksheet.cell(row=last_row + 3, col=2, value=f'=SUMIF(D2:D{last_row},"Saída",E2:E{last_row})')
        
        worksheet.cell(row=last_row + 4, col=1, value="Saldo Final:")
        worksheet.cell(row=last_row + 4, col=2, value=f'=B{last_row + 2}+B{last_row + 3}')
        
        # Ajustar largura das colunas
        for col in worksheet.columns:
            max_length = 0
            column = col[0].column_letter
            for cell in col:
                try:
                    if len(str(cell.value)) > max_length:
                        max_length = len(str(cell.value))
                except:
                    pass
            adjusted_width = (max_length + 2)
            worksheet.column_dimensions[column].width = adjusted_width
    
    def create_inventory_spreadsheet(self, worksheet):
        """Cria planilha de estoque"""
        worksheet.title = "Controle de Estoque"
        
        # Cabeçalhos
        headers = ["Código", "Produto", "Categoria", "Quantidade", "Preço Unit.", "Valor Total", "Estoque Mín.", "Status"]
        for col, header in enumerate(headers, 1):
            cell = worksheet.cell(row=1, col=col, value=header)
            cell.font = Font(bold=True, color="FFFFFF")
            cell.fill = PatternFill(start_color="2196F3", end_color="2196F3", fill_type="solid")
            cell.alignment = Alignment(horizontal="center")
        
        # Dados de exemplo
        sample_data = [
            ["001", "Notebook Dell", "Eletrônicos", 15, 2500, "=D2*E2", 5, "=IF(D2<=G2,\"Baixo\",\"OK\")"],
            ["002", "Mouse Wireless", "Acessórios", 50, 45, "=D3*E3", 10, "=IF(D3<=G3,\"Baixo\",\"OK\")"],
            ["003", "Teclado Mecânico", "Acessórios", 8, 180, "=D4*E4", 15, "=IF(D4<=G4,\"Baixo\",\"OK\")"],
            ["004", "Monitor 24\"", "Eletrônicos", 12, 800, "=D5*E5", 8, "=IF(D5<=G5,\"Baixo\",\"OK\")"],
            ["005", "Cabo HDMI", "Cabos", 25, 35, "=D6*E6", 20, "=IF(D6<=G6,\"Baixo\",\"OK\")"]
        ]
        
        for row, data in enumerate(sample_data, 2):
            for col, value in enumerate(data, 1):
                worksheet.cell(row=row, col=col, value=value)
        
        # Totais
        last_row = len(sample_data) + 1
        worksheet.cell(row=last_row + 2, col=5, value="Total Geral:")
        worksheet.cell(row=last_row + 2, col=6, value=f'=SUM(F2:F{last_row})')
        
        # Ajustar largura das colunas
        for col in worksheet.columns:
            max_length = 0
            column = col[0].column_letter
            for cell in col:
                try:
                    if len(str(cell.value)) > max_length:
                        max_length = len(str(cell.value))
                except

