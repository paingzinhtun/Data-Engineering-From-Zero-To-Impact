# Learning Notes

## 1. What Is An API?

An API is a way for one system to request data from another system.

In this project, Python requests weather data from Open-Meteo.

Example:

A delivery business wants weather data for Yangon. Instead of checking a website manually, the Python script asks the weather API for the data.

Why it matters:

APIs help data engineers collect external data in a repeatable way.

## 2. What Is JSON?

JSON is a common format used by APIs to send data.

JSON looks like structured text with keys and values.

Example:

```text
{
  "city": "Yangon",
  "temperature_max": 32.5
}
```

Why it matters:

The weather API returns JSON, so the Python script must read it before saving the data as CSV.

## 3. What Is An API Endpoint?

An API endpoint is a specific URL used to request a specific type of data.

In this project, there are two important API endpoints:

- Geocoding API endpoint
- Forecast API endpoint

The Geocoding API finds latitude and longitude for a city.

The Forecast API gets weather data using latitude and longitude.

Why it matters:

Different endpoints answer different questions.

## 4. What Is A GET Request?

A GET request asks an API for data.

In this project, Python sends GET requests to Open-Meteo.

Example:

The script asks:

```text
Give me the daily weather forecast for Yangon.
```

Why it matters:

GET requests are one of the most common ways to collect data from public APIs.

## 5. What Is A Status Code?

A status code tells whether an API request worked.

Common examples:

- `200` means the request succeeded
- `404` means the resource was not found
- `500` means the server had a problem

In this project, the script checks status codes before trusting the API response.

Why it matters:

If the API request fails, the business should not trust the returned data.

## 6. What Is A Timeout?

A timeout is the maximum time the script waits for an API response.

In this project, API requests use:

```text
timeout=10
```

This means the script waits up to 10 seconds for a response.

Why it matters:

Without a timeout, the script could wait too long if the API is slow or the internet connection fails.

## 7. What Does Flattening JSON Mean?

Flattening JSON means converting nested API data into simple rows and columns.

The weather API returns daily forecast values as lists.

The Python script turns those lists into CSV rows.

Example:

```text
Yangon + 2026-06-07 + temperature + rain + wind
```

Why it matters:

Flat rows are easier to save as CSV and easier for beginners to analyze.

## 8. What Is A CSV File?

A CSV file stores data in rows and columns.

CSV means comma-separated values.

In this project, the output CSV is:

```text
data/myanmar_weather_forecast.csv
```

Why it matters:

CSV is simple, readable, and useful for beginner data engineering projects.

## 9. What Is Logging?

Logging means recording what happened while the script ran.

In this project, logs are written to:

```text
logs/extraction.log
```

The log file shows:

- when extraction started
- which cities were processed
- whether API calls succeeded
- how many records were extracted
- whether validation passed

Why it matters:

Logs help data engineers debug problems and prove that a data extraction ran.

## 10. What Is Data Validation?

Data validation means checking whether data is complete and safe to use.

In this project, validation checks:

- the API response has expected fields
- the final records are not empty
- required CSV columns exist
- city values are present
- date values are present
- temperature values are present

Why it matters:

If weather data is missing or broken, future delivery or inventory analysis may be wrong.

## 11. Why This Project Matters For Data Engineering

This project teaches a basic data engineering workflow:

```text
API request -> JSON response -> validation -> flattening -> CSV output -> logging
```

These steps are common in real data work.

Even though this project is small, it teaches how to collect external data in a structured and repeatable way.

## 12. How This Project Connects To Myanmar Business Problems

A Myanmar delivery or distribution business may operate across Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi.

Weather can affect:

- delivery delays
- driver safety
- customer demand
- warehouse planning
- inventory movement

By collecting weather data into a CSV file, the business can later compare weather conditions with delivery, sales, or inventory data.

This project creates the first step: a reliable weather data source for future analysis.
