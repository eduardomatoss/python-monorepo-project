from fastapi import FastAPI
from starlette_exporter import PrometheusMiddleware, handle_metrics
from dynaconf import settings

from app.routers import root
from app.routers import health_check

app = FastAPI(
    title=settings.get("application_name"),
    description=settings.get("application_description"),
    version="v0.1.0",
)

app.add_middleware(PrometheusMiddleware, app_name=settings.get("application_name"))
app.add_route("/metrics", handle_metrics)

app.include_router(root.router)
app.include_router(health_check.router)
