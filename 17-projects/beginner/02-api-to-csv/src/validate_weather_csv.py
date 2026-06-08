"""
Validate the generated Myanmar weather forecast CSV file.

This script is separate from extraction so beginners can check the CSV output
after the API data has already been saved.
"""

from pathlib import Path
import sys

import pandas as pd


PROJECT_ROOT = Path(__file__).resolve().parents[1]
CSV_FILE = PROJECT_ROOT / "data" / "myanmar_weather_forecast.csv"

REQUIRED_COLUMNS = [
    "city",
    "country",
    "latitude",
    "longitude",
    "date",
    "temperature_max",
    "temperature_min",
    "precipitation_sum",
    "wind_speed_max",
    "extracted_at",
]


def print_check_result(check_name, passed, detail):
    """Print one validation result in a consistent format."""
    status = "PASS" if passed else "FAIL"
    print(f"{status}: {check_name} - {detail}")


def validate_csv_file():
    """Run simple validation checks on the generated weather CSV."""
    print("Validating weather CSV file")
    print(f"CSV path: {CSV_FILE}")
    print()

    validation_passed = True

    if not CSV_FILE.exists():
        print_check_result("File exists", False, "CSV file was not found")
        print()
        print("Validation failed. Run the extraction script first:")
        print("python src/extract_weather_api.py")
        return False

    print_check_result("File exists", True, "CSV file found")

    df = pd.read_csv(CSV_FILE)

    missing_columns = [column for column in REQUIRED_COLUMNS if column not in df.columns]
    if missing_columns:
        validation_passed = False
        print_check_result(
            "Required columns",
            False,
            f"Missing columns: {', '.join(missing_columns)}",
        )
    else:
        print_check_result("Required columns", True, "All required columns exist")

    if len(df) == 0:
        validation_passed = False
        print_check_result("Row count", False, "CSV has 0 rows")
    else:
        print_check_result("Row count", True, f"CSV has {len(df)} rows")

    if "city" in df.columns:
        missing_city_count = df["city"].isna().sum()
        if missing_city_count > 0:
            validation_passed = False
            print_check_result(
                "City values",
                False,
                f"{missing_city_count} rows have missing city values",
            )
        else:
            print_check_result("City values", True, "No missing city values")

    if "date" in df.columns:
        missing_date_count = df["date"].isna().sum()
        if missing_date_count > 0:
            validation_passed = False
            print_check_result(
                "Date values",
                False,
                f"{missing_date_count} rows have missing date values",
            )
        else:
            print_check_result("Date values", True, "No missing date values")

    if "temperature_max" in df.columns:
        missing_temperature_max_count = df["temperature_max"].isna().sum()
        if missing_temperature_max_count > 0:
            validation_passed = False
            print_check_result(
                "Maximum temperature values",
                False,
                f"{missing_temperature_max_count} rows have missing temperature_max values",
            )
        else:
            print_check_result(
                "Maximum temperature values",
                True,
                "No missing temperature_max values",
            )

    if "temperature_min" in df.columns:
        missing_temperature_min_count = df["temperature_min"].isna().sum()
        if missing_temperature_min_count > 0:
            validation_passed = False
            print_check_result(
                "Minimum temperature values",
                False,
                f"{missing_temperature_min_count} rows have missing temperature_min values",
            )
        else:
            print_check_result(
                "Minimum temperature values",
                True,
                "No missing temperature_min values",
            )

    print()
    if validation_passed:
        print("Validation completed successfully.")
    else:
        print("Validation failed. Review the messages above.")

    return validation_passed


if __name__ == "__main__":
    if validate_csv_file():
        sys.exit(0)

    sys.exit(1)
