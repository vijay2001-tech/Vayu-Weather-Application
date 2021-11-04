import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper1 = new NetworkHelper(
        url:
            '$kweatherApiUrl$cityName?unitGroup=metric&key=$kweatherApiKey&include=fcst%2Ccurrent');

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
        url:
            '$kweatherApiUrl${location.latitude},${location.longitude}?unitGroup=metric&key=$kweatherApiKey&include=fcst%2Ccurrent');
    var weatherData = await networkHelper.getData();

    print(weatherData);

    return weatherData;
  }
}
