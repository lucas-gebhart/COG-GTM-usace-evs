FROM python:3.12-slim AS base
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 UV_SYSTEM_PYTHON=1
RUN pip install --no-cache-dir uv
WORKDIR /app
COPY apps/api/pyproject.toml apps/api/README.md ./
RUN uv pip install --no-cache -e . 2>/dev/null || true
COPY apps/api/ ./
COPY db/ /db/
COPY legacy/data_samples/ /legacy/data_samples/
RUN uv pip install --no-cache -e .
EXPOSE 8000
CMD ["uvicorn", "evs.main:app", "--host", "0.0.0.0", "--port", "8000"]
