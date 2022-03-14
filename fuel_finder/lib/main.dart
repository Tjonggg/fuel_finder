import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/gas_station_list_screen.dart';
import 'package:fuel_finder/services/api_provider/gas_station_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const GasStationListScreen(),
    );
  }
}
