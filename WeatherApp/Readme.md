# Concurrent Weather Data App

## Overview

This is a weather application built using SwiftUI and Swift's modern concurrency system. The app fetches weather data concurrently from a public weather API and displays it to the user as each data point finishes loading. It showcases how to leverage async/await, `Task`, and `TaskGroup` for efficient and responsive fetching of data.

## Features

- Concurrent fetching of weather data for multiple components:
  - Current conditions
  - 5-day forecast
  - Weather radar/map
  - Air quality data
  - Weather alerts or warnings
- Display data immediately as it finishes loading
- Show loading indicators while data is loading
- Error handling for failed network requests
- Refresh button to reload all weather data
- Light and dark mode support
- Location-based weather data (currently set to Almaty)

## Advanced Features (Optional for Higher Grades)

- Data cancellation support for ongoing data fetch operations
- Ability to search for different locations
- Data caching to improve performance
- Detailed views for weather components
- UI transitions and animations

## Weather APIs Used

The app fetches weather data from the OpenWeatherMap API, which provides current conditions, forecasts, air quality data, and more. You can register for an API key here: [OpenWeatherMap API](https://openweathermap.org/api).



Demo video - https://drive.google.com/file/d/1IfSC-mr8fB1w5z_hSxVwiYXHIFIjqxQ9/view?usp=share_link
