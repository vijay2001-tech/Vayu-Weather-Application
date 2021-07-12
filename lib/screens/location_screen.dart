import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int weatherId, temp = 0;
  String cityName;
  String weatherIcon;
  String weatherMessage;
  WeatherModel weatherinfo = WeatherModel();
  @override
  void initState() {
    super.initState();

    updateUi(widget.weatherData);
  }

  void updateUi(dynamic weatherData) {
    print(weatherData);
    weatherId = weatherData['weather'][0]['id'];
    double temperature = weatherData['main']['temp'];
    temp = temperature.toInt();
    cityName = weatherData['name'];
    weatherIcon = weatherinfo.getWeatherIcon(weatherId);
    weatherMessage = weatherinfo.getMessage(temp) + ' in $cityName';
    print('Temperature : $temp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        title: Text(
          'Delhi',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     TextButton(
              //       onPressed: () async {
              //         var weatherData = await weatherinfo.getLocationWeather();
              //         setState(() {
              //           updateUi(weatherData);
              //         });
              //       },
              //       child: Icon(
              //         Icons.near_me,
              //         size: 50.0,
              //         color: Colors.white,
              //       ),
              //     ),
              //     TextButton(
              //       onPressed: () async {
              //         var cityName = await Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return CityScreen();
              //             },
              //           ),
              //         );
              //         if (cityName != null) {
              //           var weatherData =
              //               await WeatherModel().getCityWeather(cityName);
              //           setState(() {
              //             updateUi(weatherData);
              //           });
              //         }
              //       },
              //       child: Icon(
              //         Icons.location_city,
              //         size: 50.0,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
