# syntax=docker/dockerfile:1.7
ARG PYTHON_VERSION=3.12

# --- build: install into an isolated venv ---
FROM python:${PYTHON_VERSION}-slim AS build
ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1
WORKDIR /src
RUN python -m venv /opt/venv
COPY pyproject.toml README.md ./
COPY src ./src
RUN /opt/venv/bin/pip install .

# --- runtime ---
FROM python:${PYTHON_VERSION}-slim AS runtime
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH" \
    PORT=9000

RUN useradd --system --no-create-home --uid 10001 app
COPY --from=build /opt/venv /opt/venv
WORKDIR /app
USER app

EXPOSE 9000

HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 \
  CMD ["python", "-c", "import os, urllib.request as u; u.urlopen('http://127.0.0.1:%s/health' % os.environ['PORT'], timeout=2)"]

CMD ["python", "-m", "mock_ai_service"]