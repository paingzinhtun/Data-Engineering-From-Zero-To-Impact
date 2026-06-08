# Myanmar Weather API to CSV

## 1. Project Overview

This is Project 02 in a larger data engineering learning roadmap.

The project extracts daily weather forecast data for selected Myanmar cities from a public API and saves the flattened results into a CSV file.

The focus is simple and practical:

```text
Public API -> Python extraction -> JSON validation -> Flattened records -> CSV output
```

This project does not use scheduling, Docker, Airflow, dbt, cloud tools, or PostgreSQL. PostgreSQL loading is a future improvement, not part of the current project.

## 2. Business Problem

A small Myanmar delivery or distribution business operates across cities such as Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi.

Weather can affect:

- delivery delay
- driver safety
- customer demand
- warehouse planning
- inventory movement

If weather data is only checked manually, the business does not have a repeatable data source for future analysis.

## 3. Project Goal

The goal of this project is to collect daily weather forecast data for selected Myanmar cities and save it into a clean CSV file.

The project is not only about calling an API. It is about collecting external data in a repeatable structure so it can later support analysis.

## 4. What This Project Demonstrates

This project demonstrates beginner data engineering skills:

- calling a public API with Python
- using API parameters
- handling HTTP errors
- using request timeouts
- validating JSON response structure
- flattening nested API data
- writing CSV output with pandas
- logging extraction progress
- documenting a small data pipeline

## 5. Tools Used

- Python
- requests
- pandas
- datetime
- logging
- CSV
- Markdown documentation

## 6. API Used

This project uses Open-Meteo.

Open-Meteo is beginner-friendly because basic usage does not require an API key.

APIs used:

- Open-Meteo Geocoding API
- Open-Meteo Forecast API

The Geocoding API converts city names into latitude and longitude.

The Forecast API uses latitude and longitude to return daily weather forecast data.

## 7. Dataset / Output Description

The output dataset is a CSV file:

```text
data/myanmar_weather_forecast.csv
```

The CSV contains daily forecast records for:

- Yangon
- Mandalay
- Naypyidaw
- Bago
- Taunggyi

Each row represents one city on one forecast date.

Weather values change depending on when the API is called, so exact values are not fixed.

## 8. Project Folder Structure

```text
02-api-to-csv/
+-- data/
|   +-- myanmar_weather_forecast.csv
+-- src/
|   +-- extract_weather_api.py
|   +-- validate_weather_csv.py
+-- docs/
|   +-- architecture.md
|   +-- business-problem.md
|   +-- data-quality-checks.md
|   +-- expected-output.md
|   +-- learning-notes.md
|   +-- portfolio-story.md
|   +-- setup.md
+-- logs/
|   +-- extraction.log
+-- screenshots/
|   +-- .gitkeep
+-- README.md
+-- requirements.txt
+-- .gitignore
```

Note:

The CSV and log files are generated when the script runs.

Generated files may be ignored by Git, but they should appear locally after a successful run.

The `screenshots/` folder is included for portfolio screenshots after you run the project.

## 9. Data Flow

```text
Myanmar city list
   |
   v
Open-Meteo Geocoding API
   |
   v
Latitude and longitude
   |
   v
Open-Meteo Forecast API
   |
   v
Python requests extractor
   |
   v
JSON response validation
   |
   v
Flattened weather records
   |
   v
CSV output
```

## 10. How To Run The Project

### Step 1: Create A Virtual Environment

Windows PowerShell:

```powershell
python -m venv .venv
```

### Step 2: Activate The Virtual Environment

Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

### Step 3: Install Dependencies

```powershell
pip install -r requirements.txt
```

### Step 4: Run The Extraction Script

```powershell
python src/extract_weather_api.py
```

Expected output file:

```text
data/myanmar_weather_forecast.csv
```

Expected log file:

```text
logs/extraction.log
```

### Step 5: Validate The Generated CSV

After extraction, run:

```powershell
python src/validate_weather_csv.py
```

This checks that the CSV file exists, has rows, has the expected columns, and does not have missing city, date, or temperature values.

Separating extraction and validation is useful because a data engineer may want to check output quality after data has already been collected.

More detailed setup instructions are available in:

```text
docs/setup.md
```

## 11. Output CSV Columns

| Column | Description |
| --- | --- |
| `city` | Myanmar city name |
| `country` | Country returned by the geocoding API |
| `latitude` | City latitude |
| `longitude` | City longitude |
| `date` | Forecast date |
| `temperature_max` | Maximum daily temperature |
| `temperature_min` | Minimum daily temperature |
| `precipitation_sum` | Total daily precipitation |
| `wind_speed_max` | Maximum daily wind speed |
| `extracted_at` | Timestamp when the script extracted the data |

## 12. Validation Checks

The Python script includes simple validation checks:

- HTTP status code check
- request timeout
- city geocoding result check
- Myanmar country check for geocoding results
- JSON response shape check
- daily forecast array length check
- required output field check
- empty record check
- row count logging
- generated CSV validation with `src/validate_weather_csv.py`

If validation fails, the script logs the issue and raises a clear error.

The separate CSV validation script prints a validation summary and returns a failure exit code if the CSV does not pass.

## 13. Example Business Questions This Data Can Support

This weather data can later support questions such as:

- Which cities may face rain-related delivery delays?
- Which forecast dates may have higher driver safety risk?
- How does weather differ across Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi?
- Which locations may need extra warehouse planning?
- Could weather patterns affect customer demand or inventory movement?

This project only collects the weather data. Deeper analysis can be added in future projects.

## 14. Screenshots

Screenshots can be added later to show:

- successful script run in terminal
- generated CSV file
- sample CSV rows
- generated log file
- log messages showing processed cities and row count
- CSV validation script output

Suggested folder:

```text
screenshots/
```

## 15. What I Learned

In this project, I learned how to:

- call a public API with Python
- use city names to get latitude and longitude
- use coordinates to request weather forecasts
- handle API errors
- validate JSON data
- flatten API responses into CSV rows
- log extraction results
- connect external data collection to a business use case

## 16. Future Improvements

Future versions could add:

- more Myanmar cities
- historical weather data
- simple weather risk categories
- comparison with delivery delay records
- PostgreSQL loading
- dashboard reporting
- scheduled extraction in a later project

These improvements are intentionally not included in Project 02 so the current project stays focused on API extraction to CSV.

## 17. Portfolio Explanation

This project shows a beginner-friendly API extraction workflow:

```text
External API -> Python extraction -> Validation -> CSV output
```

It is small, but it connects to a real business problem.

The project demonstrates that data engineering is not only about writing code. It is about collecting reliable data that can later support better business decisions.
