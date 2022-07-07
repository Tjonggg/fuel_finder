import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';
import 'package:fuel_finder/services/location_provider/location_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class GasStationListBloc extends Bloc<GasStationListBlocEvent, GasStationListBlocState> {
  final ApiManager apiManager;
  final LocationBloc locationBloc;

  List<GasStationData>? _gasStationList;
  Position? _lastKnownPosition;
  final _customDelayStream = BehaviorSubject<String>();

  GasStationListBloc({
    required this.apiManager,
    required this.locationBloc,
  }) : super(const GasStationListBlocState([])) {
    on<_ShowGasStationListEvent>(_onShowGasStationListEvent);
    on<_ShowLocationGasStationListEvent>(_onShowLocationGasStationListEvent);
    on<_ShowFilteredGasStationListEvent>(_onShowFilteredGasStationListEvent);

    add(_ShowGasStationListEvent());

    // searchBloc.stream.listen(
    //   (state) {
    //     if (state.filteredList.isNotEmpty) {
    //       locationBloc.add(StopLocationListeningEvent());
    //       add(_ShowFilteredGasStationListEvent(state.filteredList));
    //     }
    //   },
    // );
    _customDelayStream.stream.distinct().debounceTime(const Duration(seconds: 1)).listen(
      (debouncedString) {
        add(_ShowFilteredGasStationListEvent(debouncedString));
      },
    );

    locationBloc.stream.listen(
      (state) {
        if (state.newPosition != null) {
          final _newDistance = locationBloc.geolocator.distanceBetween(
            _lastKnownPosition!.latitude,
            _lastKnownPosition!.longitude,
            state.newPosition!.latitude,
            state.newPosition!.longitude,
          );
          if (_newDistance > 100) {
            print('100 m difference!');
            _lastKnownPosition = state.newPosition;
            add(_ShowLocationGasStationListEvent());
          }
        }
      },
    );
  }

  void _onShowGasStationListEvent(_, Emitter emit) async {
    final _isLocationPermissionOk = await _checkLocationPermission();
    if (_isLocationPermissionOk) {
      if (_gasStationList == null || _lastKnownPosition == null) {
        try {
          await _initGasStationListBloc();
        } catch (e) {
          throw Exception("Couldn't init gasstationlist and lastknownposition");
        }
      }
      locationBloc.add(StartLocationListeningEvent());
      add(_ShowLocationGasStationListEvent());
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

  void _onShowLocationGasStationListEvent(_ShowLocationGasStationListEvent event, Emitter emit) {
    print('Nieuwe lijst');
    emit(GasStationListBlocState(_sortLocationGasStationList()));
  }

  void _onShowFilteredGasStationListEvent(_ShowFilteredGasStationListEvent event, Emitter emit) {
    emit(GasStationListBlocState(_filterGasStationList(event.searchInput)));
  }

  void onTextFieldChanged(String textFieldInput) {
    //var _gasStationSearchData = GasStationSearchData('', []);

    if (textFieldInput.isNotEmpty) {
      // _gasStationSearchData.searchInput = textFieldInput;
      // _gasStationSearchData.searchList = _gasStationList!;
      // searchBloc.onTextFieldInput(_gasStationSearchData);
      _customDelayStream.add(textFieldInput);
    } else {
      add(_ShowGasStationListEvent());
    }
  }

  List<GasStationData> _filterGasStationList(String textFieldInput) {
    final filteredList = _gasStationList!.where(
      (gasStationData) {
        if (gasStationData.name.toLowerCase().contains(textFieldInput.toLowerCase())) {
          return true;
        } else if (gasStationData.street.toLowerCase().contains(textFieldInput.toLowerCase())) {
          return true;
        } else if (gasStationData.city.toLowerCase().contains(textFieldInput.toLowerCase())) {
          return true;
        }
        return false;
      },
    ).toList();
    return filteredList;
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

  List<GasStationData> _sortLocationGasStationList() {
    double _distanceToLastKnowPosition = 0;
    for (var _gasStationListDistance in _gasStationList!) {
      _distanceToLastKnowPosition = locationBloc.geolocator.distanceBetween(
          _lastKnownPosition!.latitude, _lastKnownPosition!.longitude, _gasStationListDistance.latitude, _gasStationListDistance.longitude);
      _gasStationListDistance.distance = _distanceToLastKnowPosition.toStringAsFixed(0);
    }
    _gasStationList!.sort(
      ((a, b) {
        final intA = int.parse(a.distance as String);
        final intB = int.parse(b.distance as String);
        return intA.compareTo(intB);
      }),
    );
    for (var _gasStationListDistanceFormat in _gasStationList!) {
      final _toDouble = double.parse(_gasStationListDistanceFormat.distance as String);
      if (_toDouble > 999) {
        final _temp = _toDouble / 1000;
        _gasStationListDistanceFormat.distance = '${_temp.toStringAsFixed(1)} km';
      } else {
        _gasStationListDistanceFormat.distance = '${_toDouble.toStringAsFixed(0)} m';
      }
    }
    return _gasStationList!;
  }
}

class GasStationListBlocEvent {}

class _ShowGasStationListEvent extends GasStationListBlocEvent {}

class _ShowLocationGasStationListEvent extends GasStationListBlocEvent {}

class _ShowFilteredGasStationListEvent extends GasStationListBlocEvent {
  final String searchInput;

  _ShowFilteredGasStationListEvent(this.searchInput);
}

class GasStationListBlocState {
  final List<GasStationData> gasStationList;

  const GasStationListBlocState(this.gasStationList);
}
