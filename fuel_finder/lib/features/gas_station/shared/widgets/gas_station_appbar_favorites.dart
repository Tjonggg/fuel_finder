import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station/shared/controllers/gas_station_favorites_controller.dart';

class GasStationAppbarFavorites extends StatefulWidget {
  final int gasStationId;

  const GasStationAppbarFavorites({
    Key? key,
    required this.gasStationId,
  }) : super(key: key);

  @override
  State<GasStationAppbarFavorites> createState() => _GasStationAppbarFavoritesState();
}

class _GasStationAppbarFavoritesState extends State<GasStationAppbarFavorites> {
  @override
  Widget build(BuildContext context) {
    final _favorites = GasStationFavoritesController();

    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.appBarIconPadding),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _favorites.changeFavorites();
          });
        },
        child: _favorites.isFavorites ? const Icon(Icons.favorite_outlined) : const Icon(Icons.favorite_outline),
      ),
    );
  }
}
