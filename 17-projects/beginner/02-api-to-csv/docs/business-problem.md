# Business Problem

## 1. Business Background

A small Myanmar delivery or distribution business operates across several cities, including Yangon, Mandalay, Naypyidaw, Bago, and Taunggyi.

The business needs to move goods safely and on time. Daily operations depend on drivers, routes, warehouses, customer demand, and inventory movement.

Weather is one external factor that can affect these operations.

## 2. Current Problem

Many small businesses make daily delivery and planning decisions without structured weather data.

Staff may check weather manually from websites or phone apps, but this information is not saved in a repeatable format.

This creates problems such as:

- no historical weather records for analysis
- no easy way to compare weather across cities
- manual checking every day
- no clear connection between weather and delivery delays
- limited visibility into weather-related operational risk

## 3. Why Weather Data Matters for Myanmar Businesses

Weather can affect business operations in practical ways.

For a delivery or distribution business, weather may influence:

- delivery delay
- driver safety
- customer demand
- warehouse planning
- inventory movement

For example, heavy rain may slow deliveries in Yangon. Strong wind or high rainfall may create safer-route concerns. Weather changes may also affect demand for certain products or how stock moves between cities.

## 4. Project Goal

The goal of this project is to collect daily weather forecast data for selected Myanmar cities from a public API and save it into a CSV file.

This project is not just about calling an API.

The bigger goal is to collect external data in a repeatable structure so it can later be used for analysis.

The project collects:

- city
- country
- latitude
- longitude
- forecast date
- maximum temperature
- minimum temperature
- precipitation
- maximum wind speed
- extraction timestamp

## 5. Business Value

This project helps create a simple data foundation for weather-aware business decisions.

The business can later use the CSV data to answer questions such as:

- Which cities may face rain-related delivery delays?
- Which days may have higher driver safety risk?
- Which locations may need extra warehouse planning?
- How does weather compare across operating cities?
- Could weather affect customer demand or inventory movement?

Even though this project is small, it starts a repeatable process for collecting external data.

## 6. Who Benefits From This Project

This project can benefit:

- delivery managers who monitor daily operations
- drivers who need safer route planning
- warehouse teams that prepare inventory movement
- business owners who want better operational visibility
- beginner data engineers learning API extraction

## 7. Future Use Cases

Future versions of this project could support:

- comparing weather data with delivery delay records
- building a weather risk dashboard
- tracking rainy days by city
- analyzing demand changes during different weather conditions
- sending alerts when weather risk is high
- combining weather data with sales or inventory data

These future use cases are not included in Project 02. This project focuses only on API extraction to CSV.

## 8. How This Connects to Data Engineering

Data engineering is about collecting, preparing, storing, and documenting data so it can be used for analysis.

This project demonstrates a beginner data engineering workflow:

```text
External API -> Python extraction -> JSON flattening -> CSV output -> future analysis
```

The project teaches how to:

- call a public API
- handle API responses
- validate JSON structure
- flatten nested data into rows
- save data as CSV
- log extraction results
- document the business purpose

This is a small project, but it follows an important real-world pattern: collecting external data in a reliable and repeatable format.
