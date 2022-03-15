import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/models/gas_station_details_data.dart';

class GasStationDetailsItem extends StatelessWidget {
  final String icon;
  final List<GasStationDetailsData> item;

  const GasStationDetailsItem({
    Key? key,
    required this.icon,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(icon, fit: BoxFit.fill),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 32.0, top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...item.map(
                        (e) => Text(
                          e.gasStationDetailsItem,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
