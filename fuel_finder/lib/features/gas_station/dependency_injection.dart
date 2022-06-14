import 'package:fuel_finder/services/api_provider/gas_station_api.dart';
import 'package:get_it/get_it.dart';

class GasStationsListDependencyInjection {

  void registerDependencies() {
     GetIt.instance.registerFactory(() => GasStationApi());
  }

}