import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station_list/controllers/gas_station_list_controller.dart';
import 'package:provider/provider.dart';

class GasStationAppBarFavoritesListToggle extends StatelessWidget {
  const GasStationAppBarFavoritesListToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _gasStationListProvider = Provider.of<GasStationListController>(context);
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.appBarIconPadding),
      child: GestureDetector(
        onTap: () {
          //_gasStationListProvider.toggleFavoriteList();
        },
        child: const Icon(Icons.bookmark),
        // child: ValueListenableBuilder(
        //   //TODO is there a better way?
        //   valueListenable: _gasStationListProvider.showFavoritesList,
        //   builder: (_, __, ___) {
        //     return Icon(_gasStationListProvider.showFavoritesList.value ? Icons.bookmark : Icons.bookmark_border);
        //   },
        // ),
      ),
    );
  }
}
