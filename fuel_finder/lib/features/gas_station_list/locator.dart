import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station_list/controllers/gas_station_list_controller.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';
import 'package:provider/provider.dart';

class Locator extends StatelessWidget {
  const Locator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GasStationListController>(
          create: (_) => GasStationListController(),
        ),
        Provider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
      ],
      child: const GasStationListScreen(),
    );
  }
}
