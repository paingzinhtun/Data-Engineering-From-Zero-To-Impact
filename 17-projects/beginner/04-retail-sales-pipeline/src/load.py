from __future__ import annotations

import logging
import os
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text
from sqlalchemy.engine import Engine, URL


def get_required_env(name: str) -> str:
    value = os.getenv(name)
    if not value:
        raise EnvironmentError(f"Missing required environment variable: {name}")
    return value


def create_postgres_engine() -> Engine:
    url = URL.create(
        drivername="postgresql+psycopg2",
        username=get_required_env("POSTGRES_USER"),
        password=get_required_env("POSTGRES_PASSWORD"),
        host=get_required_env("POSTGRES_HOST"),
        port=int(get_required_env("POSTGRES_PORT")),
        database=get_required_env("POSTGRES_DB"),
    )
    return create_engine(url)


def execute_sql_file(engine: Engine, sql_path: Path) -> None:
    logging.info("Executing SQL file: %s", sql_path)
    sql_text = sql_path.read_text(encoding="utf-8")
    statements = [statement.strip() for statement in sql_text.split(";") if statement.strip()]

    with engine.begin() as connection:
        for statement in statements:
            connection.execute(text(statement))


def load_raw_tables(engine: Engine, tables: dict[str, pd.DataFrame]) -> None:
    with engine.begin() as connection:
        connection.execute(text("CREATE SCHEMA IF NOT EXISTS raw;"))

    for table_name, dataframe in tables.items():
        if dataframe.empty:
            raise ValueError(f"Refusing to load empty raw table: {table_name}")

        logging.info("Loading %s rows into raw.%s", len(dataframe), table_name)
        dataframe.to_sql(
            table_name,
            con=engine,
            schema="raw",
            if_exists="replace",
            index=False,
            method="multi",
        )


def run_quality_checks(engine: Engine, sql_path: Path) -> None:
    """Run quality checks and fail if any check returns rows."""
    logging.info("Running quality checks from %s", sql_path)
    sql_text = sql_path.read_text(encoding="utf-8")
    statements = [statement.strip() for statement in sql_text.split(";") if statement.strip()]

    with engine.connect() as connection:
        for index, statement in enumerate(statements, start=1):
            result = connection.execute(text(statement))
            rows = result.fetchall()
            if rows:
                raise ValueError(f"Quality check {index} failed with rows: {rows}")
            logging.info("Quality check %s passed", index)
