#!/bin/bash

# These are the requirements for the parse.
lat=$(jq -r '.required.latitude' config.json)
long=$(jq -r '.required.longitude' config.json)
api_key=$(jq -r '.required.api_key' config.json)
units=$(jq -r '.units' config.json)

# Script reads the config file to assign booleans.

city_value=$(jq -r '.display.city' config.json)
if [ "$city_value" = "true" ]; then
  display_city=true;
else 
  display_city=false;
fi 

description_value=$(jq -r '.display.description' config.json)
if [ "$description_value" = "true" ]; then
  display_description=true;
else
  display_description=false;
fi

temp_value=$(jq -r '.display.temperature' config.json)
if [ "$temp_value" = "true" ]; then
  display_temp=true;
else 
  display_temp=false;
fi 

feels_value=$(jq -r '.display.feels_like' config.json)
if [ "$feels_value" = "true" ]; then
  display_feel=true;
else 
  display_feel=false;
fi 

pressure_value=$(jq -r '.display.pressure' config.json)
if [ "$pressure_value" = "true" ]; then
  display_pressure=true;
else 
  display_pressure=false;
fi

humidity_value=$(jq -r '.display.humidity' config.json)
if [ "$humidity_value" = "true" ]; then
  display_humidity=true;
else 
  display_humidity=false;
fi

wind_speed_value=$(jq -r '.display.wind.speed' config.json)
if [ "$wind_speed_value" = "true" ]; then
  display_wind_speed=true;
else 
  display_wind_speed=false;
fi

wind_direction_value=$(jq -r '.display.wind.direction' config.json)
if [ "$wind_direction_value" = "true" ]; then
  display_wind_direction=true;
else 
  display_wind_direction=false;
fi

rain_1h_value=$(jq -r '.display["rain.1h"]' config.json)
if [ "$rain_1h_value" = "true" ]; then
  display_rain_1h=true;
else 
  display_rain_1h=false;
fi

rain_3h_value=$(jq -r '.display["rain.3h"]' config.json)
if [ "$rain_3h_value" = "true" ]; then
  display_rain_3h=true;
else 
  display_rain_3h=false;
fi

snow_1h_value=$(jq -r '.display["snow.1h"]' config.json)
if [ "$snow_1h_value" = "true" ]; then
  display_snow_1h=true;
else 
  display_snow_1h=false;
fi

snow_3h_value=$(jq -r '.display["snow.3h"]' config.json)
if [ "$snow_3h_value" = "true" ]; then
  display_snow_3h=true;
else 
  display_snow_3h=false;
fi


# The section to read config file is over
#
# This section is to parse json from OpenWeather and assign values to variables

# Curl the desired location

database=".weather_data/data.json"

curl -ls "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$api_key&units=$units" -o $database

if $display_city; then
  echo -n "Weather in " && (jq -r '.name' $database)
fi

if $display_description; then
  (jq -rf '.weather.0.description' $database) # This one doesnt display in proper words
fi

if $display_temp; then
  case $units in 

    "standart")
    (jq -rj '.main.temp' $database) && echo " Kelvin"
    ;;

    "metric")
    (jq -rj '.main.temp' $database) && echo " °C"
    ;;

    "imperial")
    (jq -rj '.main.temp' $database) && echo " °F"
    ;;

  esac
fi

if $display_feel; then
  case $units in 

    "standart")
    echo -n "Feels like " && (jq -rj '.main.feels_like' $database) && echo " Kelvin"
    ;;

    "metric")
    echo -n "Feels like " && (jq -rj '.main.feels_like' $database) && echo " °C"
    ;;

    "imperial")
    echo -n "Feels like " && (jq -rj '.main.feels_like' $database) && echo " °F"
    ;;

  esac
fi

if $display_pressure; then
  (jq -rj '.main.pressure' $database) && echo " Pascal pressure"
fi

if $display_humidity; then
  (jq -rj '.main.humidity' $database) && echo " % humidity"
fi

if $display_wind_speed; then
  case $units in

    "standart"|"metric")
    echo -n "Wind speed is " && (jq -rj '.wind.speed' $database) && echo " km/h"
    ;;

    "imperial")
    echo -n "Wind speed is " && (jq -rj '.wind.speed' $database) && echo " mph"
    ;;

  esac
fi

if $display_wind_direction; then
  echo -n "Wind direction is " && (jq -rj '.wind.deg' $database) && echo " degree"
fi

if $display_rain_1h; then
  echo -n "Rain for the last 1 hour is " && (jq -rj 'main.rain.1h' $database) && echo " mm"
fi

if $display_rain_3h; then
  echo -n "Rain for the last 3 hours is " && (jq -rj 'main.rain.3h' $database) && echo " mm"
fi

if $display_snow_1h; then
  echo -n "Snow for the last 1 hour is " && (jq -rj 'main.snow.1h' $database) && echo " mm"
fi

if $display_snow_3h; then
  echo -n "Snow for the last 3 hour is " && (jq -rj 'main.snow.3h' $database) && echo " mm"
fi


