import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/forecast_screen.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:clima/services/second_weather_box.dart';
import 'package:clima/services/weather_informer.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatelessWidget {
  Color textAndIconColor = Colors.white;

  IconData icon = WeatherIcons.night_alt_rain;
  double _opacityUp = 0.4;
  double _opacityDown = 0.4;

  @override
  Widget build(BuildContext context) {
    
    return Consumer<WeatherInformer>(

      builder: (context, weatherData, child) {
        
        // weatherData every time gets updates when they are any changes in the data and UI gets updated becasue of using provider architecture
        setFilter(weatherData.backgroundImage);
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(weatherData
                          .backgroundImage), // Setting background image

                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.8), BlendMode.dstATop),
                    ),
                  ),
                  constraints: BoxConstraints.expand(),
                  child: SafeArea(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: AppBar(
                              // AppBar
                              automaticallyImplyLeading: false,
                              leading: IconButton(
                                color: textAndIconColor,
                                icon: Icon(Icons.location_on),
                                iconSize: 25.0,
                                onPressed: () {
                                  weatherData.getLocationWeatherInfo();
                                },
                              ),
                              title: Text(
                                weatherData.cityName,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.0),
                              ),
                              centerTitle: true,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              actions: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.search),
                                  iconSize: 25.0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CityScreen()));
                                  },
                                  tooltip: 'Search',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Card(
                                color:
                                    Colors.transparent.withOpacity(_opacityUp),
                                margin: EdgeInsets.only(
                                    top: 10.0,
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 0.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 18.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 35.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              weatherData.temperature,
                                              style: TextStyle(fontSize: 70.0),
                                            ),
                                            Text(
                                              weatherData.tempMeteric,
                                              style: TextStyle(fontSize: 30.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              weatherData.date,
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                            Text(
                                              weatherData.time,
                                              style: TextStyle(fontSize: 31.0),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          // Wind direction and wind speed
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 19.0,
                                            ),
                                            Text(
                                              weatherData.windDirect,
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                            Text(
                                              weatherData.windSpeed,
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        // Another Second Column in that row
                                        children: [
                                          SizedBox(
                                            height: 26.0,
                                          ),
                                          Icon(weatherData.icon, size: 80.0),
                                          SizedBox(
                                            height: 35.0,
                                          ),
                                          Text(
                                            weatherData.weatherCondition,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 22.0),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 26.0,
                                              ),
                                              Text(
                                                weatherData.tempMax,
                                                style:
                                                    TextStyle(fontSize: 20.0),
                                              ),
                                              Text(
                                                weatherData.tempMin,
                                                style:
                                                    TextStyle(fontSize: 20.0),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            // Second weather Box
                            child: Card(
                              margin: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 8.0,
                                  right: 8.0),
                              color:
                                  Colors.transparent.withOpacity(_opacityDown),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 20.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 18.0,
                                    ),
                                    Column(
                                      // SecondWeather box weather data
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SecondWeatherBox(
                                            iconData: WeatherIcons.sunrise,
                                            label: weatherData.sunrise),
                                        SecondWeatherBox(
                                            iconData: WeatherIcons.sunset,
                                            label: weatherData.sunset),
                                        SecondWeatherBox(
                                            iconData: WeatherIcons.raindrop,
                                            label: weatherData.humidity),
                                        SecondWeatherBox(
                                            iconData: WeatherIcons.day_sunny,
                                            label: weatherData.uvindex),
                                        SecondWeatherBox(
                                            iconData: WeatherIcons.cloudy,
                                            label: weatherData.visibility),
                                        SecondWeatherBox(
                                            iconData: WeatherIcons.rain,
                                            label: weatherData.preciption),
                                        SecondWeatherBox(
                                            iconData: WeatherIcons.wind,
                                            label: weatherData.pressure),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width - 30.0,
                                      50.0),
                                  side: BorderSide(
                                      color: Colors.white, width: 3.0)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForecastViewer(),
                                    ));
                              },
                              child: Text(
                                'Forecast',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              )),
                          SizedBox(
                            height: 5.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method for setting opacity for two containers based on background
  void setFilter(String backgroundImage) {
    print("set filter called");
    switch (backgroundImage) {
      case kCloudyImage:
        {
          _opacityUp = 0.2;
          _opacityDown = 0.2;
          break;
        }
      case kNightImage:
        {
          _opacityUp = 0.1;
          _opacityDown = 0.1;
          break;
        }
      case kRainyImage:
        {
          _opacityUp = 0.1;
          _opacityDown = 0.2;
          break;
        }
      case kSunrisingImage:
        {
          _opacityUp = 0.4;
          _opacityDown = 0.4;
          break;
        }

      case kSnowyImage:
        {
          _opacityUp = 0.4;
          _opacityDown = 0.4;
          break;
        }
      case kFogImage:
        {
          _opacityUp = 0.2;
          _opacityDown = 0.2;
          break;
        }
      default:
        {
          _opacityUp = 0.4;
          _opacityDown = 0.4;
          break;
        }
    }
  }
}
