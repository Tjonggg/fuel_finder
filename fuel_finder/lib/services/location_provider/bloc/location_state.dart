import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LocationState {
  const LocationState();
}

class LocationStateLoading extends LocationState {
  const LocationStateLoading();
}

class LocationStatePermitted extends LocationState {
  //final Permission locationPermission;
  const LocationStatePermitted();
}

class LocationStateNotPermitted extends LocationState {
  //final Permission locationPermission;
  const LocationStateNotPermitted();
}

class LocationStateStreaming extends LocationState {
  const LocationStateStreaming();
}

class LocationStateNotStreaming extends LocationState {
  const LocationStateNotStreaming();
}

// class LocationStateFailure extends LocationState {
//   final Exception locationStateException;
//   const LocationStateFailure(this.locationStateException);
// }
