import 'package:clima/utilities/constants.dart';
import 'networking.dart';

class CityList {
  NetworkHelper networkHelper;
  List<String> _cityOfNames = [];
  String _temp = '';
  Future<List> getCityList() async {
    networkHelper = new NetworkHelper(url: kCityListApiUrl);

    var cityList =
        await networkHelper.getData(); // Gets city names from database

    for (int i = 0; i < cityList['data'].length; i++) {
      _temp = cityList['data'][i]['city'].toString();
      _temp += ' , ' + cityList['data'][i]['country'].toString();
      _cityOfNames.add(_temp);
    }

    return _cityOfNames;
  }
}
