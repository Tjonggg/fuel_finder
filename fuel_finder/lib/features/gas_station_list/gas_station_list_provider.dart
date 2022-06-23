import 'package:flutter/material.dart';
import 'package:fuel_finder/di/injection.dart';
import 'package:fuel_finder/features/gas_station_list/controllers/gas_station_list_controller.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';
import 'package:fuel_finder/services/location_provider/location_bloc.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';
import 'package:provider/provider.dart';

class GasStationListProvider extends StatelessWidget {
  const GasStationListProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GasStationListController>(
          create: (_) => GasStationListController(
            storageManager: getIt<StorageManager>(),
            gasStationApi: getIt<ApiManager>(),
            locationProvider: getIt<LocationBloc>(),
          ),
        ),
        Provider<SearchBloc>(
          create: (_) => SearchBloc(getIt<ApiManager>()),
        ),
      ],
      child: const GasStationListScreen(),
    );
  }
}
