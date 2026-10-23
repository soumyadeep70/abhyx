"""``python -m mock_ai_service`` -- run the server."""

from __future__ import annotations

import os

import uvicorn

from .app import create_app


def main() -> None:
    port = int(os.environ.get("PORT", "9000"))
    host = os.environ.get("HOST", "0.0.0.0")
    print(f"mock-ai-service listening on http://localhost:{port}", flush=True)
    uvicorn.run(create_app(), host=host, port=port, log_level="info")


if __name__ == "__main__":  # pragma: no cover
    main()
