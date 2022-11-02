FROM python:3.8-slim AS base

WORKDIR /app

EXPOSE 8000

COPY pyproject.toml .
RUN pip install poetry

FROM base AS dependencies
RUN poetry install --only main

FROM base AS development
RUN poetry install
COPY . .

FROM dependencies AS production
COPY app app
COPY alembic /app/alembic
COPY run.py .
COPY settings.toml .
COPY alembic.ini .
