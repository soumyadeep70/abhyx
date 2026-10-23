"""Small helpers that reproduce the JavaScript semantics the original Node
mock relied on (``String()``, ``Number()``, truthiness, ``Math.round``,
UTF-16 ``length``, ``Object.entries`` ordering and its 32-bit ``hashCode``).

Keeping these in one place means the handlers read like the original code
while the quirks stay isolated, documented and unit-tested.
"""

from __future__ import annotations

import math
import re
import struct
from collections.abc import Mapping
from decimal import Decimal
from typing import Any, cast

_DECIMAL_RE = re.compile(r"[+-]?(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?")
_RADIX_RE = re.compile(r"0(?:[xX][0-9a-fA-F]+|[oO][0-7]+|[bB][01]+)")
_RADIX_BASE = {"x": 16, "o": 8, "b": 2}
_ARRAY_INDEX_RE = re.compile(r"0|[1-9]\d*")
_MAX_ARRAY_INDEX = 2**32 - 2


def truthy(value: Any) -> bool:
    """JavaScript truthiness (``[]`` and ``{}`` are truthy, ``NaN`` is falsy)."""
    if isinstance(value, float):
        return value != 0.0 and not math.isnan(value)
    if isinstance(value, (list, dict)):
        return True
    return bool(value)


def to_str(value: Any) -> str:
    """``String(value)`` for JSON-derived values."""
    if value is None:
        return "null"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float):
        return _number_to_str(value)
    if isinstance(value, list):
        # Array.prototype.toString -> join(","), null renders as "".
        return ",".join("" if item is None else to_str(item) for item in value)
    if isinstance(value, dict):
        return "[object Object]"
    return str(value)


def _number_to_str(value: float) -> str:
    """ECMAScript ``Number::toString`` (shortest round-trip digits, JS exponent rules)."""
    if math.isnan(value):
        return "NaN"
    if math.isinf(value):
        return "Infinity" if value > 0 else "-Infinity"
    if value == 0:
        return "0"

    sign = "-" if value < 0 else ""
    _, raw_digits, raw_exponent = Decimal(repr(abs(value))).as_tuple()
    exponent = cast(int, raw_exponent)  # finite, so never 'n' / 'N' / 'F'
    digits = "".join(map(str, raw_digits)).rstrip("0")
    exponent += len(raw_digits) - len(digits)  # trailing zeros moved into the exponent
    k = len(digits)
    n = k + exponent  # value == 0.<digits> * 10**n

    if k <= n <= 21:
        body = digits + "0" * (n - k)
    elif 0 < n <= 21:
        body = f"{digits[:n]}.{digits[n:]}"
    elif -6 < n <= 0:
        body = f"0.{'0' * -n}{digits}"
    else:
        power = n - 1
        mantissa = digits[0] + (f".{digits[1:]}" if k > 1 else "")
        body = f"{mantissa}e{'+' if power >= 0 else '-'}{abs(power)}"
    return sign + body


def str_or(value: Any, default: str) -> str:
    """``String(value || default)`` / ``${value || default}``."""
    return to_str(value) if truthy(value) else default


def to_number(value: Any) -> float:
    """``Number(value)`` for JSON-derived values (``nan`` on failure)."""
    if value is None:
        return 0.0
    if isinstance(value, bool):
        return 1.0 if value else 0.0
    if isinstance(value, (int, float)):
        return float(value)
    if isinstance(value, (list, dict)):
        return math.nan if isinstance(value, dict) else to_number(to_str(value))
    text = str(value).strip()
    if text == "":
        return 0.0
    if text in ("Infinity", "+Infinity"):
        return math.inf
    if text == "-Infinity":
        return -math.inf
    if _RADIX_RE.fullmatch(text):
        return float(int(text[2:], _RADIX_BASE[text[1].lower()]))
    if _DECIMAL_RE.fullmatch(text):
        return float(text)
    return math.nan


def number_or_zero(value: Any) -> float:
    """``Number(value) || 0`` -- NaN collapses to 0."""
    number = to_number(value)
    return number if truthy(number) else 0.0


def js_round(value: float) -> int:
    """``Math.round``: halves round towards +infinity (Python's ``round`` is
    banker's rounding)."""
    return math.floor(value + 0.5)


def clamp(value: float, minimum: float, maximum: float) -> int:
    return int(max(minimum, min(maximum, value)))


def utf16_length(text: str) -> int:
    """``String.prototype.length`` counts UTF-16 code units, not code points."""
    return len(text.encode("utf-16-le", "surrogatepass")) // 2


def hash_code(text: str) -> int:
    """Java/JS-style 32-bit string hash, returned as ``Math.abs(hash)``."""
    data = text.encode("utf-16-le", "surrogatepass")
    h = 0
    for (unit,) in struct.iter_unpack("<H", data):
        h = ((h << 5) - h + unit) & 0xFFFFFFFF
    if h >= 0x80000000:  # reinterpret as signed int32
        h -= 0x100000000
    return abs(h)


def entries(value: Any) -> list[tuple[str, Any]]:
    """``Object.entries`` for JSON values: objects use integer-like keys
    ascending first, then the remaining keys in insertion order; arrays yield
    ``("0", item0), ("1", item1), ...``; strings yield their UTF-16 code units
    the same way; anything else has no entries."""
    if isinstance(value, list):
        return [(str(index), item) for index, item in enumerate(value)]
    if isinstance(value, str):  # one entry per UTF-16 code unit
        data = value.encode("utf-16-le", "surrogatepass")
        return [
            (str(index), data[2 * index : 2 * index + 2].decode("utf-16-le", "surrogatepass"))
            for index in range(len(data) // 2)
        ]
    if not isinstance(value, dict):
        return []
    mapping: Mapping[str, Any] = value
    indexed: list[tuple[int, str]] = []
    others: list[str] = []
    for key in mapping:
        if _ARRAY_INDEX_RE.fullmatch(key) and int(key) <= _MAX_ARRAY_INDEX:
            indexed.append((int(key), key))
        else:
            others.append(key)
    ordered = [key for _, key in sorted(indexed)] + others
    return [(key, mapping[key]) for key in ordered]
