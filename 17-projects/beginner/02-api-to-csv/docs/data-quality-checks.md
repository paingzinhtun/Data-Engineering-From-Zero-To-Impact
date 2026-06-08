# Data Quality Checks

## 1. What Is Data Quality?

Data quality means checking whether data is complete, correct, consistent, and useful.

In this project, data quality means checking that weather data was successfully collected from the API and saved in the expected CSV structure.

Good data quality helps users trust the final output.

## 2. Why Data Quality Matters For Weather Data

A Myanmar delivery or distribution business may later use weather data to understand delivery delays, driver safety, customer demand, warehouse planning, or inventory movement.

If the weather data is missing, wrong, or not extracted consistently, the business cannot trust future analysis.

For example:

- missing city names make it unclear where the forecast applies
- missing dates make it impossible to compare weather by day
- missing rainfall data can hide delivery delay risk
- missing wind speed data can reduce driver safety insight
- failed API requests can create incomplete city coverage

This is why the project validates data before writing the CSV.

## 3. Data Quality Checks In This Project

### HTTP Status Code Check

The script checks whether the API request succeeds.

If the API returns a bad response, the script logs an error.

Business reason:

The business should not trust data from a failed API request.

### Timeout Check

The script uses:

```text
timeout=10
```

for API requests.

This prevents the script from waiting forever if the API is slow or unreachable.

Business reason:

Operational data extraction should not hang without ending.

### City Geocoding Result Check

The script checks whether the Geocoding API returns a result for each city.

If a city cannot be found, the script logs a warning and continues with the next city.

Business reason:

Weather analysis needs the correct city location before forecast data can be collected.

### JSON Response Shape Check

The script checks whether the API response contains expected JSON keys.

For example, the forecast response should contain:

```text
daily
```

and daily fields such as:

```text
temperature_2m_max
temperature_2m_min
precipitation_sum
wind_speed_10m_max
```

Business reason:

If the API response shape changes, the CSV output may become incorrect.

### Daily Forecast Array Length Check

The forecast API returns daily values as lists.

The script checks that all daily lists have the same length before flattening them into rows.

Business reason:

Each date should match the correct temperature, precipitation, and wind speed values.

### Required Field Check

Before saving the CSV, the script checks that every record has required output fields:

- city
- country
- latitude
- longitude
- date
- temperature_max
- temperature_min
- precipitation_sum
- wind_speed_max
- extracted_at

Business reason:

Future analysis needs consistent columns in every row.

### Generated CSV Validation Check

The project also includes a separate validation script:

```text
src/validate_weather_csv.py
```

This script checks the saved CSV file after extraction.

Business reason:

Separating extraction and validation helps confirm that the final saved file is complete and ready for analysis.

### Empty Record Check

The script checks that the final record list is not empty.

If no records are extracted, the script raises a clear error.

Business reason:

An empty CSV cannot support business analysis.

### Row Count Check

At the end, the script logs the total number of records extracted.

Business reason:

The row count helps confirm that data was collected for the selected cities.

## 4. Which Checks Are Technical Checks

Technical checks focus on whether the extraction process worked correctly.

Examples:

- HTTP status code check
- timeout check
- JSON response shape check
- daily forecast array length check
- required field check
- empty record check
- log file creation
- generated CSV validation

These checks help catch API, network, or code problems.

## 5. Which Checks Support Business Trust

Business trust checks focus on whether the output can support future analysis.

Examples:

- city is present
- date is present
- weather values are present
- latitude and longitude are present
- multiple cities are processed
- row count is logged

These checks help the business trust that the weather CSV can later be compared with delivery, sales, warehouse, or inventory data.

## 6. Common Beginner Mistakes

### Only Checking That The Script Runs

A script can run but still produce bad or incomplete data.

Always check the CSV output and logs.

### Ignoring API Errors

APIs can fail because of network problems, timeouts, or service issues.

The script should log these errors clearly.

### Saving JSON Without Flattening

Raw JSON can be difficult for beginners to analyze.

Flattening the data into rows makes it easier to save as CSV and inspect.

### Forgetting To Check Required Fields

If important fields are missing, future analysis may be wrong.

For this project, fields such as `city`, `date`, `precipitation_sum`, and `wind_speed_max` are important.

### Not Checking The Log File

The log file explains what happened during extraction.

Beginners should learn to review:

```text
logs/extraction.log
```

## 7. How This Connects To Real Data Engineering

Real data engineering is not only about collecting data.

It is also about checking that the data is reliable before it is used.

This project introduces a simple version of real data engineering quality checks:

- make API requests safely
- handle failures clearly
- validate response structure
- flatten records consistently
- check required fields
- log row counts
- save output in a repeatable format

Even though this project is small, the quality mindset is professional.

Reliable data pipelines should not only extract data. They should also prove that the extracted data is usable.
