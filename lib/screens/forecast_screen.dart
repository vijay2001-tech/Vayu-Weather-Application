import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:clima/services/forecastInformer.dart';

class ForecastViewer extends StatefulWidget {
  @override
  _ForecastViewerState createState() => _ForecastViewerState();
}

class _ForecastViewerState extends State<ForecastViewer> {
  List<Widget> cards = [];
  ForecastInformer fcst;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardBuilder();
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Forecast'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
      ),
      body: ListView(
        children: cards,
      ),
    );
  }

  void cardBuilder() {
    int length = ForecastInformer.weatherData['days'].length;
    int flag = 0;
    for (int i = 0; i < length; i++) {
      fcst = new ForecastInformer();
      fcst.buildForecast(i);
      flag = flag == 0 ? 1 : 0;
      print("flag :$flag");
      setState(() {
        cards.add(forecastCard(flag));
      });
    }
  }

  Widget forecastCard(int flag) {
    return Card(
      margin: EdgeInsets.only(top: 0.0, bottom: 2.0),
      // clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: flag == 1
                ? AssetImage('assets/images/SunRising2.jpg')
                : AssetImage('assets/images/ForecastImg2.jpg'),
            height: 250,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            fcst.date, // Time
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            textBaseline: TextBaseline.ideographic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text(fcst.temperature,
                                  style: TextStyle(
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                "°C",
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 5.0, bottom: 6.0),
                            child: Icon(
                              fcst.weatherIcon,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.white,
                  height: 20,
                  thickness: 2,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fcst.humidity,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fcst.preciption,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fcst.uvIndex,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fcst.windSpeed,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fcst.dewPoint,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fcst.cloudCover,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fcst.pressure,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fcst.windDirect,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
