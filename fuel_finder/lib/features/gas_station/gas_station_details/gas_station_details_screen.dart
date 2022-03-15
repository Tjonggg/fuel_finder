import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/widgets/gas_station_details_item.dart';
import 'package:fuel_finder/features/gas_station/models/gas_station_data.dart';

class GasStationDetailsScreen extends StatelessWidget {
  static const String id = 'gas_station_details_screen';

  const GasStationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gasStationData =
        ModalRoute.of(context)!.settings.arguments as GasStationData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: gasStationData.logo != ''
                      ? Image.network(gasStationData.logo)
                      : const Text('Logo missing'), //TODO: this can be better
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gasStationData.name,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        gasStationData.street,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        gasStationData.city,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            //TODO: refactor code below!!!
            gasStationData.distance == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset('assets/icons/icon_distance.png',
                              fit: BoxFit.fitHeight),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 32.0, top: 0),
                          child: Text(
                            '${gasStationData.distance!.toStringAsFixed(0)} m',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            GasStationDetailsItem(
              icon: 'assets/icons/icon_products.png',
              item: gasStationData.products!,
            ),
            GasStationDetailsItem(
              icon: 'assets/icons/icon_payments.png',
              item: gasStationData.payments!,
            ),

            GasStationDetailsItem(
              icon: 'assets/icons/icon_extras.png',
              item: gasStationData.extras!,
            ),
          ],
        ),
      ),
    );
  }
}
