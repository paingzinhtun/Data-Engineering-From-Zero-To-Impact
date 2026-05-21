from __future__ import annotations

import argparse
import logging
from pathlib import Path

import pandas as pd


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)


def read_csv_file(file_path: Path) -> pd.DataFrame:
    """Read a CSV file after validating that it exists."""
    if not file_path.exists():
        raise FileNotFoundError(f"CSV file not found: {file_path}")

    if not file_path.is_file():
        raise ValueError(f"Path is not a file: {file_path}")

    logging.info("Reading CSV file: %s", file_path)
    dataframe = pd.read_csv(file_path)
    logging.info("Read %s rows and %s columns", len(dataframe), len(dataframe.columns))
    return dataframe


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Read a CSV file and log row count.")
    parser.add_argument("csv_path", type=Path, help="Path to the CSV file.")
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    read_csv_file(args.csv_path)


if __name__ == "__main__":
    main()
