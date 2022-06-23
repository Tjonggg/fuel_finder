import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/constants/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import 'geolocator_wrapper.dart';

//TODO: go over this again
@injectable
class LocationBloc extends Bloc<LocationBlocEvent, LocationBlocState> {
  final GeolocatorWrapper geolocator;

  LocationBloc({
    required this.geolocator,
  }) : super(const LocationBlocState(currentPosition: null, lastKnownPosition: null)) {
    on<StopLocationListeningEvent>(_onStopLocationListeningEvent);
    on<StartLocationListeningEvent>(_onStartLocationListeningEvent);
  }

  void _onStartLocationListeningEvent(StartLocationListeningEvent event, Emitter emit) {
    geolocator
        .getPositionStream(
          locationSettings: AppPreferences.highLocationAccuracySettings,
        )
        .listen((position) => _onPositionChanged(position, emit));
  }

  void _onPositionChanged(Position currentPosition, Emitter emit) {
    final lastKnownPosition = state.lastKnownPosition;
    if (lastKnownPosition == null) {
      emit(LocationBlocState(lastKnownPosition: currentPosition, currentPosition: currentPosition));
    } else {
      emit(LocationBlocState(lastKnownPosition: lastKnownPosition, currentPosition: currentPosition));
    }
  }

  void _onStopLocationListeningEvent(StopLocationListeningEvent event, Emitter emit) {
    emit(const LocationBlocState(currentPosition: null, lastKnownPosition: null));
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
  final Position? lastKnownPosition;

  const LocationBlocState({
    required this.currentPosition,
    required this.lastKnownPosition,
  });
}
