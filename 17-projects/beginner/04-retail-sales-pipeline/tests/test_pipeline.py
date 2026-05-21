from __future__ import annotations

import sys
from pathlib import Path

import pandas as pd
import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
SRC_DIR = PROJECT_ROOT / "src"
sys.path.insert(0, str(SRC_DIR))

from extract import extract_all  # noqa: E402
from transform import transform_all  # noqa: E402


def test_extract_all_reads_sample_files() -> None:
    data = extract_all(PROJECT_ROOT / "data" / "sample")

    assert set(data) == {"sales", "products", "customers", "inventory"}
    assert len(data["sales"]) == 10
    assert len(data["products"]) == 7


def test_transform_calculates_sales_metrics() -> None:
    data = extract_all(PROJECT_ROOT / "data" / "sample")
    transformed = transform_all(data)
    sales = transformed["sales"]

    first_row = sales.loc[sales["sale_line_id"] == "S-1001-1"].iloc[0]

    assert first_row["gross_sales"] == pytest.approx(12.00)
    assert first_row["net_sales"] == pytest.approx(12.00)
    assert first_row["cost_amount"] == pytest.approx(6.60)
    assert first_row["gross_profit"] == pytest.approx(5.40)


def test_transform_rejects_negative_quantity() -> None:
    data = extract_all(PROJECT_ROOT / "data" / "sample")
    data["sales"] = data["sales"].copy()
    data["sales"].loc[0, "quantity"] = -1

    with pytest.raises(ValueError, match="quantity"):
        transform_all(data)


def test_transform_rejects_missing_product_reference() -> None:
    data = extract_all(PROJECT_ROOT / "data" / "sample")
    data["sales"] = data["sales"].copy()
    data["sales"].loc[0, "product_id"] = "P-DOES-NOT-EXIST"

    with pytest.raises(ValueError, match="missing from products"):
        transform_all(data)


def test_transform_rejects_missing_customer_reference() -> None:
    data = extract_all(PROJECT_ROOT / "data" / "sample")
    data["sales"] = data["sales"].copy()
    data["sales"].loc[0, "customer_id"] = "C-DOES-NOT-EXIST"

    with pytest.raises(ValueError, match="missing from customers"):
        transform_all(data)


def test_transform_rejects_discount_above_gross_sales() -> None:
    data = extract_all(PROJECT_ROOT / "data" / "sample")
    data["sales"] = data["sales"].copy()
    data["sales"].loc[0, "discount_amount"] = 999

    with pytest.raises(ValueError, match="Net sales"):
        transform_all(data)


def test_required_sales_columns_are_validated() -> None:
    data = extract_all(PROJECT_ROOT / "data" / "sample")
    data["sales"] = data["sales"].drop(columns=["sale_line_id"])

    with pytest.raises(ValueError, match="missing required columns"):
        transform_all(data)
