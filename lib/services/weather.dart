import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper1 = new NetworkHelper(
        '$kOpenWeatherApiUrl?q=$cityName&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper1.getData();
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentPostion();
    print("latitiude : " + location.latitude.toString());
    print("longitude : " + location.longitude.toString());

    NetworkHelper networkHelper = new NetworkHelper(
        '$kOpenWeatherApiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');
    var weatherData = await networkHelper.getData();
    print(weatherData);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    // String message = 'No weather message';
    // switch (condition) {
    //   case 113:
    //     return message = 'Clear/Sunny';
    //   case 116:
    //     return message = 'Partly Cloudy';
    //   case 119:
    //     return message = 'Cloudy';
    //   case 122:
    //     return message = 'Overcast';
    //   case 143:
    //     return message = 'Mist';
    //   case 176:
    //     return message = 'Patchy rain nearby';
    //   case 179:
    //     return message = 'Patchy snow nearby';
    //   case 182:
    //     return message = 'Patchy sleet nearby';
    //   case 185:
    //     return message = 'Patchy freezing drizzle nearby	';
    //   case 200:
    //     return message = 'Thundery outbreaks in nearby';
    //   case 227:
    //     return message = 'Blowing snow';
    //   case 230:
    //     return message = 'Blizzard';
    //   case 248:
    //     return message = 'Fog	';
    //   case 260:
    //     return message = 'Freezing fog';
    //   case 263:
    //     return message = 'Patchy light drizzle';
    //   case 266:
    //     return message = 'Light drizzle';
    //   case 281:
    //     return message = 'Freezing drizzle';
    //   case 284:
    //     return message = 'Heavy freezing drizzle';
    //   case 293:
    //     return message = 'Patchy light rain';
    //   case 296:
    //     return message = 'Light rain';
    //   case 299:
    //     return message = 'Moderate rain at time';
    //   case 302:
    //     return message = 'Moderate rain';
    //   case 305:
    //     return message = 'Heavy rain at times';
    //   case 308:
    //     return message = 'Heavy rain';
    //   case 311:
    //     return message = 'Light freezing rain';
    //   case 314:
    //     return message = 'Moderate or Heavy freezing rain	';
    //   case 317:
    //     return message = 'Light sleet';
    //   case 320:
    //     return message = 'Moderate or heavy sleet';
    //   case 323:
    //     return message = 'Patchy light snow';
    //   case 326:
    //     return message = 'Light snow';
    //   case 329:
    //     return message = 'Patchy moderate snow';
    //   case 332:
    //     return message = 'Moderate snow	';
    //   case 335:
    //     return message = 'Patchy heavy snow';
    //   case 338:
    //     return message = 'Heavy snow';
    //   case 350:
    //     return message = 'Ice pellets';
    //   case 353:
    //     return message = 'Light rain shower';
    //   case 356:
    //     return message = 'Moderate or heavy rain shower	';
    //   case 359:
    //     return message = 'Torrential rain shower';
    //   case 362:
    //     return message = 'Light sleet showersy';
    //   case 365:
    //     return message = 'Moderate or heavy sleetshowers';
    //   case 368:
    //     return message = 'Light snow showers';
    //   case 371:
    //     return message = 'Moderate or heavy snow showers';
    //   case 374:
    //     return message = 'Light showers of ice pellets';
    //   case 377:
    //     return message = 'Moderate or heavy showers of ice pellets';
    //   case 386:
    //     return message = 'Patchy light rain in area with thunder';
    //   case 389:
    //     return message = 'Moderate or heavy rain in area with thunder';
    //   case 392:
    //     return message = 'Patchy light snow in area with thunder';
    //   case 395:
    //     return message = 'Moderate or heavy snow in area with thunder';

    //   default:
    //     return message;
    // }

    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 35) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
