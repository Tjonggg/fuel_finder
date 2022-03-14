import 'dart:async';

import 'package:fuel_finder/features/gas_station/gas_station_list/models/gas_station_list_data.dart';
import 'package:fuel_finder/services/api_provider/gas_station_api.dart';

class GasStationListController {
  List<GasStationListData> _gasStationList = [];

  final StreamController<List<GasStationListData>>
      _getGasStationListStreamController =
      StreamController<List<GasStationListData>>();
  Stream<List<GasStationListData>> get getGasStationListStream =>
      _getGasStationListStreamController.stream;

  Future<void> initGasStationList() async {
    _gasStationList = await GasStationApi().getGasStationList();
    _getGasStationListStreamController.add(_gasStationList);
  }
}
