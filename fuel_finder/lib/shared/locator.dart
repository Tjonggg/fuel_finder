import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/gas_station_details_screen.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';
import 'package:provider/provider.dart';

class Locator extends StatelessWidget {
  const Locator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageProvider>(
          create: (context) => StorageProvider(),
        ),
      ],
      child: const GasStationDetailsScreen(),
    );
  }
}
