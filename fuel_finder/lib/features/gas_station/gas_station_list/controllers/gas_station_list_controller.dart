import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/shared/models/gas_station_data.dart';
import 'package:fuel_finder/main.dart';
import 'package:fuel_finder/services/api_provider/gas_station_api.dart';
import 'package:fuel_finder/services/location_provider/location_provider.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';
import 'package:geolocator/geolocator.dart';

class GasStationListController {
  //TODO add dispose of all the streams
  List<GasStationData>? _gasStationList;
  static bool enableLocationRefresh = true;
  final ValueNotifier<bool> showFavoritesList = ValueNotifier<bool>(false);

  final LocationProvider _locationProvider = LocationProvider();

  final StreamController<List<GasStationData>> _getGasStationListStreamController = StreamController<List<GasStationData>>.broadcast();
  Stream<List<GasStationData>> get getGasStationListStream => _getGasStationListStreamController.stream;

  Future<void> initGasStationList() async {
    try {
      _gasStationList = await GasStationApi().getGasStationList();
    } catch (e) {
      throw Exception("Couldn't fetch gas station list: $e");
    }

    if (_gasStationList != null) {
      _gasStationList!.sort(((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));

      _getGasStationListStreamController.add(_gasStationList!);

      _refreshGasStationList();
    }
  }

  void _refreshGasStationList() {
    double _distance;

    _locationProvider.initLocationProvider();
    _locationProvider.refreshPositionStream.listen(
      (position) async {
        if (enableLocationRefresh) {
          for (var _gasStationListItem in _gasStationList!) {
            _distance =
                Geolocator.distanceBetween(position.latitude, position.longitude, _gasStationListItem.latitude, _gasStationListItem.longitude);

            _distance = _distance;
            _gasStationListItem.distance = _distance;
          }

          _gasStationList!.sort(((a, b) => a.distance!.compareTo(b.distance!)));

          _getGasStationListStreamController.add(_gasStationList!);
        }
      },
    );
  }

  void onTextFieldChanged(String value) {
    if (value == '') {
      enableLocationRefresh = true;
    } else {
      enableLocationRefresh = false;
      if (_gasStationList != null) {
        _getGasStationListStreamController.add(_gasStationList!.where(
          (string) {
            if (string.name.toLowerCase().contains(value.toLowerCase())) {
              return true;
            } else if (string.street.toLowerCase().contains(value.toLowerCase())) {
              return true;
            } else if (string.city.toLowerCase().contains(value.toLowerCase())) {
              return true;
            }
            return false;
          },
        ).toList());
      }
    }
  }

  Future<void> toggleFavoriteList() async {
    final _storageProvider = getIt<StorageProvider>();
    final _favoritesList = await _storageProvider.getFavoritesList();

    if (_gasStationList == null) {
      try {
        _gasStationList = await GasStationApi().getGasStationList();
      } catch (e) {
        throw Exception("Couldn't fetch gas station list: $e");
      }
    }

    if (!showFavoritesList.value) {
      _getGasStationListStreamController.add(_gasStationList!.where(
        (value) {
          if (_favoritesList.contains(value.id.toString())) {
            return true;
          }
          return false;
        },
      ).toList());

      showFavoritesList.value = true;
    } else {
      _getGasStationListStreamController.add(_gasStationList!);
      showFavoritesList.value = false;
    }
  }
}
