from __future__ import annotations

from datetime import datetime, timedelta

from airflow.decorators import dag, task


@dag(
    dag_id="retail_daily_pipeline",
    description="Daily retail sales pipeline skeleton for learning Airflow.",
    start_date=datetime(2026, 1, 1),
    schedule="@daily",
    catchup=False,
    default_args={
        "owner": "data_engineering",
        "retries": 2,
        "retry_delay": timedelta(minutes=5),
    },
    tags=["retail", "data-engineering", "beginner"],
)
def retail_daily_pipeline() -> None:
    """Define a simple daily retail pipeline.

    This DAG is intentionally beginner-friendly. The task bodies are teaching
    stubs so learners can focus first on orchestration structure.
    Replace the print statements with real extraction, validation, loading,
    transformation, and data quality code as the project grows.
    """

    @task
    def extract_sales() -> str:
        """Extract daily sales from a source system.

        In a real project, this could read a POS CSV file, call an ecommerce
        API, or query a source database.
        """
        print("Extracting sales data for the scheduled run.")
        return "sales_extract_complete"

    @task
    def validate_sales(extract_status: str) -> str:
        """Validate the extracted sales data.

        Typical checks include required columns, non-empty files, positive
        quantities, valid prices, and expected row counts.
        """
        print(f"Validating sales data after: {extract_status}")
        return "sales_validation_complete"

    @task
    def load_raw_sales(validation_status: str) -> str:
        """Load validated sales data to the raw layer.

        The raw layer should preserve source-shaped data for audit, replay, and
        debugging.
        """
        print(f"Loading raw sales data after: {validation_status}")
        return "raw_sales_load_complete"

    @task
    def transform_sales(load_status: str) -> str:
        """Transform raw sales into business-ready tables.

        This could create staging tables, fact tables, and marts such as
        mart_daily_sales or mart_product_performance.
        """
        print(f"Transforming sales data after: {load_status}")
        return "sales_transform_complete"

    @task
    def run_quality_checks(transform_status: str) -> None:
        """Run final data quality checks.

        Example checks include no negative revenue, fresh mart tables, expected
        row counts, and valid product/customer relationships.
        """
        print(f"Running quality checks after: {transform_status}")

    extracted = extract_sales()
    validated = validate_sales(extracted)
    loaded = load_raw_sales(validated)
    transformed = transform_sales(loaded)
    run_quality_checks(transformed)


retail_daily_pipeline()
