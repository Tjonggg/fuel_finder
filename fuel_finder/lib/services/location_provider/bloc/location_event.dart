import 'package:flutter/foundation.dart' show immutable;
import 'package:geolocator/geolocator.dart';

@immutable
abstract class LocationEvent {
  const LocationEvent();
}

class LocationEventInit extends LocationEvent {
  const LocationEventInit();
}

class LocationEventStartListening extends LocationEvent {
  final Position position;
  const LocationEventStartListening(this.position);
}

class LocationEventStopListening extends LocationEvent {
  const LocationEventStopListening();
}
