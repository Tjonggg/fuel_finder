import 'package:bloc/bloc.dart';
import 'package:fuel_finder/services/location_provider/bloc/location_event.dart';
import 'package:fuel_finder/services/location_provider/bloc/location_state.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationStateLoading()) {
    on<LocationEventInit>(
      (event, emit) async {
        final _permission = await Permission.location.status;
        if (_permission.isGranted || _permission.isLimited) {
          emit(const LocationStatePermitted());
        } else {
          emit(const LocationStateNotPermitted());
        }
      },
    );
    on<LocationEventStartListening>(
      (event, emit) {
        emit(const LocationStateStreaming());
      },
    );
    on<LocationEventStopListening>(
      (event, emit) {
        emit(const LocationStateNotStreaming());
      },
    );
  }
}
