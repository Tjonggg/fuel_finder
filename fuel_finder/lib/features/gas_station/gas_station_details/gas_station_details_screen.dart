import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/widgets/gas_station_details_item.dart';

class GasStationDetailsScreen extends StatelessWidget {
  static const String id = 'gas_station_details_screen';

  const GasStationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('Logo'),
              Column(
                children: [
                  Text('Name'),
                  Text('Street'),
                  Text('City'),
                ],
              ),
            ],
          ),
          GasStationDetailsItem(),
        ],
      ),
    );
  }
}
