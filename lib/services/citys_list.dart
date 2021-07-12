import 'package:clima/utilities/constants.dart';

import 'networking.dart';
import 'dart:convert';

class CityList {
  NetworkHelper networkHelper;
  List<String> _cityOfNames = [];
  String _temp = '';
  Future<List> getCityList() async {
    networkHelper = new NetworkHelper(kCityListApiUrl);

    var cityList = await networkHelper.getData();

    for (int i = 0; i < cityList['data'].length; i++) {
      _temp = cityList['data'][i]['city'].toString();
      _temp += ' , ' + cityList['data'][i]['country'].toString();
      _cityOfNames.add(_temp);
    }
    print(_cityOfNames);
    return _cityOfNames;
  }
}
