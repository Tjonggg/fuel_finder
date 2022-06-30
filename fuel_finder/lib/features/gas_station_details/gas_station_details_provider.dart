import 'package:flutter/widgets.dart';
import 'package:fuel_finder/features/gas_station_details/gas_station_details.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';

class GasStationDetailsProvider extends StatelessWidget {
  const GasStationDetailsProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GasStationDetailsScreen(ModalRoute.of(context)!.settings.arguments as GasStationData);
  }
}
