import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/constants/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'geolocator_wrapper.dart';

@injectable
class LocationBloc extends Bloc<LocationBlocEvent, LocationBlocState> {
  final GeolocatorWrapper geolocator;
  StreamSubscription? positionStream;

  LocationBloc({
    required this.geolocator,
  }) : super(const LocationBlocState(newPosition: null)) {
    on<StartLocationListeningEvent>(_onStartLocationListeningEvent);
    on<NewLocationListeningEvent>(_onNewLocationListeningEvent);
    on<StopLocationListeningEvent>(_onStopLocationListeningEvent);
  }

  void _onStartLocationListeningEvent(StartLocationListeningEvent event, Emitter emit) {
    if (positionStream == null) {
      _initLocationStream();
    } else {
      positionStream!.resume();
    }
  }

  void _onNewLocationListeningEvent(NewLocationListeningEvent event, Emitter emit) {
    emit(LocationBlocState(newPosition: event.newPosition));
  }

  void _onStopLocationListeningEvent(StopLocationListeningEvent event, Emitter emit) {
    if (positionStream != null) {
      print('Pause stream');
      positionStream!.pause();
    }
    print('Stop listening, locationState is null');
    emit(const LocationBlocState(newPosition: null));
  }

  void _initLocationStream() {
    positionStream = geolocator
        .getPositionStream(
          locationSettings: AppPreferences.highLocationAccuracySettings,
        )
        .distinct((previous, next) => previous.latitude == next.latitude && previous.longitude == next.longitude) //TODO: distinct doesn't work, WHY?
        .throttleTime(const Duration(seconds: 2))
        .listen(
      (Position position) {
        print(position);
        add(NewLocationListeningEvent(position));
      },
    );
  }
}

class LocationBlocEvent {
  const LocationBlocEvent();
}

class StartLocationListeningEvent extends LocationBlocEvent {}

class NewLocationListeningEvent extends LocationBlocEvent {
  final Position newPosition;

  NewLocationListeningEvent(this.newPosition);
}

class StopLocationListeningEvent extends LocationBlocEvent {}

class LocationBlocState {
  final Position? newPosition;

  const LocationBlocState({
    required this.newPosition,
  });
}
