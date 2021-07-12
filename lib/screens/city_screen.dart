import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:auto_search/auto_search.dart';
import 'package:clima/services/citys_list.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  List<String> listofNames = [''];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateList();
  }

  Future initiateList() async {
    listofNames = await CityList().getCityList();
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
            image: AssetImage('images/Snowy.jpg'),
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
                          itemsShownAtStart: 6,
                          data: listofNames,
                          maxElementsToDisplay: 10,
                          onItemTap: (int index) {
                            print(listofNames[index]);
                            int ind = listofNames[index].indexOf(' ');

                            setState(() {
                              cityName = listofNames[index]
                                  .toString()
                                  .substring(0, ind);
                            });
                            print(cityName);
                          },
                        ),
                      ),
                    ),

                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context, cityName);
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