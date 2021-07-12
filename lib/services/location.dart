import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentPostion() async {
    LocationPermission permission;
    bool islocationServiceEnabled;
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // if (await !Geolocator.isLocationServiceEnabled()) {
      //   throw Exception('Location Service is not Enabled ');
      // }
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      islocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!islocationServiceEnabled) {
        await Geolocator.openLocationSettings();
        if (islocationServiceEnabled) {
          latitude = position.latitude;
          longitude = position.longitude;
        }
      }
    }
  }
}
