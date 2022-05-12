import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/controllers/gas_station_list_controller.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/gas_station_list_screen.dart';
import 'package:provider/provider.dart';

class GasStationListProvider extends StatefulWidget {
  const GasStationListProvider({Key? key}) : super(key: key);

  @override
  State<GasStationListProvider> createState() => _GasStationListProviderState();
}

class _GasStationListProviderState extends State<GasStationListProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GasStationListController>(
          create: (context) => GasStationListController(),
        ),
      ],
      child: const GasStationListScreen(),
    );
  }
}
