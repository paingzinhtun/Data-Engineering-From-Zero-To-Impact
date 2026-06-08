# Portfolio Story

## 1. Short Project Summary

This project collects daily weather forecast data for selected Myanmar cities from the Open-Meteo API and saves the results into a CSV file.

It is a beginner data engineering project focused on API extraction, JSON validation, flattening data, logging, and CSV output.

## 2. Business Problem Explanation

A small Myanmar delivery or distribution business may operate across Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi.

Weather can affect daily operations, including:

- delivery delay
- driver safety
- customer demand
- warehouse planning
- inventory movement

If weather data is only checked manually, the business does not have a repeatable data source for future analysis.

This project creates a simple weather data foundation that could later be compared with delivery or inventory data.

## 3. Technical Implementation Explanation

The project uses a simple API-to-CSV workflow:

```text
Myanmar city list -> Geocoding API -> Forecast API -> JSON validation -> Flattened records -> CSV output
```

The Python script:

- defines a list of Myanmar cities
- gets latitude and longitude from the Open-Meteo Geocoding API
- uses coordinates to request daily weather forecasts
- checks API status codes
- uses request timeouts
- validates expected JSON fields
- flattens daily forecast data into rows
- saves the result as `data/myanmar_weather_forecast.csv`
- writes logs to `logs/extraction.log`

The project also includes a separate CSV validation script:

```text
src/validate_weather_csv.py
```

This keeps the project focused on API to CSV while still showing a basic data quality workflow.

## 4. Business Value Created

This project does not solve all delivery planning problems yet.

Its value is that it creates a repeatable way to collect weather data.

This can support future analysis such as:

- identifying rainy days by city
- comparing weather conditions across operating areas
- studying whether rain affects delivery delays
- understanding weather-related driver safety risk
- planning warehouse and inventory movement with more context

## 5. Skills Demonstrated

This project demonstrates:

- Python scripting
- API extraction with `requests`
- working with JSON responses
- request timeout usage
- HTTP error handling
- basic data validation
- flattening nested data
- CSV output with `pandas`
- logging extraction status
- beginner-friendly documentation
- connecting technical work to business context

## 6. What I Learned

I learned that API extraction is not only about calling an endpoint.

A useful data extraction project should also:

- handle API errors
- avoid waiting forever by using timeouts
- validate response structure
- create clean tabular output
- log what happened during the run
- explain why the data matters to the business

I also learned that weather data can be a useful external dataset for delivery and distribution analysis.

## 7. How I Would Explain This In An Interview

I would explain it like this:

> This was my second beginner data engineering project. I used a Myanmar delivery business scenario where weather could affect delivery delays, driver safety, and warehouse planning. I built a Python script that collects daily weather forecast data for Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi using the Open-Meteo API. The script gets city coordinates, calls the forecast API, validates the JSON response, flattens the data into rows, saves it as a CSV file, and writes extraction logs. I also added a separate CSV validation script to check the generated output. The project is small, but it shows the core API-to-CSV workflow used in data engineering.

## 8. LinkedIn Post Draft

I completed Project 02 in my data engineering learning roadmap: Myanmar Weather API to CSV.

The business scenario is a small Myanmar delivery or distribution business operating across Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi.

Weather can affect delivery delays, driver safety, warehouse planning, customer demand, and inventory movement.

In this project, I:

- used the Open-Meteo Geocoding API to get city coordinates
- used the Open-Meteo Forecast API to collect daily weather data
- handled API status codes and request timeouts
- validated JSON responses
- flattened forecast data into CSV rows
- saved the output to CSV
- added extraction logging
- added a simple CSV validation script
- documented the project for beginners

This project helped me understand that data engineering is not just about collecting data. It is about collecting data in a repeatable, validated, and business-relevant way.

## 9. GitHub Project Description

A beginner-friendly data engineering project that extracts daily weather forecast data for selected Myanmar cities from the Open-Meteo API and saves the flattened results into a CSV file.

Tools used:

- Python
- requests
- pandas
- logging
- CSV
- Markdown

Project focus:

- API extraction
- JSON validation
- CSV output
- logging
- beginner-friendly documentation
- Myanmar business context

## 10. Future Version Ideas

Future versions could add:

- more Myanmar cities
- historical weather data
- simple weather risk categories
- comparison with delivery delay records
- comparison with sales or inventory movement
- PostgreSQL loading in a later project
- dashboard reporting in a later project
- scheduled extraction in a later project

These improvements are intentionally left out of Project 02 so the current version stays focused on API extraction to CSV.
