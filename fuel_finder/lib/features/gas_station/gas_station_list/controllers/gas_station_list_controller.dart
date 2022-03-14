import 'dart:async';

import 'package:fuel_finder/features/gas_station/gas_station_list/models/gas_station_list_data.dart';
import 'package:fuel_finder/services/api_provider/gas_station_api.dart';
import 'package:fuel_finder/services/location_provider/location_provider.dart';
import 'package:geolocator/geolocator.dart';

class GasStationListController {
  List<GasStationListData> _gasStationList = [];

  final LocationProvider _locationProvider = LocationProvider();

  final StreamController<List<GasStationListData>>
      _getGasStationListStreamController =
      StreamController<List<GasStationListData>>();
  Stream<List<GasStationListData>> get getGasStationListStream =>
      _getGasStationListStreamController.stream;

  Future<void> initGasStationList() async {
    _gasStationList = await GasStationApi().getGasStationList();

    _gasStationList
        .sort(((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));

    _getGasStationListStreamController.add(_gasStationList);

    _refreshGasStationList();
  }

  void _refreshGasStationList() {
    double _distance;

    _locationProvider.initLocationProvider();
    _locationProvider.refreshPositionStream.listen(
      (position) async {
        _gasStationList = await GasStationApi()
            .getGasStationList(); //TODO: change to storage list

        for (var _gasStationListItem in _gasStationList) {
          _distance = Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              _gasStationListItem.latitude,
              _gasStationListItem.longitude);

          _distance = _distance / 10000; //TODO: delete after test!!!
          _gasStationListItem.distance = _distance;
        }

        _gasStationList.sort(((a, b) => a.distance!.compareTo(b.distance!)));

        _getGasStationListStreamController.add(_gasStationList);
      },
    );
  }
}
