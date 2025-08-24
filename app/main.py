from fastapi import FastAPI
import socket, platform, time

app = FastAPI(title="Agente Manus Docker")

@app.get("/")
def root():
    return {"message": "Agente Manus Docker up", "docs": "/docs"}

@app.get("/health")
def health():
    return {
        "ok": True,
        "ts": time.time(),
        "host": socket.gethostname(),
        "platform": platform.platform(),
    }
