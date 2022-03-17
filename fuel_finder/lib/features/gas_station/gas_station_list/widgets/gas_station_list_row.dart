import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/gas_station_details_screen.dart';
import 'package:fuel_finder/features/gas_station/shared/models/gas_station_data.dart';
import 'package:fuel_finder/features/gas_station/shared/widgets/gas_station_logo.dart';

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
            GasStationLogo(
              logoUrl: gasStationData.logo,
              logoWidth: 50,
            ),
            gasStationData.distance != null
                ? Text(
                    (() {
                      // remove from UI
                      if (gasStationData.distance! > 999) {
                        final _temp = gasStationData.distance! / 1000;
                        return '${_temp.toStringAsFixed(1)} km';
                      } else {
                        return '${gasStationData.distance!.toStringAsFixed(0)} m';
                      }
                    }()),
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
