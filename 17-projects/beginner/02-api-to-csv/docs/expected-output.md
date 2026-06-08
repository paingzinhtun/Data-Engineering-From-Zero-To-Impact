# Expected Output

## Purpose

This document shows what a successful project run should look like.

Important note:

Weather forecast values come from an API, so exact values will differ depending on the day the script is run.

## 1. Expected Files After Running

After running the extraction script, these files should exist:

```text
data/myanmar_weather_forecast.csv
logs/extraction.log
```

The CSV file contains the extracted weather forecast data.

The log file contains messages about the extraction process.

Generated CSV and log files may be ignored by Git, but they should appear locally after running the project.

## 2. Expected Console Output

After running:

```powershell
python src/extract_weather_api.py
```

You should see a simple success message similar to:

```text
Weather extraction completed successfully. Rows saved: 35
Output file: C:\path\to\02-api-to-csv\data\myanmar_weather_forecast.csv
```

The row count may differ if the API returns a different forecast length.

A successful run should produce multiple rows per city because the forecast API returns daily forecast records.

## 3. Expected CSV Columns

The output CSV should contain these columns:

```text
city
country
latitude
longitude
date
temperature_max
temperature_min
precipitation_sum
wind_speed_max
extracted_at
```

These columns match the flattened weather records created by the Python script.

## 4. Example CSV Rows

Example rows may look like this:

| city | country | latitude | longitude | date | temperature_max | temperature_min | precipitation_sum | wind_speed_max | extracted_at |
| --- | --- | ---: | ---: | --- | ---: | ---: | ---: | ---: | --- |
| Yangon | Myanmar | 16.8053 | 96.1561 | 2026-06-07 | 31.5 | 25.2 | 4.1 | 18.3 | 2026-06-07T10:30:00 |
| Yangon | Myanmar | 16.8053 | 96.1561 | 2026-06-08 | 30.8 | 24.9 | 6.5 | 20.1 | 2026-06-07T10:30:00 |
| Mandalay | Myanmar | 21.9747 | 96.0836 | 2026-06-07 | 34.2 | 26.1 | 1.2 | 16.4 | 2026-06-07T10:30:00 |

These values are examples only.

Actual weather values, dates, latitude, longitude, and extraction timestamps may differ depending on the API response and when the script is run.

## 5. Expected Log Messages

The log file should contain messages similar to:

```text
Weather extraction started
Cities to process: Yangon, Mandalay, Naypyidaw, Bago, Taunggyi
Processing city: Yangon
Geocoding successful for Yangon
Weather extraction successful for Yangon
Processing city: Mandalay
Geocoding successful for Mandalay
Weather extraction successful for Mandalay
Validation successful
Weather extraction completed successfully
Total records extracted
```

Exact timestamps and row counts will differ.

If one city fails, the script should log the issue and continue processing the other cities.

## 6. Success Criteria

The project worked successfully if:

- the script finishes without a Python error
- `data/myanmar_weather_forecast.csv` is created
- `logs/extraction.log` is created
- the CSV has the expected columns
- the CSV has multiple rows per city
- the log file shows extraction start and completion
- the log file shows total records extracted
- the CSV validation script completes successfully

Run:

```powershell
python src/validate_weather_csv.py
```

Expected validation output should look similar to:

```text
Validating weather CSV file
CSV path: C:\path\to\02-api-to-csv\data\myanmar_weather_forecast.csv

PASS: File exists - CSV file found
PASS: Required columns - All required columns exist
PASS: Row count - CSV has 35 rows
PASS: City values - No missing city values
PASS: Date values - No missing date values
PASS: Maximum temperature values - No missing temperature_max values
PASS: Minimum temperature values - No missing temperature_min values

Validation completed successfully.
```

The row count may differ depending on the forecast length returned by the API.

## 7. How To Interpret The Output In Business Language

Each CSV row represents the weather forecast for one city on one date.

For a Myanmar delivery or distribution business, this output can help answer questions such as:

- Which cities may have rain that could delay deliveries?
- Which dates may have stronger wind and higher driver safety risk?
- How does weather differ between Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi?
- Which cities may need extra operational planning because of weather?

This project does not yet analyze delivery delays or customer demand.

It creates the weather data foundation that could later be combined with delivery, sales, warehouse, or inventory data.
