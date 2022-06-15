import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_colors.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/gas_station_details_screen.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/gas_station_list_provider.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/gas_station_list_screen.dart';

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
        GasStationListScreen.id: (context) => const GasStationListProvider(),
        GasStationDetailsScreen.id: (context) => const GasStationDetailsScreen(),
      },
      initialRoute: GasStationListScreen.id,
      navigatorObservers: [routeObserver],
    );
  }
}