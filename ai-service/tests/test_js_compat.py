"""Unit tests for the JS-semantics helpers.

Expected values below were produced by running the equivalent expressions in
Node (``String(x)``, ``Number(x)``, the original ``hashCode``).
"""

from __future__ import annotations

import math
from typing import Any

import pytest

from mock_ai_service.js_compat import (
    clamp,
    entries,
    hash_code,
    js_round,
    number_or_zero,
    str_or,
    to_number,
    to_str,
    truthy,
    utf16_length,
)


@pytest.mark.parametrize(
    ("value", "expected"),
    [
        (None, False), (False, False), (True, True), (0, False), (1, True), (0.0, False),
        (math.nan, False), (-1.5, True), ("", False), ("0", True), ([], True), ({}, True),
    ],
)  # fmt: skip
def test_truthy(value: Any, expected: bool) -> None:
    assert truthy(value) is expected


@pytest.mark.parametrize(
    ("value", "expected"),
    [
        (0.1, "0.1"), (0.5, "0.5"), (100.0, "100"), (-2.5, "-2.5"), (12345.678, "12345.678"),
        (1e20, "100000000000000000000"), (1e21, "1e+21"), (1.5e21, "1.5e+21"),
        (1e-6, "0.000001"), (1e-7, "1e-7"), (1.5e-7, "1.5e-7"), (-1e-7, "-1e-7"),
        (0.000001234, "0.000001234"), (123456789012345680000.0, "123456789012345680000"),
        (1.7976931348623157e308, "1.7976931348623157e+308"), (5e-324, "5e-324"),
        (2.0**53, "9007199254740992"), (0.30000000000000004, "0.30000000000000004"),
        (1234567890123456789012.0, "1.2345678901234568e+21"), (-0.0, "0"),
        (math.nan, "NaN"), (math.inf, "Infinity"), (-math.inf, "-Infinity"),
    ],
)  # fmt: skip
def test_to_str_numbers(value: float, expected: str) -> None:
    assert to_str(value) == expected


@pytest.mark.parametrize(
    ("value", "expected"),
    [
        (None, "null"), (True, "true"), (False, "false"), (7, "7"), ("x", "x"),
        ([], ""), ([1, None, "a", [2, 3]], "1,,a,2,3"), ({"a": 1}, "[object Object]"),
    ],
)  # fmt: skip
def test_to_str_other_types(value: Any, expected: str) -> None:
    assert to_str(value) == expected


def test_str_or_uses_default_only_for_falsy_values() -> None:
    assert str_or("", "d") == "d"
    assert str_or(0, "d") == "d"
    assert str_or(None, "d") == "d"
    assert str_or("x", "d") == "x"
    assert str_or([], "d") == ""  # empty array is truthy and stringifies to ""
    assert str_or(5, "d") == "5"


@pytest.mark.parametrize(
    ("value", "expected"),
    [
        ("", 0), (" ", 0), ("  42  ", 42), ("0x1F", 31), ("0X1f", 31), ("0b11", 3), ("0o17", 15),
        ("1e3", 1000), (".5", 0.5), ("5.", 5), ("-.5e-2", -0.005), ("\t7\n", 7),
        ("Infinity", math.inf), ("+Infinity", math.inf), ("-Infinity", -math.inf),
        (None, 0), (True, 1), (False, 0), (3, 3), (2.5, 2.5), ([], 0), ([3], 3),
    ],
)  # fmt: skip
def test_to_number_valid(value: Any, expected: float) -> None:
    assert to_number(value) == expected


@pytest.mark.parametrize(
    "value",
    ["infinity", "nan", "1_000", "1,5", "abc", "12px", "--1", "0x", {}, {"a": 1}, [1, 2]],
)
def test_to_number_nan(value: Any) -> None:
    assert math.isnan(to_number(value))


def test_number_or_zero_collapses_nan() -> None:
    assert number_or_zero("abc") == 0
    assert number_or_zero(None) == 0
    assert number_or_zero("0.9") == 0.9


def test_js_round_rounds_halves_up_unlike_python_round() -> None:
    assert [js_round(x) for x in (0.5, 1.5, 2.5, 3.5)] == [1, 2, 3, 4]
    assert [round(x) for x in (0.5, 1.5, 2.5, 3.5)] == [0, 2, 2, 4]  # why js_round exists
    assert js_round(-2.5) == -2
    assert js_round(2.4) == 2


def test_clamp_bounds_and_returns_int() -> None:
    assert clamp(-5, 0, 10) == 0
    assert clamp(50, 0, 10) == 10
    assert clamp(7, 0, 10) == 7
    assert isinstance(clamp(7.0, 0, 10), int)


def test_utf16_length_counts_code_units() -> None:
    assert utf16_length("") == 0
    assert utf16_length("abc") == 3
    assert utf16_length("\U0001f600") == 2  # astral char = surrogate pair
    assert utf16_length("caf\u00e9") == 4
    assert utf16_length("\ud83d") == 1  # lone surrogate survives


@pytest.mark.parametrize(
    ("text", "expected"),
    [
        ("", 0), ("a", 97), ("hello", 99162322), ("Explain closures", 417186497),
        ("The quick brown fox jumps over the lazy dog", 609428141),
        ("\U0001f600", 1772899), ("caf\u00e9", 3045921), ("\ud83d", 55357),
        ("z" * 100, 921283200),
    ],
)  # fmt: skip
def test_hash_code_matches_node(text: str, expected: int) -> None:
    assert hash_code(text) == expected


def test_hash_code_is_never_negative_and_handles_int32_overflow() -> None:
    assert hash_code("x" * 5000) >= 0
    assert hash_code("polygenelubricants") == 2**31  # classic Math.abs(int32 min)


def test_entries_orders_integer_keys_first_like_object_entries() -> None:
    value = {"zeta": 1, "10": 2, "2": 3, "alpha": 4, "03": 5, "-1": 6}
    assert [key for key, _ in entries(value)] == ["2", "10", "zeta", "alpha", "03", "-1"]


def test_entries_of_arrays_and_scalars() -> None:
    assert entries([90, 10]) == [("0", 90), ("1", 10)]
    assert entries("ab") == [("0", "a"), ("1", "b")]
    assert entries("\U0001f600") == [("0", "\ud83d"), ("1", "\ude00")]  # surrogate pair = 2 units
    assert entries("") == []
    assert entries(5) == []
    assert entries(None) == []
    assert entries({}) == []
