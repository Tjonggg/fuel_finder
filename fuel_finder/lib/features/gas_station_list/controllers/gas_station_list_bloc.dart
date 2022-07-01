import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';
import 'package:fuel_finder/services/location_provider/location_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GasStationListBloc extends Bloc<GasStationListBlocEvent, GasStationListBlocState> {
  final ApiManager apiManager;
  final SearchBloc searchBloc;
  final LocationBloc locationBloc;

  List<GasStationData>? _gasStationList;
  Position? _lastKnownPosition;
  double _distance = 0;

  GasStationListBloc({
    required this.apiManager,
    required this.searchBloc,
    required this.locationBloc,
  }) : super(const GasStationListBlocState([])) {
    on<ShowGasStationListEvent>(_onShowGasStationListEvent);
    on<ShowLocationGasStationListEvent>(_onShowLocationGasStationListEvent);
    on<ShowFilteredGasStationListEvent>(_onShowFilteredGasStationListEvent);

    add(ShowGasStationListEvent());

    searchBloc.stream.listen(
      (state) {
        if (state.filteredList.isNotEmpty) {
          add(ShowFilteredGasStationListEvent(state.filteredList));
        }
      },
    );

    locationBloc.stream.listen(
      (state) {
        if (state.currentPosition != null) {
          //print('New location state: ${state.currentPosition}');

          //add(ShowLocationGasStationListEvent(currentPosition: state.currentPosition!));
        }
      },
    );
  }

  void _onShowGasStationListEvent(ShowGasStationListEvent event, Emitter emit) async {
    final _isLocationPermissionOk = await _checkLocationPermission();
    if (_isLocationPermissionOk) {
      if (_gasStationList == null || _lastKnownPosition == null) {
        try {
          await _initGasStationListBloc();
        } catch (e) {
          throw Exception("Couldn't init gasstationlist and lastknownposition");
        }
      }
      locationBloc.add(const StartLocationListeningEvent());
      add(ShowLocationGasStationListEvent(currentPosition: _lastKnownPosition!));
    } else {
      if (_gasStationList != null) {
        emit(GasStationListBlocState(_gasStationList!));
      } else {
        try {
          await _initGasStationListBloc();
          _gasStationList!.sort(((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));
        } catch (e) {
          _gasStationList = []; //TODO: improvement needed and local storage list?
          throw Exception("Couldn't fetch gas station list: $e");
        }
        emit(GasStationListBlocState(_gasStationList!));
      }
    }
  }

  void _onShowLocationGasStationListEvent(ShowLocationGasStationListEvent event, Emitter emit) {
    for (var _gasStationListDistance in _gasStationList!) {
      _distance = locationBloc.geolocator.distanceBetween(
          _lastKnownPosition!.latitude, _lastKnownPosition!.longitude, _gasStationListDistance.latitude, _gasStationListDistance.longitude);
      _gasStationListDistance.distance = _distance.toStringAsFixed(0);
    }
    _gasStationList!.sort(((a, b) {
      final intA = int.parse(a.distance as String);
      final intB = int.parse(b.distance as String);
      return intA.compareTo(intB);
    }));
    for (var _gasStationListDistanceFormat in _gasStationList!) {
      final _toDouble = double.parse(_gasStationListDistanceFormat.distance as String);
      if (_toDouble > 999) {
        final _temp = _toDouble / 1000;
        _gasStationListDistanceFormat.distance = '${_temp.toStringAsFixed(1)} km';
      } else {
        _gasStationListDistanceFormat.distance = '${_toDouble.toStringAsFixed(0)} m';
      }
    }

    emit(GasStationListBlocState(_gasStationList!));
  }

  void _onShowFilteredGasStationListEvent(ShowFilteredGasStationListEvent event, Emitter emit) {
    emit(GasStationListBlocState(event.filteredGasStationList));
  }

  void onTextFieldChanged(String textFieldInput) async {
    var _gasStationSearchData = GasStationSearchData('', []);

    if (textFieldInput.isNotEmpty) {
      _gasStationSearchData.searchInput = textFieldInput;
      _gasStationSearchData.searchList = _gasStationList!;
      searchBloc.onTextFieldInput(_gasStationSearchData);
    } else {
      add(ShowGasStationListEvent());
    }
  }

  Future<void> _initGasStationListBloc() async {
    _gasStationList = await apiManager.getGasStationList();
    _lastKnownPosition = await locationBloc.geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  //Nice to have: make a generic permission provider
  Future<bool> _checkLocationPermission() async {
    final _permission = await Permission.location.status;

    if (!_permission.isGranted || !_permission.isLimited) {
      try {
        await Permission.locationWhenInUse.request();
      } catch (e) {
        throw Exception('Something went wrong with device location permission: $e');
      }
    }

    if (_permission.isGranted || _permission.isLimited) {
      try {
        return true;
      } catch (e) {
        throw Exception('Error fetching device current position: $e');
      }
    }

    return false;
  }
}

class GasStationListBlocEvent {}

class ShowGasStationListEvent extends GasStationListBlocEvent {}

class ShowLocationGasStationListEvent extends GasStationListBlocEvent {
  final Position currentPosition;

  ShowLocationGasStationListEvent({
    required this.currentPosition,
  });
}

class ShowFilteredGasStationListEvent extends GasStationListBlocEvent {
  final List<GasStationData> filteredGasStationList;

  ShowFilteredGasStationListEvent(this.filteredGasStationList);
}

class GasStationListBlocState {
  final List<GasStationData> gasStationList;

  const GasStationListBlocState(this.gasStationList);
}
