from __future__ import annotations

import logging
import os
from pathlib import Path

import pandas as pd


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)


def get_required_env(name: str) -> str:
    """Read a required environment variable.

    Environment variables keep configuration out of source code. Use them for
    paths, database names, credentials, API keys, and environment-specific
    settings.
    """
    value = os.getenv(name)
    if not value:
        raise EnvironmentError(f"Missing required environment variable: {name}")
    return value


def load_config() -> dict[str, str]:
    """Load pipeline configuration from environment variables."""
    return {
        "input_csv_path": get_required_env("INPUT_CSV_PATH"),
        "output_csv_path": get_required_env("OUTPUT_CSV_PATH"),
    }


def extract(input_csv_path: str) -> pd.DataFrame:
    """Extract data from the source system.

    This beginner template reads a CSV file. In real projects, extract steps may
    read from APIs, databases, object storage, message queues, or vendor exports.
    """
    file_path = Path(input_csv_path)
    if not file_path.exists():
        raise FileNotFoundError(f"Input file not found: {file_path}")

    logging.info("Extracting data from %s", file_path)
    dataframe = pd.read_csv(file_path)
    logging.info("Extracted %s rows", len(dataframe))
    return dataframe


def transform(dataframe: pd.DataFrame) -> pd.DataFrame:
    """Transform raw data into a cleaner shape for loading."""
    required_columns = {"product_id", "quantity", "unit_price"}
    missing_columns = required_columns - set(dataframe.columns)
    if missing_columns:
        raise ValueError(f"Missing required columns: {sorted(missing_columns)}")

    logging.info("Transforming data")
    transformed = dataframe.copy()
    transformed["revenue"] = transformed["quantity"] * transformed["unit_price"]
    transformed = transformed.drop_duplicates()
    logging.info("Transformed data has %s rows", len(transformed))
    return transformed


def load(dataframe: pd.DataFrame, output_csv_path: str) -> None:
    """Load transformed data into the target.

    This template writes a CSV file. In real projects, this function may load to
    PostgreSQL, a warehouse, cloud storage, or an analytics mart.
    """
    if dataframe.empty:
        raise ValueError("Refusing to load an empty DataFrame")

    output_path = Path(output_csv_path)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    logging.info("Loading %s rows to %s", len(dataframe), output_path)
    dataframe.to_csv(output_path, index=False)
    logging.info("Load complete")


def run_pipeline() -> None:
    """Run the ETL pipeline from extract through load."""
    config = load_config()
    raw_data = extract(config["input_csv_path"])
    transformed_data = transform(raw_data)
    load(transformed_data, config["output_csv_path"])


def main() -> None:
    logging.info("Pipeline started")
    try:
        run_pipeline()
    except Exception:
        logging.exception("Pipeline failed")
        raise
    logging.info("Pipeline finished successfully")


if __name__ == "__main__":
    main()
