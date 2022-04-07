import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/controllers/gas_station_list_controller.dart';

class GasStationAppBarFavoritesListToggle extends StatelessWidget {
  final GasStationListController gasStationListController;

  // ignore: use_key_in_widget_constructors
  const GasStationAppBarFavoritesListToggle(this.gasStationListController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.appBarIconPadding),
      child: GestureDetector(
        onTap: () {
          gasStationListController.toggleFavoriteList();
        },
        child: ValueListenableBuilder(
          //TODO is there a better way?
          valueListenable: gasStationListController.showFavoritesList,
          builder: (_, __, ___) {
            return Icon(gasStationListController.showFavoritesList.value ? Icons.bookmark : Icons.bookmark_border);
          },
        ),
      ),
    );
  }
}
