import 'package:flutter/cupertino.dart';
import 'package:weather_icons/weather_icons.dart';

// For creating forecast cards

class ForecastInformer {
  static var weatherData;
  String date = ' ';
  String time = ' ';
  String dewPoint = "Dew Point:";
  String windSpeed = "Wind Speed:";
  String windDirect = "Wind Direct:";
  String temperature = '';
  String tempMeteric = '°';
  String humidity = 'Humidity: ';
  String pressure = 'Pressure: ';
  String weatherCondition = ' ';
  String backgroundImage = '';
  IconData weatherIcon;
  String preciption = "Preciption:";
  String uvIndex = "UvIndex:";
  String cloudCover = "Cloud Cover:";

  void buildForecast(int index) {
    date = weatherData["days"][index]["datetime"];
    temperature += weatherData["days"][index]["feelslike"] == null
        ? "NA"
        : weatherData["days"][index]["feelslike"].round().toString();
    humidity += weatherData["days"][index]["humidity"] == null
        ? "0"
        : weatherData["days"][index]["humidity"].round().toString();
    preciption += weatherData["days"][index]["precip"] == null
        ? "0"
        : weatherData["days"][index]["precip"].round().toString() + "%";
    uvIndex += weatherData["days"][index]["uvindex"] == null
        ? "0"
        : weatherData["days"][index]["uvindex"].round().toString();
    windSpeed += weatherData["days"][index]["windspeed"] == null
        ? "0"
        : weatherData["days"][index]["windspeed"].round().toString();
    dewPoint += weatherData["days"][index]["dew"] == null
        ? "0"
        : weatherData["days"][index]["dew"].round().toString() + "%";
    cloudCover += weatherData["days"][index]["cloudcover"] == null
        ? "0"
        : weatherData["days"][index]["cloudcover"].round().toString() + "%";
    pressure += weatherData["days"][index]["pressure"] == null
        ? "0"
        : weatherData["days"][index]["pressure"].round().toString() + "mbar";
    weatherCondition =
        weatherData["days"][index]["conditions"].toString() == 'null '
            ? "NA"
            : weatherData["days"][index]["conditions"].toString();
    if (weatherCondition.contains(','))
      weatherCondition =
          weatherCondition.substring(0, weatherCondition.indexOf(","));
    setDate(index);
    setWeatherDirection(index);
    setWeatherIcon();
  }

  void setDate(int index) {
    List<String> data;
    date = weatherData["days"][index]["datetime"].toString();
    data = date.split('-');
    date = data[2] + "/" + data[1] + "/" + data[0].substring(2, 4);
  }

  void setWeatherDirection(int index) {
    double tempDirect = weatherData["days"][index]["winddir"] == null
        ? 0
        : weatherData["days"][index]["winddir"];
    if (tempDirect == 0)
      windDirect += "NA";
    else if (tempDirect >= 348.75 && tempDirect <= 11.25)
      windDirect += "North";
    else if (tempDirect >= 11.25 && tempDirect <= 56.25)
      windDirect += "NorthEast";
    else if (tempDirect >= 56.25 && tempDirect <= 123.75)
      windDirect += "East";
    else if (tempDirect >= 123.75 && tempDirect <= 168.75)
      windDirect += "SouthEast";
    else if (tempDirect >= 168.75 && tempDirect <= 191.25)
      windDirect += "South";
    else if (tempDirect >= 191.25 && tempDirect <= 236.25)
      windDirect += "SouthWest";
    else if (tempDirect >= 236.25 && tempDirect <= 303.75)
      windDirect += "West";
    else if (tempDirect >= 303.75 && tempDirect <= 348.75)
      windDirect += "NorthWest";
  }

  void setWeatherIcon() {
    switch (weatherCondition) {
      case "Clear": // Clear
        {
          weatherIcon = WeatherIcons.day_sunny;
        }
        break;
      case "Partially cloudy": //Partially cloudy
        {
          weatherIcon = WeatherIcons.day_cloudy;
        }
        break;
      case "Lightning Without Thunder": //Lightning Without Thunder
        {
          weatherIcon = WeatherIcons.lightning;
        }
        break;
      case "Overcast": // Overcast
        {
          weatherIcon = WeatherIcons.cloudy;
        }
        break;
      case "Hail": // Hail
        {
          weatherIcon = WeatherIcons.hail;
        }
        break;
      case "Hail Showers": //Hail Showers
        {
          weatherIcon = WeatherIcons.hail;
        }
        break;
      case "Mist": // For Mist
        {
          weatherIcon = WeatherIcons.night_fog;
        }
        break;
      case "Smoke Or Haze": // For Smoke Or Haze
        {
          weatherIcon = WeatherIcons.day_haze;
        }
        break;
      case "Duststorm": //Duststorm
        {
          weatherIcon = WeatherIcons.sandstorm;
        }
        break;
      case "Diamond Dust": //Diamond Dust
        {
          weatherIcon = WeatherIcons.sandstorm;
        }
        break;
      case "Sky Coverage Decreasing": //Sky Coverage Decreasing
        {
          weatherIcon = WeatherIcons.day_sunny;
        }
        break;
      case "Sky Coverage Increasing": //Sky Coverage Increasing
        {
          weatherIcon = WeatherIcons.cloudy;
        }
        break;

      case "Sky Unchanged": //Sky Unchanged
        {
          weatherIcon = WeatherIcons.day_sunny;
        }
        break;
      case "Squalls": //Squalls
        {
          weatherIcon = WeatherIcons.cloudy_gusts;
        }
        break;
      case "Blowing Or Drifting Snow": // Blowing Or Drifting Snow
        {
          weatherIcon = WeatherIcons.snow;
        }

        break;

      case "Fog": // For Foggy
        {
          weatherIcon = WeatherIcons.fog;
        }
        break;
      case "Freezing Fog": // Freezing Fog
        {
          weatherIcon = WeatherIcons.fog;
        }
        break;
      case "Precipitation In Vicinity": //Precipitation In Vicinity
        {
          weatherIcon = WeatherIcons.day_sprinkle;
        }
        break;
      case "Drizzle": // For Drizzle
        {
          weatherIcon = WeatherIcons.day_rain_mix;
        }
        break;
      case "Light Drizzle": // For Light Drizzle
        {
          weatherIcon = WeatherIcons.day_rain_mix;
        }
        break;
      case "Light Rain": // ForLight Rain
        {
          weatherIcon = WeatherIcons.day_rain_mix;
        }
        break;
      case "Light Drizzle/Rain": // For Light Drizzle
        {
          weatherIcon = WeatherIcons.day_rain_mix;
        }
        break;

      case "Heavy Freezing Drizzle/Freezing Rain": // Heavy Freezing Drizzle/Freezing Rain
        {
          weatherIcon = WeatherIcons.day_snow_wind;
        }
        break;

      case "Heavy Drizzle/Rain":
        {
          weatherIcon = WeatherIcons.rain_wind;
        }
        break;
      case "Heavy Drizzle": // Heavy Drizle
        {
          weatherIcon = WeatherIcons.rain;
        }
        break;
      case "Rain": // Rain
        {
          weatherIcon = WeatherIcons.rain_wind;
        }
        break;
      case "Heavy Rain": // Heavy Rain
        {
          weatherIcon = WeatherIcons.rain_wind;
        }
        break;

      case "Freezing Drizzle/Freezing Rain": //Freezing Drizzle/Freezing Rain
        {
          weatherIcon = WeatherIcons.snowflake_cold;
        }
        break;
      case "Light Freezing Drizzle/Freezing Rain": //Freezing Drizzle/Freezing Rain
        {
          weatherIcon = WeatherIcons.snowflake_cold;
        }
        break;
      case "Light Freezing Rain": //Light Freezing Rain
        {
          weatherIcon = WeatherIcons.snowflake_cold;
        }
        break;
      case "Heavy Freezing Rain": // Heavy Freezing Rain
        {
          weatherIcon = WeatherIcons.snowflake_cold;
        }
        break;

      case "Light Rain And Snow": //Light Rain And Snow
        {
          weatherIcon = WeatherIcons.day_snow;
        }
        break;
      case "Snow": //Snow
        {
          weatherIcon = WeatherIcons.day_snow;
        }
        break;
      case "Light Snow": //Light Snow
        {
          weatherIcon = WeatherIcons.day_snow;
        }
        break;

      case "Heavy Snow": // Heavy Snow
        {
          weatherIcon = WeatherIcons.snow_wind;
        }
        break;

      case "Heavy Rain And Snow": // Heavy Rain And Snow
        {
          weatherIcon = WeatherIcons.day_snow_thunderstorm;
        }
        break;
      case "Ice": //Ice
        {
          weatherIcon = WeatherIcons.snowflake_cold;
        }
        break;

      case "Rain Showers": // Rain Showers
        {
          weatherIcon = WeatherIcons.showers;
        }
        break;
      case "Funnel Cloud/Tornado": // Funnel Cloud/Tornado
        {
          weatherIcon = WeatherIcons.tornado;
        }
        break;
      case "Snow And Rain Showers": //Snow And Rain Showers
        {
          weatherIcon = WeatherIcons.showers;
        }
        break;
      case "Snow Showers": // Snow Showers
        {
          weatherIcon = WeatherIcons.showers;
        }
        break;

      case "Thunderstorm": // Thunderstorm
        {
          weatherIcon = WeatherIcons.thunderstorm;
        }
        break;
      case "Thunderstorm Without Precipitation": // Thunderstorm Without Precipitation
        {
          weatherIcon = WeatherIcons.thunderstorm;
        }
        break;

      default:
        {
          weatherIcon = WeatherIcons.day_sunny;

          break;
        }
    }
  }
}
