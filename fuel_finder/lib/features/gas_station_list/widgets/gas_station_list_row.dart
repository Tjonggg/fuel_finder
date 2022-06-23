import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_colors.dart';
import 'package:fuel_finder/features/gas_station_details/gas_station_details_screen.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/shared/widgets/gas_station_logo.dart';

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
            color: AppColors.coreRed,
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
                    gasStationData.distance!,
                    style: const TextStyle(
                      color: AppColors.coreGrey,
                      fontSize: 10,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        title: Text(
          gasStationData.name,
          style: const TextStyle(
            color: AppColors.coreRed,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${gasStationData.street}, ${gasStationData.city}',
          style: const TextStyle(
            color: AppColors.coreGrey,
            fontSize: 10,
          ),
        ),
        trailing: const Icon(
          Icons.navigate_next,
          color: AppColors.coreRed,
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
