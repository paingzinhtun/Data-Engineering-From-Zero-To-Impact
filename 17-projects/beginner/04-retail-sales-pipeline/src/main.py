from __future__ import annotations

import logging
import os
from pathlib import Path

from dotenv import load_dotenv

from extract import extract_all
from load import create_postgres_engine, execute_sql_file, load_raw_tables, run_quality_checks
from transform import transform_all


PROJECT_ROOT = Path(__file__).resolve().parents[1]


def configure_logging() -> None:
    log_level = os.getenv("LOG_LEVEL", "INFO").upper()
    logging.basicConfig(
        level=log_level,
        format="%(asctime)s %(levelname)s %(message)s",
    )


def project_path(value: str) -> Path:
    path = Path(value)
    if path.is_absolute():
        return path
    return PROJECT_ROOT / path


def main() -> None:
    load_dotenv(PROJECT_ROOT / ".env")
    configure_logging()

    data_dir = project_path(os.getenv("DATA_DIR", "data/sample"))
    sql_dir = project_path(os.getenv("SQL_DIR", "sql"))

    logging.info("Retail sales pipeline started")
    try:
        raw_data = extract_all(data_dir)
        transformed_data = transform_all(raw_data)

        engine = create_postgres_engine()
        execute_sql_file(engine, sql_dir / "create_tables.sql")
        load_raw_tables(engine, transformed_data)
        execute_sql_file(engine, sql_dir / "transformations.sql")
        run_quality_checks(engine, sql_dir / "quality_checks.sql")
    except Exception:
        logging.exception("Retail sales pipeline failed")
        raise

    logging.info("Retail sales pipeline finished successfully")


if __name__ == "__main__":
    main()
