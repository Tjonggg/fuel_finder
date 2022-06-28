import 'package:geolocator/geolocator.dart';

//Wrapper created because 'getPostionStream' a static method can't be accessed through an instance and dependency injection
class GeolocatorWrapper {
  Stream<Position> getPositionStream({
    LocationSettings? locationSettings,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    );
  }

  Future<Position> getCurrentPosition({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    bool forceAndroidLocationManager = false,
    Duration? timeLimit,
  }) {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: desiredAccuracy,
      forceAndroidLocationManager: forceAndroidLocationManager,
      timeLimit: timeLimit,
    );
  }

  double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}
