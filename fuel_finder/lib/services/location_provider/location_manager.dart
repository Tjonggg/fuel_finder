import 'dart:async';

import 'package:fuel_finder/constants/constants.dart';
import 'package:fuel_finder/services/location_provider/geolocator_wrapper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LocationManager {
  final GeolocatorWrapper geolocator;

  //TODO: pause and resume stream!!!
  //StreamSubscription<Position>? _positionStreamSubscription;
  final _positionStreamController = StreamController<Position>.broadcast();
  Stream<Position> get positionStream => _positionStreamController.stream;

  LocationManager(this.geolocator);

  void playLocationStream() {
    // if (_positionStreamSubscription == null) {
    // _positionStreamSubscription = geolocator
    geolocator
        .getPositionStream(
          locationSettings: AppPreferences.highLocationAccuracySettings,
        )
        .distinct((previous, next) => previous.latitude == next.latitude && previous.longitude == next.longitude)
        .throttleTime(const Duration(seconds: 3))
        .listen(
      (Position position) {
        _positionStreamController.add(position);
      },
    );
    // } else {
    //   print('Resume position subscription');
    //   _positionStreamSubscription!.resume();
    // }
  }

  // void pauseLocationStream() {
  //   if (_positionStreamSubscription != null) {
  //     print('Pause position subscription');
  //     _positionStreamSubscription!.pause();
  //   }
  // }
}
