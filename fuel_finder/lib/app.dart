import 'package:flutter/material.dart';

import 'constants/constants.dart';
import 'features/gas_station_details/gas_station_details.dart';
import 'features/gas_station_list/gas_station_list.dart';

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
      home: const Locator(),
      routes: {
        GasStationListScreen.id: (context) => const Locator(),
        GasStationDetailsScreen.id: (context) => const GasStationDetailsScreen(),
      },
      initialRoute: GasStationListScreen.id,
      navigatorObservers: [routeObserver],
    );
  }
}