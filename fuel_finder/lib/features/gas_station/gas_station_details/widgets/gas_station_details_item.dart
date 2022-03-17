import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_colors.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/models/gas_station_details_data.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/widgets/gas_station_details_icon.dart';

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
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GasStationDetailsIcon(icon: icon),
                Container(
                  padding: const EdgeInsets.only(left: AppSizes.paddingLarge, top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...item.map(
                        (e) => Text(
                          e.gasStationDetailsItem,
                          style: const TextStyle(
                            color: AppColors.coreGrey,
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
