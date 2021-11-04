import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:auto_search/auto_search.dart';
import 'package:clima/services/citys_list.dart';
import 'package:clima/services/weather_informer.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatefulWidget {
  CityScreen();
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String _cityName = '';
  static List<String> listofNames = [''];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateList();
  }

  Future initiateList() async {
    if (!(listofNames.length > 1)) listofNames = await CityList().getCityList();

    setState(() {
      listofNames.add('');
    });

    print(listofNames[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Sunrising.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      height: 350.0,
                      child: SingleChildScrollView(
                        child: AutoSearchInput(
                          fontSize: 20.0,
                          unSelectedTextColor: Colors.white,
                          selectedTextColor: Colors.white,
                          // enabledBorderColor: Colors.white,
                          itemsShownAtStart: 6,
                          data: listofNames,
                          maxElementsToDisplay: 10,
                          onSubmitted: (String cityname) {
                            print("onsubmmitted");
                          },
                          onEditingComplete: () {
                            print("on Editing done");
                          },
                          onItemTap: (int index) {
                            int ind = listofNames[index].indexOf(' ');
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            setState(() {
                              _cityName = listofNames[index]
                                  .toString()
                                  .substring(0, ind);
                            });

                            print(_cityName);
                          },
                        ),
                      ),
                    ),

                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        Provider.of<WeatherInformer>(context, listen: false)
                            .getLocationWeatherInfo(cityName: this._cityName);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TextField(
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                   decoration: kTextFieldInputDecoration,
//                   onChanged: (value) {
//                     cityName = value;
//                   },
//                 ),