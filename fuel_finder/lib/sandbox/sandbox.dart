class StringHelper {
  String toUpperCase(String input) {
    return input.toUpperCase();
  }

  String toLowerCase(String input) {
    return input.toLowerCase();
  }
}

// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fuel_finder/constants/constants.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:rxdart/rxdart.dart';

// import 'geolocator_wrapper.dart';

// class LocationBloc extends Bloc<LocationBlocEvent, LocationBlocState> {
//   final GeolocatorWrapper geolocator;
//   StreamSubscription? _positionStream;

//   LocationBloc({
//     required this.geolocator,
//   }) : super(const LocationBlocState(newPosition: null)) {
//     on<StartLocationListeningEvent>(_onStartLocationListeningEvent);
//     on<NewLocationListeningEvent>(_onNewLocationListeningEvent);
//     on<StopLocationListeningEvent>(_onStopLocationListeningEvent);
//   }

//   void _onStartLocationListeningEvent(StartLocationListeningEvent event, Emitter emit) {
//     // if (_positionStream == null) {
//     //   print('Position stream init');
//     //   _initLocationStream();
//     // } else {
//     //   print('Resume position stream');
//     //   _positionStream!.resume();
//     // }
//     print('Start position stream');
//     _positionStream = geolocator
//         .getPositionStream(
//           locationSettings: AppPreferences.highLocationAccuracySettings,
//         )
//         .distinct((previous, next) => previous.latitude == next.latitude && previous.longitude == next.longitude)
//         .throttleTime(const Duration(seconds: 2))
//         .listen(
//       (Position position) {
//         add(NewLocationListeningEvent(position));
//       },
//     );
//   }

//   void _onNewLocationListeningEvent(NewLocationListeningEvent event, Emitter emit) {
//     emit(LocationBlocState(newPosition: event.newPosition));
//   }

//   Future<void> _onStopLocationListeningEvent(StopLocationListeningEvent event, Emitter emit) async {
//     if (_positionStream != null) {
//       print('Stop position stream');
//       await _positionStream!.cancel();
//     }
//     emit(const LocationBlocState(newPosition: null));
//   }

//   // void _initLocationStream() {
//   //   _positionStream = geolocator
//   //       .getPositionStream(
//   //         locationSettings: AppPreferences.highLocationAccuracySettings,
//   //       )
//   //       .distinct((previous, next) => previous.latitude == next.latitude && previous.longitude == next.longitude)
//   //       .throttleTime(const Duration(seconds: 2))
//   //       .listen(
//   //     (Position position) {
//   //       add(NewLocationListeningEvent(position));
//   //     },
//   //   );
//   // }
// }

// class LocationBlocEvent {
//   const LocationBlocEvent();
// }

// class StartLocationListeningEvent extends LocationBlocEvent {}

// class NewLocationListeningEvent extends LocationBlocEvent {
//   final Position newPosition;

//   NewLocationListeningEvent(this.newPosition);
// }

// class StopLocationListeningEvent extends LocationBlocEvent {}

// class LocationBlocState {
//   final Position? newPosition;

//   const LocationBlocState({
//     required this.newPosition,
//   });
// }
