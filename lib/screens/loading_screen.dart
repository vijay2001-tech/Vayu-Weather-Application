import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather_informer.dart';
import 'package:provider/provider.dart';
import 'package:clima/services/forecastInformer.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool flag = false;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var connectivityResult;

    print("connectivity result : $connectivityResult");

    var weatherData = await WeatherModel()
        .getLocationWeather(); // getting json data base on location(lattitude , longitude)of the device
    ForecastInformer.weatherData =
        weatherData; // passing json for ForecastInfomer

    Provider.of<WeatherInformer>(context, listen: false).getLocationWeatherInfo(
        weatherData: weatherData); // Passing Json data for making a data on UI
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return LocationScreen(); //
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return
        // ignore: missing_return
        Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
