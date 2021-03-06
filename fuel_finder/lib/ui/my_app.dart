import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/constants.dart';
import 'package:fuel_finder/features/gas_station_details/gas_station_details.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel finder',
      theme: ThemeData(
        primarySwatch: AppColors.coreRed,
      ),
      home: const GasStationListProvider(),
      routes: {
        GasStationListScreen.id: (_) => const GasStationListProvider(),
        GasStationDetailsScreen.id: (_) => const GasStationDetailsProvider(),
      },
      initialRoute: GasStationListScreen.id,
      navigatorObservers: [routeObserver],
    );
  }
}
