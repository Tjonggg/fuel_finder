import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/gas_station_details_screen.dart';
import 'package:fuel_finder/features/gas_station/models/gas_station_data.dart';

class GasStationListRow extends StatelessWidget {
  final GasStationData gasStationData;

  const GasStationListRow({
    Key? key,
    required this.gasStationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.redAccent,
          ),
        ),
      ),
      child: ListTile(
        leading: Column(
          children: [
            SizedBox(
              width: 50,
              child: gasStationData.logo != ''
                  ? Image.network(gasStationData.logo)
                  : const Text('Logo missing'), //TODO: https://pub.dev/packages/cached_network_image
            ),
            gasStationData.distance != null
                ? Text(
                    '${gasStationData.distance!.toStringAsFixed(0)} m',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        title: Text(
          gasStationData.name,
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${gasStationData.street}, ${gasStationData.city}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
        trailing: const Text(
          '>', //TODO: change to something nice
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            GasStationDetailsScreen.id,
            arguments: gasStationData,
          );
        },
      ),
    );
  }
}
