import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

class NetworkHelper {
  NetworkHelper({this.url});
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.statusCode);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future<bool> checkData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
