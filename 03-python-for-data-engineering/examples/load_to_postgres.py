from __future__ import annotations

import logging
import os
from urllib.parse import quote_plus

import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import Engine


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)


REQUIRED_ENV_VARS = [
    "POSTGRES_HOST",
    "POSTGRES_PORT",
    "POSTGRES_DB",
    "POSTGRES_USER",
    "POSTGRES_PASSWORD",
]


def get_required_env(name: str) -> str:
    value = os.getenv(name)
    if not value:
        raise EnvironmentError(f"Missing required environment variable: {name}")
    return value


def build_postgres_engine() -> Engine:
    host = get_required_env("POSTGRES_HOST")
    port = get_required_env("POSTGRES_PORT")
    database = get_required_env("POSTGRES_DB")
    user = get_required_env("POSTGRES_USER")
    password = quote_plus(get_required_env("POSTGRES_PASSWORD"))

    connection_url = (
        f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}"
    )
    return create_engine(connection_url)


def create_sample_dataframe() -> pd.DataFrame:
    return pd.DataFrame(
        [
            {
                "product_id": "P-100",
                "product_name": "Premium Rice 25kg",
                "category": "Grocery",
                "quantity_on_hand": 18,
            },
            {
                "product_id": "P-200",
                "product_name": "Cooking Oil 5L",
                "category": "Grocery",
                "quantity_on_hand": 7,
            },
        ]
    )


def load_dataframe_to_postgres(
    dataframe: pd.DataFrame,
    table_name: str,
    engine: Engine,
) -> None:
    if dataframe.empty:
        raise ValueError("Refusing to load an empty DataFrame")

    logging.info("Loading %s rows into table %s", len(dataframe), table_name)
    dataframe.to_sql(
        table_name,
        con=engine,
        if_exists="replace",
        index=False,
        method="multi",
    )
    logging.info("Finished loading table %s", table_name)


def main() -> None:
    for env_var in REQUIRED_ENV_VARS:
        get_required_env(env_var)

    engine = build_postgres_engine()
    dataframe = create_sample_dataframe()
    load_dataframe_to_postgres(dataframe, "sample_inventory_load", engine)


if __name__ == "__main__":
    main()
