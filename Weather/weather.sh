#!/bin/bash

# Check if the city argument is provided
if [ -z "$1" ]; then
    echo "Please provide a city as an argument."
    exit 1
fi

city="$1"
api_key="450bcdc5d10fd3e73b13ccb689abf85d"

# Function to convert Kelvin to Celsius
kelvin_to_celsius() {
    echo "scale=2; $1 - 273.15" | bc
}

weather_info=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key" | jq -r '.weather[0].description')
temperature_kelvin=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key" | jq -r '.main.temp')
humidity=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key" | jq -r '.main.humidity')
wind_speed=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key" | jq -r '.wind.speed')

# Convert temperature to Celsius
temperature_celsius=$(kelvin_to_celsius "$temperature_kelvin")

echo "Current weather in $city:"
echo "Description: $weather_info"
echo "Temperature: $temperature_celsius °C"
echo "Humidity: $humidity%"
echo "Wind Speed: $wind_speed m/s"


