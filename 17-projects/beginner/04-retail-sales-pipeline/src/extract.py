from __future__ import annotations

import logging
from pathlib import Path

import pandas as pd


REQUIRED_FILES = {
    "sales": "sales.csv",
    "products": "products.csv",
    "customers": "customers.csv",
    "inventory": "inventory.csv",
}


def read_csv_file(path: Path) -> pd.DataFrame:
    """Read one CSV file after validating that it exists."""
    if not path.exists():
        raise FileNotFoundError(f"Required input file not found: {path}")
    if not path.is_file():
        raise ValueError(f"Expected a file but found something else: {path}")

    logging.info("Reading %s", path)
    dataframe = pd.read_csv(path)
    logging.info("Read %s rows from %s", len(dataframe), path.name)
    return dataframe


def extract_all(data_dir: Path) -> dict[str, pd.DataFrame]:
    """Extract all required retail CSV files."""
    extracted: dict[str, pd.DataFrame] = {}
    for dataset_name, filename in REQUIRED_FILES.items():
        extracted[dataset_name] = read_csv_file(data_dir / filename)
    return extracted
