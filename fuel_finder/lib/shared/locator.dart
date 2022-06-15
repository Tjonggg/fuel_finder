import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/gas_station_details/gas_station_details_screen.dart';
import '../services/storage_provider/storage_provider.dart';

class Locator extends StatelessWidget {
  const Locator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageManager>(
          create: (context) => StorageManager(),
        ),
      ],
      child: const GasStationDetailsScreen(),
    );
  }
}
