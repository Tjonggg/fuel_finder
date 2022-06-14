import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_colors.dart';
import 'package:fuel_finder/di/injection.dart';
import 'package:fuel_finder/features/gas_station_details/gas_station_details_screen.dart';
import 'package:fuel_finder/features/gas_station_list/locator.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list_screen.dart';

void main() {
  configureDependencies();

  runApp(const MyApp());
}

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
