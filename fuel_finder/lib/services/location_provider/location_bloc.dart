import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/constants/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import 'geolocator_wrapper.dart';

@injectable
class LocationBloc extends Bloc<LocationBlocEvent, LocationBlocState> {
  final GeolocatorWrapper geolocator;
  StreamSubscription? _positionSubscription;

  LocationBloc({
    required this.geolocator,
  }) : super(const LocationBlocState(currentPosition: null)) {
    on<StartLocationListeningEvent>(_onStartLocationListeningEvent);
    on<StopLocationListeningEvent>(_onStopLocationListeningEvent);
  }

  void _onStartLocationListeningEvent(StartLocationListeningEvent event, Emitter emit) {
    _positionSubscription = geolocator
        .getPositionStream(
      locationSettings: AppPreferences.highLocationAccuracySettings,
    )
        .listen(
      (position) {
        print('TEST: $position');
        //emit(LocationBlocState(currentPosition: position));
      },
    );
  }

  void _onStopLocationListeningEvent(StopLocationListeningEvent event, Emitter emit) {
    _positionSubscription?.cancel();
    emit(const LocationBlocState(currentPosition: null));
  }
}

class LocationBlocEvent {
  const LocationBlocEvent();
}

class StartLocationListeningEvent extends LocationBlocEvent {
  const StartLocationListeningEvent();
}

class StopLocationListeningEvent extends LocationBlocEvent {
  const StopLocationListeningEvent();
}

class LocationBlocState {
  final Position? currentPosition;

  const LocationBlocState({
    required this.currentPosition,
  });
}
