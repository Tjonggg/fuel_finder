import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider {
  static const int _refreshDistance = 100;

  Position? _refreshPosition;
  Position? _position;

  static StreamSubscription<Position>? positionStream;

  final StreamController<Position> _refreshPositionStreamController =
      StreamController<Position>();
  Stream<Position> get refreshPositionStream =>
      _refreshPositionStreamController.stream;

  Future<void> initLocationProvider() async {
    final _permission = await Permission.location.status;

    if (!_permission.isGranted || !_permission.isLimited) {
      try {
        await Permission.locationWhenInUse.request();
      } catch (e) {
        throw Exception(
            'Something went wrong with device location permission: $e');
      }
    }

    if (_permission.isGranted || _permission.isLimited) {
      try {
        _position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        _refreshPosition = _position;
        startLocationListener(refreshPostion: _refreshPosition!);
      } catch (e) {
        throw Exception('Error fetching device current position: $e');
      }
    }
  }

  void startLocationListener({required Position refreshPostion}) {
    double _distance;

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen(
      (position) {
        _distance = Geolocator.distanceBetween(refreshPostion.latitude,
            refreshPostion.longitude, position.latitude, position.longitude);
        if (_distance > _refreshDistance) {
          _refreshPositionStreamController.add(position);
          _refreshPosition = position;
        }
      },
    );
  }
}
