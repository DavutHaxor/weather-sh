#!/bin/bash

config="config.json"

# These are the requirements for the parse.
lat=$(jq -r '.required.latitude' $config)
long=$(jq -r '.required.longitude' $config)
api_key=$(jq -r '.required.api_key' $config)
units=$(jq -r '.units' $config)

# Script reads the config file to assign booleans.

city_value=$(jq -r '.display.city' $config)
if [ "$city_value" = "true" ]; then
  display_city=true;
else 
  display_city=false;
fi 

short_description_value=$(jq -r '.display.short_description' $config)
if [ "$short_description_value" = "true" ]; then
  display_short_description=true;
else
  display_short_description=false;
fi

description_value=$(jq -r '.display.description' $config)
if [ "$description_value" = "true" ]; then
  display_description=true;
else
  display_description=false;
fi

temp_value=$(jq -r '.display.temperature' $config)
if [ "$temp_value" = "true" ]; then
  display_temp=true;
else 
  display_temp=false;
fi 

feels_value=$(jq -r '.display.feels_like' $config)
if [ "$feels_value" = "true" ]; then
  display_feel=true;
else 
  display_feel=false;
fi 

pressure_value=$(jq -r '.display.pressure' $config)
if [ "$pressure_value" = "true" ]; then
  display_pressure=true;
else 
  display_pressure=false;
fi

humidity_value=$(jq -r '.display.humidity' $config)
if [ "$humidity_value" = "true" ]; then
  display_humidity=true;
else 
  display_humidity=false;
fi

wind_speed_value=$(jq -r '.display.wind.speed' $config)
if [ "$wind_speed_value" = "true" ]; then
  display_wind_speed=true;
else 
  display_wind_speed=false;
fi

wind_direction_value=$(jq -r '.display.wind.direction' $config)
if [ "$wind_direction_value" = "true" ]; then
  display_wind_direction=true;
else 
  display_wind_direction=false;
fi

rain_1h_value=$(jq -r '.display["rain.1h"]' $config)
if [ "$rain_1h_value" = "true" ]; then
  display_rain_1h=true;
else 
  display_rain_1h=false;
fi

rain_3h_value=$(jq -r '.display["rain.3h"]' $config)
if [ "$rain_3h_value" = "true" ]; then
  display_rain_3h=true;
else 
  display_rain_3h=false;
fi

snow_1h_value=$(jq -r '.display["snow.1h"]' $config)
if [ "$snow_1h_value" = "true" ]; then
  display_snow_1h=true;
else 
  display_snow_1h=false;
fi

snow_3h_value=$(jq -r '.display["snow.3h"]' $config)
if [ "$snow_3h_value" = "true" ]; then
  display_snow_3h=true;
else 
  display_snow_3h=false;
fi


# The section to read config file is over
#
# This section is to parse json from OpenWeather and assign values to variables
#
# Curl the desired location

database=".weather_data/data.json"

curl -ls "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$api_key&units=$units" -o $database

if $display_city; then
  echo -n "Weather in " && (jq -r '.name' $database)
fi

if $display_short_description; then
  (jq -rj '.weather[0].main' $database)
fi

if $display_description; then
  description=$(jq -rj '.weather[0].description' $database)

  case $description in 
    
    # Thunderstorm 
    
    "thunderstorm with light rain")
    echo "Thunderstorm with Light Rain"
    ;;

    "thunderstorm with rain")
    echo "Thunderstorm with Rain"
    ;;

    "thunderstorm with heavy rain")
    echo "Thunderstorm with Heavy Rain"
    ;;

    "light thunderstorm")
    echo "Light Thunderstorm"
    ;;

    "thunderstorm")
    echo "Thunderstorm"
    ;;
    
    "heavy thunderstorm")
    echo "Heavy Thunderstorm"
    ;;

    "ragged thunderstorm")
    echo "Ragged Thunderstorm"
    ;;

    "thunderstorm with light drizzle")
    echo "Thunderstorm with Light Drizzle"
    ;;

    "thunderstorm with drizzle")
    echo "Thunderstorm with Drizzle"
    ;;

    "thunderstorm with heavy drizzle")
    echo "Thunderstorm with Heavy Drizzle"
    ;;

    # Drizzle 

    "light intensity drizzle")
    echo "Light Intensity Drizzle"
    ;;

    "drizzle")
    echo "Drizzle"
    ;;

    "heavy intensity drizzle")
    echo "Heavy Intensity Drizzle"
    ;;

    "light intensity drizzle rain")
    echo "Light Intensity Drizzle Rain"
    ;;
    
    "drizzle rain")
    echo "Drizzle Rain"
    ;;

    "heavy intensity drizzle rain")
    echo "Heavy Intensity Drizzle Rain"
    ;;

    "shower rain and drizzle")
    echo "Shower Rain and Drizzle"
    ;;

    "heavy shower rain and drizzle")
    echo "Heavy Shower Rain and Drizzle"
    ;;

    "shower drizzle")
    echo "Shower Drizzle"
    ;;

    # Rain

    "light rain")
    echo "Light Rain"
    ;;

    "moderate rain")
    echo "Moderate Rain"
    ;;

    "heavy intensity rain")
    echo "Heavy Intensity Rain"
    ;;

    "very heavy rain")
    echo "Very Heavy Rain"
    ;;

    "extreme rain")
    echo "Extreme Rain"
    ;;

    "freezing rain")
    echo "Freezing Rain"
    ;;

    "light intensity shower rain")
    echo "Light Intensity Shower Rain"
    ;;

    "shower rain")
    echo "Shower Rain"
    ;;

    "heavy intensity shower rain")
    echo "Heavy Intensity Shower Rain"
    ;;

    "ragged shower rain")
    echo "Ragged Shower Rain"
    ;;

    # Snow 

    "light snow")
    echo "Light Snow"
    ;;

    "snow")
    echo "Snow"
    ;;

    "heavy snow")
    echo "Heavy Snow"
    ;;

    "sleet")
    echo "Sleet"
    ;;

    "light shower sleet")
    echo "Light Shower Sleet"
    ;;

    "shower sleet")
    echo "Shower Sleet"
    ;;

    "light rain and snow")
    echo "Light Rain and Snow"
    ;;

    "rain and snow")
    echo "Rain and Snow"
    ;;

    "light shower snow")
    echo "Light Shower Snow"
    ;;

    "shower snow")
    echo "Shower Snow "
    ;;

    "heavy shower snow")
    echo "Heavy Shower Snow "
    ;;

    # Atmosphere

    "mist")
    echo "Mist"
    ;;

    "smoke")
    echo "Smoke"
    ;;

    "haze")
    echo "Haze"
    ;;

    "sand/dust whirls")
    echo "Sand/Dust Whirls"
    ;;

    "fog")
    echo "Fog"
    ;;

    "sand")
    echo "Sand"
    ;;

    "dust")
    echo "Dust"
    ;;

    "volcanic ash")
    echo "Volcanic Ash"
    ;;

    "squalls")
    echo "Squalls"
    ;;

    "tornado")
    echo "Tornado"
    ;;
    
    "clear sky")
    echo "Clear Sky"
    ;;

    # Clouds

    "few clouds")
    echo "Few Clouds"
    ;;

    "scattered clouds")
    echo "Scattered Clouds"
    ;;

    "broken clouds")
    echo "Broken Clouds"
    ;;

    "overcast clouds")
    echo "Overcast Clouds"
    ;;


  esac
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
  echo -n "Rain for the last 1 hour is " && (jq -rj '.rain.1h' $database) && echo " mm"
fi

if $display_rain_3h; then
  echo -n "Rain for the last 3 hours is " && (jq -rj '.rain.3h' $database) && echo " mm"
fi

if $display_snow_1h; then
  echo -n "Snow for the last 1 hour is " && (jq -rj '.snow.1h' $database) && echo " mm"
fi

if $display_snow_3h; then
  echo -n "Snow for the last 3 hour is " && (jq -rj 'snow.3h' $database) && echo " mm"
fi


