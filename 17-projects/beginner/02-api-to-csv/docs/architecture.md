# Architecture

## 1. Architecture Overview

This project uses a simple API-to-CSV data architecture.

The project starts with a list of Myanmar cities. Python then uses the Open-Meteo Geocoding API to find each city's latitude and longitude. After that, Python uses the Open-Meteo Forecast API to collect daily weather forecast data.

The API response is returned as JSON. The Python script validates the JSON structure, flattens the daily weather data into rows, and saves the final result as a CSV file.

This is Project 02, so the architecture stays focused on API extraction to CSV.

## 2. Data Flow Diagram Using Plain Text

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
   |
   v
Future PostgreSQL loading
```

## 3. Components

### Myanmar City List

The city list defines which locations the project will collect weather data for.

Current cities:

- Yangon
- Mandalay
- Naypyidaw
- Bago
- Taunggyi

This keeps the project focused and easy for beginners to understand.

### Geocoding API

The Open-Meteo Geocoding API converts a city name into latitude and longitude.

Example:

```text
Yangon -> latitude and longitude
```

This step matters because the forecast API needs coordinates, not only city names.

### Forecast API

The Open-Meteo Forecast API uses latitude and longitude to return daily weather forecast data.

The project extracts:

- maximum temperature
- minimum temperature
- precipitation
- maximum wind speed

These fields are useful for delivery and operational planning.

### Python Extractor

The Python extractor is the main script:

```text
src/extract_weather_api.py
```

It handles:

- calling the geocoding API
- calling the forecast API
- checking API responses
- flattening JSON data
- saving the CSV output
- writing log messages

### CSV Output

The final output is saved as:

```text
data/myanmar_weather_forecast.csv
```

The CSV contains one row per city per forecast date.

This makes the data easy to inspect, share, and use for beginner analysis.

### Logging

The project writes extraction logs to:

```text
logs/extraction.log
```

Logs help show:

- when extraction started
- which city was processed
- whether API calls succeeded
- how many rows were extracted
- whether any errors happened

### Validation

Validation checks whether the API response and final records contain the expected data.

The script checks for required fields such as:

- city
- date
- temperature values
- precipitation
- wind speed

Validation helps prevent incomplete or broken data from being saved to CSV.

## 4. Why This Architecture Is Suitable for Beginners

This architecture is suitable for beginners because it uses only a few simple parts:

- a list of city names
- public APIs
- Python
- JSON responses
- CSV output
- basic logging
- basic validation

Each step has a clear purpose.

Beginners can learn how data moves from an external API into a structured CSV file without adding extra tools.

## 5. Why This Architecture Is Useful for Myanmar Small Businesses

Myanmar delivery and distribution businesses may operate across different cities with different weather conditions.

This architecture helps collect weather data in a repeatable way.

The business can later use the CSV to understand:

- rainy days by city
- possible delivery delay risk
- driver safety concerns
- weather differences across operating areas
- future demand or inventory movement patterns

The current project does not solve all of these problems yet, but it creates the first data foundation.

## 6. Limitations

This architecture has some limitations:

- data extraction is manual
- the project only collects forecast data
- the output is saved as one CSV file
- there is no database in the current version
- there is no dashboard
- there is no scheduled automation
- there is no historical delivery or sales data yet

These limitations are acceptable for Project 02 because the goal is to learn API extraction to CSV first.

## 7. Future Improvements

Future versions could add:

- loading the CSV into PostgreSQL
- comparing weather data with delivery delay data
- storing historical weather extracts
- adding more Myanmar cities
- creating simple weather risk categories
- building a dashboard in a later project
- automating the extraction in a later project

For now, the architecture stays simple so beginners can focus on the core workflow: call an API, validate the response, flatten JSON, and save CSV data.
