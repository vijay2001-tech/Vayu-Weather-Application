import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/forecastInformer.dart';

class WeatherInformer extends ChangeNotifier {
  String cityName = ' ';
  String date = ' ';
  String time = ' ';
  String windDirect = "Wind Direct: ";
  String windSpeed = "Wind Speed: ";
  String temperature = '';
  String tempMeteric = '°';
  String tempMax = 'Max: ';
  String tempMin = 'Min: ';
  String humidity = 'Humidity: ';
  String uvindex = 'UvIndex: ';
  String sunrise = 'SunRise: ';
  String sunset = "SunSet: ";
  String visibility = "Visibility: ";
  String preciption = 'Preciption: ';
  String region = ' ';
  String pressure = 'Pressure: ';
  String weatherCondition = ' ';
  String backgroundImage = '';

  double upperTransparentValue;
  double lowerTransparentValue;
  var _locationWeatherInfo;

  IconData icon;

  void _cleanData() {
    // cleans the data if required
    cityName = ' ';
    date = ' ';
    time = ' ';
    windDirect = "Wind Direct: ";
    windSpeed = "Wind Speed: ";
    temperature = '';
    tempMeteric = '°';
    tempMax = 'Max: ';
    tempMin = 'Min: ';
    humidity = 'Humidity: ';
    uvindex = 'UvIndex: ';
    sunrise = 'SunRise: ';
    sunset = "SunSet: ";
    visibility = "Visibility: ";
    preciption = 'Preciption: ';
    region = ' ';
    pressure = 'Pressure: ';
    weatherCondition = ' ';
  }

  Future getLocationWeatherInfo({var weatherData, String cityName}) async {
    // Getting data from json file
    if (weatherData == null && cityName == null) {
      _locationWeatherInfo = await WeatherModel()
          .getLocationWeather(); // Recieving JSON from network
      ForecastInformer.weatherData = _locationWeatherInfo;
      _cleanData();
      print("\n Calling again weather model ");
    } else if (weatherData == null && cityName != null) {
      _locationWeatherInfo = await WeatherModel().getCityWeather(cityName);
      ForecastInformer.weatherData = _locationWeatherInfo;
      _cleanData();
      print("\n Calling again weather model with cityName ");
    } else {
      _locationWeatherInfo = weatherData;
    }
    _getDateandTime();
    _setCurrentCity();
    double windSpeedReal =
        _locationWeatherInfo["currentConditions"]["windspeed"] == null
            ? 0
            : _locationWeatherInfo["currentConditions"]["windspeed"];
    windSpeed += windSpeedReal.round().toString() + " kmph";
    //weatherCode = _locationWeatherInfo['current']['weather_code'].toString();
    sunrise += _locationWeatherInfo["currentConditions"]["sunrise"] == null
        ? "NA"
        : _locationWeatherInfo["currentConditions"]["sunrise"]
            .toString()
            .substring(0, 5);
    sunset += _locationWeatherInfo["currentConditions"]["sunset"] == null
        ? "NA"
        : _locationWeatherInfo["currentConditions"]["sunset"]
            .toString()
            .substring(0, 5);
    pressure += _locationWeatherInfo["currentConditions"]["pressure"] == null
        ? "0"
        : _locationWeatherInfo["currentConditions"]["pressure"].toString() +
            "mbar";
    preciption +=
        _locationWeatherInfo["currentConditions"]["precip"].toString() == "null"
            ? "0"
            : _locationWeatherInfo["currentConditions"]["precip"].toString() +
                "%";
    humidity += _locationWeatherInfo["currentConditions"]["pressure"] == null
        ? "0"
        : _locationWeatherInfo["currentConditions"]["humidity"]
                .round()
                .toString() +
            "%";
    temperature += _locationWeatherInfo["currentConditions"]["temp"] == null
        ? "NA"
        : _locationWeatherInfo["currentConditions"]["temp"].round().toString();
    uvindex +=
        _locationWeatherInfo["currentConditions"]["uvindex"].toString() ==
                "null"
            ? "0"
            : _locationWeatherInfo["currentConditions"]["uvindex"]
                .toString(); // If null keep zero
    visibility += _locationWeatherInfo["currentConditions"]["visibility"]
                .toString() ==
            "null"
        ? "0"
        : _locationWeatherInfo["currentConditions"]["visibility"].toString() +
            " Km";

    tempMeteric = "°C";
    tempMax += _locationWeatherInfo["days"][0]["tempmax"] == null
        ? "NA"
        : _locationWeatherInfo["days"][0]["tempmax"].round().toString() +
            tempMeteric;
    tempMin += _locationWeatherInfo["days"][0]["tempmin"] == null
        ? "NA"
        : _locationWeatherInfo["days"][0]["tempmin"].round().toString() +
            tempMeteric;
    weatherCondition =
        _locationWeatherInfo["currentConditions"]["conditions"] == null
            ? " "
            : _locationWeatherInfo["currentConditions"]["conditions"];
    _getWindDirect();

    setWeatherIconandBackgroundImage();
    notifyListeners();
  }

  int _checkDayOrNight() {
    if (time.compareTo("05:00") == 0 ||
        time.compareTo("05:00") >= 0 && time.compareTo("08:00") <= 0) {
      return 1; // Returns True if it is Day
    } else if (time.compareTo("18:00") == 0 ||
        time.compareTo("18:00") >= 0 && time.compareTo("24:00") <= 0) {
      return 2; // Return false if it is night
    } else if (time.compareTo("00:00") >= 0 && time.compareTo("05:00") <= 0) {
      return 2;
    } else
      return 3; // Return 3 if it is afternoon
  }

  void _setTheInformation(
      // This setInformation Function sets the icon and background image  based on the constraints(like : time , weatherCondition )
      {@required String backgroundImageForDay,
      @required IconData iconForDay,
      @required String backgroundImageForNight,
      @required IconData iconForNight,
      @required String backgroundImageForRegular,
      @required IconData iconForRegular}) {
    int dayOrNightValue = _checkDayOrNight();
    if (dayOrNightValue == 1) {
      backgroundImage = backgroundImageForDay;
      _setTransparentValue(backgroundImage);
      icon = iconForDay;
      print("\nbackground Image : $backgroundImage");
    } else if (dayOrNightValue == 2) {
      backgroundImage = backgroundImageForNight;
      _setTransparentValue(backgroundImage);
      icon = iconForNight;
      print("\nbackground Image : $backgroundImage");
    } else {
      icon = iconForRegular;
      backgroundImage = backgroundImageForRegular;
      _setTransparentValue(backgroundImage);
      print("\nbackground Image : $backgroundImage");
    }
  }

  void _setTransparentValue(String bgImage) {
    // Sets the transparent Value for individual background image
    switch (bgImage) {
      case kSunrisingImage:
        {
          upperTransparentValue = 0.5;
          lowerTransparentValue = 0.5;
        }
        break;
      case kNightImage:
        {
          upperTransparentValue = 0.3;
          lowerTransparentValue = 0.3;
        }
        break;
      case kRainyImage:
        {
          upperTransparentValue = 0.2;
          lowerTransparentValue = 0.3;
        }
        break;
      case kSnowyImage:
        {
          upperTransparentValue = 0.6;
          lowerTransparentValue = 0.6;
        }
        break;
      case kFogImage:
        {
          upperTransparentValue = 0.3;
          lowerTransparentValue = 0.3;
        }
        break;
      default:
        {
          upperTransparentValue = 0.4;
          lowerTransparentValue = 0.4;
        }
    }
  }

  void _getWindDirect() {
    // For setting weather direction
    double tempDirect =
        _locationWeatherInfo["currentConditions"]["winddir"] == null
            ? 0
            : _locationWeatherInfo["currentConditions"]["winddir"];
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

  void setWeatherIconandBackgroundImage() {
    // Based on weather condition the information sets
    switch (weatherCondition) {
      case "Clear": // Clear
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_sunny,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_clear,
              backgroundImageForRegular: kSunnyBeachImage,
              iconForRegular: WeatherIcons.day_sunny);
        }
        break;
      case "Partially cloudy": //Partially cloudy
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_cloudy,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_partly_cloudy,
              backgroundImageForRegular: kSunnyBeachImage,
              iconForRegular: WeatherIcons.day_cloudy);
        }
        break;
      case "Lightning Without Thunder": //Lightning Without Thunder
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_lightning,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_lightning,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.lightning);
        }
        break;
      case "Overcast": // Overcast
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.cloudy,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_cloudy,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.cloudy);
        }
        break;
      case "Hail": // Hail
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_hail,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_hail,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.hail);
        }
        break;
      case "Hail Showers": //Hail Showers
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_hail,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_hail,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.hail);
        }
        break;
      case "Mist": // For Mist
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_fog,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_fog,
              backgroundImageForRegular: kFogImage,
              iconForRegular: WeatherIcons.night_fog);
        }
        break;
      case "Smoke Or Haze": // For Smoke Or Haze
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_haze,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_fog,
              backgroundImageForRegular: kFogImage,
              iconForRegular: WeatherIcons.day_haze);
        }
        break;
      case "Duststorm": //Duststorm
        {
          _setTheInformation(
              backgroundImageForDay: kCloudyImage,
              iconForDay: WeatherIcons.sandstorm,
              backgroundImageForNight: kCloudyImage,
              iconForNight: WeatherIcons.sandstorm,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.sandstorm);
        }
        break;
      case "Diamond Dust": //Diamond Dust
        {
          _setTheInformation(
              backgroundImageForDay: kCloudyImage,
              iconForDay: WeatherIcons.sandstorm,
              backgroundImageForNight: kCloudyImage,
              iconForNight: WeatherIcons.sandstorm,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.sandstorm);
        }
        break;
      case "Sky Coverage Decreasing": //Sky Coverage Decreasing
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_sunny,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_clear,
              backgroundImageForRegular: kSunnyBeachImage,
              iconForRegular: WeatherIcons.day_sunny);
        }
        break;
      case "Sky Coverage Increasing": //Sky Coverage Increasing
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.cloudy,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.cloudy,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.cloudy);
        }
        break;

      case "Sky Unchanged": //Sky Unchanged
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_sunny,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_clear,
              backgroundImageForRegular: kSunnyBeachImage,
              iconForRegular: WeatherIcons.day_sunny);
        }
        break;
      case "Squalls": //Squalls
        {
          _setTheInformation(
              backgroundImageForDay: kCloudyImage,
              iconForDay: WeatherIcons.day_cloudy_gusts,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_cloudy_gusts,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.cloudy_gusts);
        }
        break;
      case "Blowing Or Drifting Snow": // Blowing Or Drifting Snow
        {
          _setTheInformation(
              backgroundImageForDay: kSnowyImage,
              iconForDay: WeatherIcons.snow,
              backgroundImageForNight: kSnowyImage,
              iconForNight: WeatherIcons.snow,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.snow);
        }

        break;

      case "Fog": // For Foggy
        {
          _setTheInformation(
              backgroundImageForDay: kFogImage,
              iconForDay: WeatherIcons.day_fog,
              backgroundImageForNight: kFogImage,
              iconForNight: WeatherIcons.night_fog,
              backgroundImageForRegular: kFogImage,
              iconForRegular: WeatherIcons.fog);
        }
        break;
      case "Freezing Fog": // Freezing Fog
        {
          _setTheInformation(
              backgroundImageForDay: kFogImage,
              iconForDay: WeatherIcons.day_fog,
              backgroundImageForNight: kFogImage,
              iconForNight: WeatherIcons.night_fog,
              backgroundImageForRegular: kFogImage,
              iconForRegular: WeatherIcons.fog);
        }
        break;
      case "Precipitation In Vicinity": //Precipitation In Vicinity
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_sprinkle,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_sprinkle,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.day_sprinkle);
        }
        break;
      case "Drizzle": // For Drizzle
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_rain_mix,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_rain_mix,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.day_rain_mix);
        }
        break;
      case "Light Drizzle": // For Light Drizzle
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_rain_mix,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_rain_mix,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.day_rain_mix);
        }
        break;
      case "Light Rain": // ForLight Rain
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_rain_mix,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_rain_mix,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.day_rain_mix);
        }
        break;
      case "Light Drizzle/Rain": // For Light Drizzle
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_rain_mix,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_rain_mix,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.day_rain_mix);
        }
        break;

      case "Heavy Freezing Drizzle/Freezing Rain": // Heavy Freezing Drizzle/Freezing Rain
        {
          _setTheInformation(
              backgroundImageForDay: kSnowyImage,
              iconForDay: WeatherIcons.day_snow_wind,
              backgroundImageForNight: kSnowyImage,
              iconForNight: WeatherIcons.night_alt_snow_wind,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.day_snow_wind);
        }
        break;

      case "Heavy Drizzle/Rain":
        {
          _setTheInformation(
              backgroundImageForDay: kRainyImage,
              iconForDay: WeatherIcons.rain_wind,
              backgroundImageForNight: kRainyImage,
              iconForNight: WeatherIcons.rain_wind,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.rain_wind);
        }
        break;
      case "Heavy Drizzle": // Heavy Drizle
        {
          _setTheInformation(
              backgroundImageForDay: kRainyImage,
              iconForDay: WeatherIcons.rain,
              backgroundImageForNight: kRainyImage,
              iconForNight: WeatherIcons.rain,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.rain);
        }
        break;
      case "Rain": // Rain
        {
          _setTheInformation(
              backgroundImageForDay: kRainyImage,
              iconForDay: WeatherIcons.rain_wind,
              backgroundImageForNight: kRainyImage,
              iconForNight: WeatherIcons.rain_wind,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.rain_wind);
        }
        break;
      case "Heavy Rain": // Heavy Rain
        {
          _setTheInformation(
              backgroundImageForDay: kRainyImage,
              iconForDay: WeatherIcons.rain_wind,
              backgroundImageForNight: kRainyImage,
              iconForNight: WeatherIcons.rain_wind,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.rain_wind);
        }
        break;

      case "Freezing Drizzle/Freezing Rain": //Freezing Drizzle/Freezing Rain
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.snowflake_cold,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.snowflake_cold,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.snowflake_cold);
        }
        break;
      case "Light Freezing Drizzle/Freezing Rain": //Freezing Drizzle/Freezing Rain
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.snowflake_cold,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.snowflake_cold,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.snowflake_cold);
        }
        break;
      case "Light Freezing Rain": //Light Freezing Rain
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.snowflake_cold,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.snowflake_cold,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.snowflake_cold);
        }
        break;
      case "Heavy Freezing Rain": // Heavy Freezing Rain
        {
          _setTheInformation(
              backgroundImageForDay: kSnowyImage,
              iconForDay: WeatherIcons.snowflake_cold,
              backgroundImageForNight: kSnowyImage,
              iconForNight: WeatherIcons.snowflake_cold,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.snowflake_cold);
        }
        break;

      case "Light Rain And Snow": //Light Rain And Snow
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_snow,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_snow,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.day_snow);
        }
        break;
      case "Snow": //Snow
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_snow,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_snow,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.day_snow);
        }
        break;
      case "Light Snow": //Light Snow
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_snow,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_snow,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.day_snow);
        }
        break;

      case "Heavy Snow": // Heavy Snow
        {
          _setTheInformation(
              backgroundImageForDay: kSnowyImage,
              iconForDay: WeatherIcons.snow_wind,
              backgroundImageForNight: kSnowyImage,
              iconForNight: WeatherIcons.snow_wind,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.snow_wind);
        }
        break;

      case "Heavy Rain And Snow": // Heavy Rain And Snow
        {
          _setTheInformation(
              backgroundImageForDay: kSnowyImage,
              iconForDay: WeatherIcons.day_snow_thunderstorm,
              backgroundImageForNight: kSnowyImage,
              iconForNight: WeatherIcons.night_alt_snow_thunderstorm,
              backgroundImageForRegular: kSnowyImage,
              iconForRegular: WeatherIcons.day_snow_thunderstorm);
        }
        break;
      case "Ice": //Ice
        {
          _setTheInformation(
            backgroundImageForDay: kSunrisingImage,
            iconForDay: WeatherIcons.snowflake_cold,
            backgroundImageForNight: kNightImage,
            iconForNight: WeatherIcons.snowflake_cold,
            backgroundImageForRegular: kSnowyImage,
            iconForRegular: WeatherIcons.snowflake_cold,
          );
        }
        break;

      case "Rain Showers": // Rain Showers
        {
          _setTheInformation(
              backgroundImageForDay: kCloudyImage,
              iconForDay: WeatherIcons.showers,
              backgroundImageForNight: kCloudyImage,
              iconForNight: WeatherIcons.showers,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.showers);
        }
        break;
      case "Funnel Cloud/Tornado": // Funnel Cloud/Tornado
        {
          _setTheInformation(
              backgroundImageForDay: kCloudyImage,
              iconForDay: WeatherIcons.tornado,
              backgroundImageForNight: kCloudyImage,
              iconForNight: WeatherIcons.tornado,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.tornado);
        }
        break;
      case "Snow And Rain Showers": //Snow And Rain Showers
        {
          _setTheInformation(
              backgroundImageForDay: kCloudyImage,
              iconForDay: WeatherIcons.showers,
              backgroundImageForNight: kCloudyImage,
              iconForNight: WeatherIcons.showers,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.showers);
        }
        break;
      case "Snow Showers": // Snow Showers
        {
          _setTheInformation(
              backgroundImageForDay: kCloudyImage,
              iconForDay: WeatherIcons.showers,
              backgroundImageForNight: kCloudyImage,
              iconForNight: WeatherIcons.showers,
              backgroundImageForRegular: kCloudyImage,
              iconForRegular: WeatherIcons.showers);
        }
        break;

      case "Thunderstorm": // Thunderstorm
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_thunderstorm,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_thunderstorm,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.thunderstorm);
        }
        break;
      case "Thunderstorm Without Precipitation": // Thunderstorm Without Precipitation
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_thunderstorm,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_alt_thunderstorm,
              backgroundImageForRegular: kRainyImage,
              iconForRegular: WeatherIcons.thunderstorm);
        }
        break;

      default:
        {
          _setTheInformation(
              backgroundImageForDay: kSunrisingImage,
              iconForDay: WeatherIcons.day_sunny,
              backgroundImageForNight: kNightImage,
              iconForNight: WeatherIcons.night_clear,
              backgroundImageForRegular: kSunnyBeachImage,
              iconForRegular: WeatherIcons.day_sunny);

          break;
        }
    }
  }

  void _setCurrentCity() {
    String temp = _locationWeatherInfo["resolvedAddress"];
    List addressList = temp.split(",");
    if (addressList.length >= 2)
      cityName = addressList[0] + " , " + addressList[1];
    else
      cityName = addressList[0];
  }

  void _getDateandTime() {
    // gets date and time from JSON
    date = _locationWeatherInfo["days"][0]["datetime"].toString();
    time = _locationWeatherInfo["currentConditions"]["datetime"]
        .toString()
        .substring(0, 5);
  }
}
