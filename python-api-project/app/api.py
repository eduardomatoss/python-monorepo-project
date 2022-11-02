from fastapi import FastAPI

from app.routers import root
from app.routers import health_check

app = FastAPI(
    title="Python API Project",
    description="Python API Project",
    version="v0.1.0",
)

app.include_router(root.router)
app.include_router(health_check.router)
