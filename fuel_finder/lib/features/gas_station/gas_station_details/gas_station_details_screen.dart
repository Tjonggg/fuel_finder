import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_colors.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/widgets/gas_station_details_icon.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/widgets/gas_station_details_item.dart';
import 'package:fuel_finder/features/gas_station/shared/models/gas_station_data.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/widgets/gas_station_appbar_favorite_toggle.dart';
import 'package:fuel_finder/features/gas_station/shared/widgets/gas_station_logo.dart';

class GasStationDetailsScreen extends StatelessWidget {
  static const String id = 'gas_station_details_screen';

  const GasStationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _gasStationData = ModalRoute.of(context)!.settings.arguments as GasStationData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.coreRed,
        actions: [
          GasStationAppbarFavoriteToggle(
            gasStationId: _gasStationData.id,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingSmall),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GasStationLogo(
                    logoUrl: _gasStationData.logo,
                    logoWidth: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: AppSizes.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _gasStationData.name,
                          style: const TextStyle(
                            color: AppColors.coreRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _gasStationData.street,
                          style: const TextStyle(
                            color: AppColors.coreGrey,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          _gasStationData.city,
                          style: const TextStyle(
                            color: AppColors.coreGrey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.paddingLarge,
              ),
              _gasStationData.distance == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(AppSizes.paddingMedium),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GasStationDetailsIcon(icon: 'assets/icons/icon_distance.png'),
                          Container(
                            padding: const EdgeInsets.only(left: AppSizes.paddingLarge, top: 0),
                            child: Text(
                              (() {
                                if (_gasStationData.distance!.toStringAsFixed(0).length > 2) {
                                  final _temp = _gasStationData.distance! / 1000;
                                  return '${_temp.toStringAsFixed(1)} km';
                                } else {
                                  return '${_gasStationData.distance!.toStringAsFixed(0)} m';
                                }
                              }()),
                              style: const TextStyle(
                                color: AppColors.coreGrey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              GasStationDetailsItem(
                icon: 'assets/icons/icon_products.png',
                item: _gasStationData.products!,
              ),
              GasStationDetailsItem(
                icon: 'assets/icons/icon_payments.png',
                item: _gasStationData.payments!,
              ),
              GasStationDetailsItem(
                icon: 'assets/icons/icon_extras.png',
                item: _gasStationData.extras!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
