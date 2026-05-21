from __future__ import annotations

import logging

import pandas as pd


REQUIRED_COLUMNS = {
    "sales": {
        "sale_id",
        "sale_line_id",
        "sale_date",
        "customer_id",
        "product_id",
        "quantity",
        "unit_price",
        "discount_amount",
    },
    "products": {
        "product_id",
        "product_name",
        "category",
        "unit_cost",
        "unit_price",
    },
    "customers": {"customer_id", "customer_name", "customer_segment", "city"},
    "inventory": {"product_id", "quantity_on_hand", "reorder_level", "snapshot_date"},
}


def normalize_columns(dataframe: pd.DataFrame) -> pd.DataFrame:
    result = dataframe.copy()
    result.columns = [column.strip().lower() for column in result.columns]
    return result


def validate_required_columns(
    dataframe: pd.DataFrame,
    required_columns: set[str],
    dataset_name: str,
) -> None:
    missing_columns = required_columns - set(dataframe.columns)
    if missing_columns:
        raise ValueError(
            f"{dataset_name} is missing required columns: {sorted(missing_columns)}"
        )


def clean_products(products: pd.DataFrame) -> pd.DataFrame:
    products = normalize_columns(products)
    validate_required_columns(products, REQUIRED_COLUMNS["products"], "products")

    products["product_id"] = products["product_id"].astype(str).str.strip()
    products["product_name"] = products["product_name"].astype(str).str.strip()
    products["category"] = products["category"].astype(str).str.strip()
    products["unit_cost"] = pd.to_numeric(products["unit_cost"], errors="raise")
    products["unit_price"] = pd.to_numeric(products["unit_price"], errors="raise")

    if (products["unit_cost"] < 0).any() or (products["unit_price"] < 0).any():
        raise ValueError("Product costs and prices must be non-negative")
    if products["product_id"].duplicated().any():
        raise ValueError("Product IDs must be unique")

    return products


def clean_customers(customers: pd.DataFrame) -> pd.DataFrame:
    customers = normalize_columns(customers)
    validate_required_columns(customers, REQUIRED_COLUMNS["customers"], "customers")

    for column in ["customer_id", "customer_name", "customer_segment", "city"]:
        customers[column] = customers[column].astype(str).str.strip()

    if customers["customer_id"].duplicated().any():
        raise ValueError("Customer IDs must be unique")

    return customers


def clean_inventory(inventory: pd.DataFrame) -> pd.DataFrame:
    inventory = normalize_columns(inventory)
    validate_required_columns(inventory, REQUIRED_COLUMNS["inventory"], "inventory")

    inventory["product_id"] = inventory["product_id"].astype(str).str.strip()
    inventory["quantity_on_hand"] = pd.to_numeric(
        inventory["quantity_on_hand"], errors="raise"
    ).astype(int)
    inventory["reorder_level"] = pd.to_numeric(
        inventory["reorder_level"], errors="raise"
    ).astype(int)
    inventory["snapshot_date"] = pd.to_datetime(inventory["snapshot_date"]).dt.date

    if (inventory["quantity_on_hand"] < 0).any():
        raise ValueError("Inventory quantity_on_hand must be non-negative")
    if (inventory["reorder_level"] < 0).any():
        raise ValueError("Inventory reorder_level must be non-negative")

    return inventory


def clean_sales(
    sales: pd.DataFrame,
    products: pd.DataFrame,
    customers: pd.DataFrame,
) -> pd.DataFrame:
    sales = normalize_columns(sales)
    validate_required_columns(sales, REQUIRED_COLUMNS["sales"], "sales")

    sales["sale_id"] = sales["sale_id"].astype(str).str.strip()
    sales["sale_line_id"] = sales["sale_line_id"].astype(str).str.strip()
    sales["customer_id"] = sales["customer_id"].astype(str).str.strip()
    sales["product_id"] = sales["product_id"].astype(str).str.strip()
    sales["sale_date"] = pd.to_datetime(sales["sale_date"]).dt.date
    sales["quantity"] = pd.to_numeric(sales["quantity"], errors="raise").astype(int)
    sales["unit_price"] = pd.to_numeric(sales["unit_price"], errors="raise")
    sales["discount_amount"] = pd.to_numeric(
        sales["discount_amount"], errors="raise"
    ).fillna(0)

    if sales["sale_line_id"].duplicated().any():
        raise ValueError("Sale line IDs must be unique")
    if (sales["quantity"] <= 0).any():
        raise ValueError("Sales quantity must be greater than zero")
    if (sales["unit_price"] < 0).any() or (sales["discount_amount"] < 0).any():
        raise ValueError("Sales prices and discounts must be non-negative")

    product_costs = products[["product_id", "unit_cost"]].copy()
    sales = sales.merge(product_costs, on="product_id", how="left")
    if sales["unit_cost"].isna().any():
        missing = sorted(sales.loc[sales["unit_cost"].isna(), "product_id"].unique())
        raise ValueError(f"Sales contain product IDs missing from products: {missing}")

    valid_customers = set(customers["customer_id"])
    missing_customers = sorted(set(sales["customer_id"]) - valid_customers)
    if missing_customers:
        raise ValueError(
            f"Sales contain customer IDs missing from customers: {missing_customers}"
        )

    sales["gross_sales"] = sales["quantity"] * sales["unit_price"]
    sales["net_sales"] = sales["gross_sales"] - sales["discount_amount"]
    sales["cost_amount"] = sales["quantity"] * sales["unit_cost"]
    sales["gross_profit"] = sales["net_sales"] - sales["cost_amount"]

    if (sales["net_sales"] < 0).any():
        raise ValueError("Net sales must not be negative")

    return sales


def transform_all(raw_data: dict[str, pd.DataFrame]) -> dict[str, pd.DataFrame]:
    """Clean source data and calculate sales metrics."""
    products = clean_products(raw_data["products"])
    customers = clean_customers(raw_data["customers"])
    inventory = clean_inventory(raw_data["inventory"])
    sales = clean_sales(raw_data["sales"], products, customers)

    transformed = {
        "products": products,
        "customers": customers,
        "inventory": inventory,
        "sales": sales,
    }
    for name, dataframe in transformed.items():
        logging.info("Transformed %s rows for %s", len(dataframe), name)
    return transformed
