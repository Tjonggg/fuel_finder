import 'package:flutter/material.dart';
import 'package:fuel_finder/di/di.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';
import 'package:fuel_finder/services/location_provider/location_provider.dart';
import 'package:provider/provider.dart';

class GasStationListProvider extends StatelessWidget {
  const GasStationListProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GasStationListBloc>(
          create: (_) => GasStationListBloc(
            apiManager: getIt<ApiManager>(),
            locationBloc: getIt<LocationBloc>(),
          ),
        ),
      ],
      child: const GasStationListScreen(),
    );
  }
}
