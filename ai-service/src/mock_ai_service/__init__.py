"""Deterministic mock of the FastAPI AI microservice (Python port)."""

from .app import create_app
from .config import Settings

__all__ = ["Settings", "create_app"]
__version__ = "1.0.0"
