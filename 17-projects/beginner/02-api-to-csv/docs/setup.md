# Setup Guide

## Purpose

This guide helps beginners run the Myanmar Weather API to CSV project on their own computer.

The project uses Python to call the Open-Meteo API, flatten the weather forecast data, and save the result as a CSV file.

## 1. Prerequisites

Before running the project, install:

- Python 3.10 or newer
- Git, if you want to clone the project from GitHub
- A code editor, such as VS Code
- Internet connection, because the script calls a public weather API

Check Python version:

```powershell
python --version
```

If this does not work, try:

```powershell
py --version
```

## 2. How To Clone Or Download The Project

### Option A: Clone With Git

```powershell
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name/17-projects/beginner/02-api-to-csv
```

If this project is inside a larger learning roadmap repo, go to the project folder:

```powershell
cd Data-Engineering-From-Zero-To-Impact/17-projects/beginner/02-api-to-csv
```

### Option B: Download ZIP

1. Open the GitHub repository in your browser
2. Click Code
3. Click Download ZIP
4. Extract the ZIP file
5. Open the project folder in your terminal

## 3. How To Create A Virtual Environment

A virtual environment keeps project dependencies separate from other Python projects.

### Windows PowerShell

```powershell
python -m venv .venv
```

If `python` does not work, try:

```powershell
py -m venv .venv
```

### macOS or Linux Terminal

```bash
python3 -m venv .venv
```

## 4. How To Activate The Virtual Environment

### Windows PowerShell

```powershell
.\.venv\Scripts\Activate.ps1
```

If PowerShell blocks activation, run:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then try activating again:

```powershell
.\.venv\Scripts\Activate.ps1
```

### Windows Command Prompt

```cmd
.venv\Scripts\activate.bat
```

### macOS or Linux Terminal

```bash
source .venv/bin/activate
```

When the virtual environment is active, your terminal may show:

```text
(.venv)
```

## 5. How To Install Dependencies

Install the required Python packages:

```powershell
pip install -r requirements.txt
```

This project needs:

- `requests` for API calls
- `pandas` for writing CSV output

## 6. How To Run The Extraction Script

Run this command from the project root folder:

```powershell
python src/extract_weather_api.py
```

The script will:

1. Read the Myanmar city list
2. Get latitude and longitude from Open-Meteo Geocoding API
3. Get daily weather forecast data from Open-Meteo Forecast API
4. Validate the API response and flattened records
5. Save the CSV output
6. Write extraction logs

After extraction, you can run a separate CSV validation script:

```powershell
python src/validate_weather_csv.py
```

This checks the generated CSV file after it has been saved.

Separating extraction and validation is useful in data engineering because sometimes you want to collect data first, then check whether the saved output is complete and trustworthy.

If validation fails, the command prints the failed checks and exits with an error code.

## 7. Where To Find The Output CSV

The output CSV file should be created here:

```text
data/myanmar_weather_forecast.csv
```

This file contains one row per city per forecast date.

Expected columns:

```text
city, country, latitude, longitude, date, temperature_max, temperature_min, precipitation_sum, wind_speed_max, extracted_at
```

## 8. Where To Find The Log File

The extraction log file should be created here:

```text
logs/extraction.log
```

The log file shows:

- when extraction started
- which cities were processed
- successful geocoding results
- successful weather extraction results
- errors or warnings
- total records extracted

## 9. Common Errors And Fixes

### Error: Python is not recognized

This means Python is not installed or not added to your system PATH.

Fix:

- Install Python from the official website
- During installation, select Add Python to PATH
- Try `py --version` on Windows

### Error: No module named requests

This means dependencies were not installed.

Fix:

```powershell
pip install -r requirements.txt
```

### Error: No module named pandas

This also means dependencies were not installed.

Fix:

```powershell
pip install -r requirements.txt
```

### Error: API request failed

This may happen if:

- internet connection is unavailable
- Open-Meteo is temporarily unavailable
- the request times out

Fix:

- Check your internet connection
- Run the script again later
- Review `logs/extraction.log`

### Error: Extraction failed: no weather records were extracted

This means the script could not collect valid data for any city.

Fix:

- Check your internet connection
- Check the log file
- Confirm the city list is correct
- Try running the script again

### Error: PowerShell cannot activate virtual environment

PowerShell may block script execution.

Fix:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then activate again:

```powershell
.\.venv\Scripts\Activate.ps1
```

## 10. How To Confirm The Project Worked

The project worked if:

1. The script prints a success message
2. The CSV file exists:

```text
data/myanmar_weather_forecast.csv
```

3. The log file exists:

```text
logs/extraction.log
```

4. The CSV has rows for Myanmar cities such as:

- Yangon
- Mandalay
- Naypyidaw
- Bago
- Taunggyi

5. The CSV has weather columns such as:

- `temperature_max`
- `temperature_min`
- `precipitation_sum`
- `wind_speed_max`

6. The validation script passes:

```powershell
python src/validate_weather_csv.py
```

If these files, columns, and validation checks pass, the API extraction to CSV process worked successfully.
