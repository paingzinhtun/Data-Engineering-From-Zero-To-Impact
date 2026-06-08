"""
Project 02: Myanmar Weather API to CSV

Purpose:
Extract daily weather forecast data for selected Myanmar cities from Open-Meteo
and save the flattened result to a CSV file.
"""

from datetime import datetime
import logging
from pathlib import Path

import pandas as pd
import requests


# Project folders and output files.
PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = PROJECT_ROOT / "data"
LOGS_DIR = PROJECT_ROOT / "logs"
OUTPUT_CSV = DATA_DIR / "myanmar_weather_forecast.csv"
LOG_FILE = LOGS_DIR / "extraction.log"

# Open-Meteo does not require an API key for this beginner use case.
GEOCODING_URL = "https://geocoding-api.open-meteo.com/v1/search"
FORECAST_URL = "https://api.open-meteo.com/v1/forecast"

REQUEST_TIMEOUT = 10
TIMEZONE = "Asia/Yangon"

MYANMAR_CITIES = [
    "Yangon",
    "Mandalay",
    "Naypyidaw",
    "Bago",
    "Taunggyi",
]

REQUIRED_OUTPUT_FIELDS = [
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


def setup_logging():
    """Create the logs folder and configure logging to a file."""
    LOGS_DIR.mkdir(parents=True, exist_ok=True)

    logging.basicConfig(
        filename=LOG_FILE,
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        filemode="a",
    )


def get_city_location(city_name):
    """
    Get latitude and longitude for one city using the Open-Meteo Geocoding API.

    Returns a dictionary with city location details, or None if the city
    cannot be found.
    """
    params = {
        "name": city_name,
        "count": 1,
        "language": "en",
        "format": "json",
    }

    try:
        response = requests.get(
            GEOCODING_URL,
            params=params,
            timeout=REQUEST_TIMEOUT,
        )
        response.raise_for_status()
    except requests.RequestException as error:
        logging.error("Geocoding request failed for %s: %s", city_name, error)
        return None

    try:
        data = response.json()
    except ValueError as error:
        logging.error("Geocoding API returned invalid JSON for %s: %s", city_name, error)
        return None

    if "results" not in data or not data["results"]:
        logging.warning("City not found in geocoding API: %s", city_name)
        return None

    first_result = data["results"][0]

    required_keys = ["name", "country", "latitude", "longitude"]
    for key in required_keys:
        if key not in first_result:
            logging.error("Missing geocoding key '%s' for %s", key, city_name)
            return None

    if first_result["country"] != "Myanmar":
        logging.warning(
            "Geocoding result for %s was not in Myanmar. Returned country: %s",
            city_name,
            first_result["country"],
        )
        return None

    location = {
        "city": city_name,
        "country": first_result["country"],
        "latitude": first_result["latitude"],
        "longitude": first_result["longitude"],
    }

    logging.info(
        "Geocoding successful for %s: country=%s latitude=%s longitude=%s",
        city_name,
        location["country"],
        location["latitude"],
        location["longitude"],
    )

    return location


def get_daily_forecast(location):
    """
    Get daily weather forecast data for one city location.

    Returns the forecast JSON dictionary, or None if the API request fails
    or the response does not contain the expected daily data.
    """
    params = {
        "latitude": location["latitude"],
        "longitude": location["longitude"],
        "daily": [
            "temperature_2m_max",
            "temperature_2m_min",
            "precipitation_sum",
            "wind_speed_10m_max",
        ],
        "timezone": TIMEZONE,
    }

    try:
        response = requests.get(
            FORECAST_URL,
            params=params,
            timeout=REQUEST_TIMEOUT,
        )
        response.raise_for_status()
    except requests.RequestException as error:
        logging.error("Forecast request failed for %s: %s", location["city"], error)
        return None

    try:
        data = response.json()
    except ValueError as error:
        logging.error("Forecast API returned invalid JSON for %s: %s", location["city"], error)
        return None

    if "daily" not in data:
        logging.error("Missing 'daily' forecast data for %s", location["city"])
        return None

    daily = data["daily"]
    required_daily_keys = [
        "time",
        "temperature_2m_max",
        "temperature_2m_min",
        "precipitation_sum",
        "wind_speed_10m_max",
    ]

    for key in required_daily_keys:
        if key not in daily:
            logging.error("Missing daily forecast key '%s' for %s", key, location["city"])
            return None

    expected_length = len(daily["time"])
    for key in required_daily_keys:
        if len(daily[key]) != expected_length:
            logging.error(
                "Daily forecast field '%s' has an unexpected length for %s",
                key,
                location["city"],
            )
            return None

    return data


def flatten_forecast(location, forecast_data, extracted_at):
    """
    Convert the forecast JSON arrays into a list of flat table-like records.

    Each record will become one CSV row.
    """
    daily = forecast_data["daily"]
    records = []

    for index, forecast_date in enumerate(daily["time"]):
        record = {
            "city": location["city"],
            "country": location["country"],
            "latitude": location["latitude"],
            "longitude": location["longitude"],
            "date": forecast_date,
            "temperature_max": daily["temperature_2m_max"][index],
            "temperature_min": daily["temperature_2m_min"][index],
            "precipitation_sum": daily["precipitation_sum"][index],
            "wind_speed_max": daily["wind_speed_10m_max"][index],
            "extracted_at": extracted_at,
        }
        records.append(record)

    return records


def validate_records(records):
    """
    Validate flattened records before writing the CSV file.

    This keeps the output trustworthy and helps catch API or coding issues early.
    """
    logging.info("Validating extracted records")

    if not records:
        error_message = "Validation failed: record list is empty."
        logging.error(error_message)
        raise ValueError(error_message)

    for row_number, record in enumerate(records, start=1):
        for field in REQUIRED_OUTPUT_FIELDS:
            if field not in record:
                error_message = (
                    f"Validation failed: missing field '{field}' in row {row_number}."
                )
                logging.error(error_message)
                raise ValueError(error_message)

        if not record["city"]:
            error_message = f"Validation failed: city is empty in row {row_number}."
            logging.error(error_message)
            raise ValueError(error_message)

        if not record["date"]:
            error_message = f"Validation failed: date is empty in row {row_number}."
            logging.error(error_message)
            raise ValueError(error_message)

        important_weather_fields = [
            "temperature_max",
            "temperature_min",
            "precipitation_sum",
            "wind_speed_max",
        ]

        for field in important_weather_fields:
            if record[field] is None:
                error_message = (
                    f"Validation failed: {field} is missing in row {row_number}."
                )
                logging.error(error_message)
                raise ValueError(error_message)

    logging.info("Validation successful: %s records passed validation", len(records))


def save_records_to_csv(records):
    """Save all flattened weather records to the output CSV file."""
    DATA_DIR.mkdir(parents=True, exist_ok=True)

    df = pd.DataFrame(records)
    df.to_csv(OUTPUT_CSV, index=False)

    return len(df)


def main():
    """Run the full extraction process."""
    setup_logging()
    logging.info("Weather extraction started")
    logging.info("Cities to process: %s", ", ".join(MYANMAR_CITIES))

    all_records = []
    extracted_at = datetime.now().isoformat(timespec="seconds")

    for city in MYANMAR_CITIES:
        logging.info("Processing city: %s", city)

        location = get_city_location(city)
        if location is None:
            logging.warning("Skipping city because location was not found: %s", city)
            continue

        forecast_data = get_daily_forecast(location)
        if forecast_data is None:
            logging.warning("Skipping city because forecast was not found: %s", city)
            continue

        city_records = flatten_forecast(location, forecast_data, extracted_at)
        all_records.extend(city_records)

        logging.info(
            "Weather extraction successful for %s: %s rows",
            city,
            len(city_records),
        )

    validate_records(all_records)

    row_count = save_records_to_csv(all_records)

    logging.info("Weather extraction completed successfully")
    logging.info("Total records extracted: %s", row_count)
    logging.info("Output file: %s", OUTPUT_CSV)

    print(f"Weather extraction completed successfully. Rows saved: {row_count}")
    print(f"Output file: {OUTPUT_CSV}")


if __name__ == "__main__":
    main()
