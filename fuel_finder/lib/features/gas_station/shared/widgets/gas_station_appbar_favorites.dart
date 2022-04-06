import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station/shared/controllers/gas_station_favorites_manager.dart';
import 'package:fuel_finder/main.dart';

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
  final _gasStationFavoriteManager = getIt<GasStationFavoriteManager>();

  @override
  void initState() {
    super.initState();

    _gasStationFavoriteManager.initFavorite(id: widget.gasStationId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.appBarIconPadding),
      child: GestureDetector(
        onTap: () {
          _gasStationFavoriteManager.updateFavoriteStatus(id: widget.gasStationId);
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: _gasStationFavoriteManager.gasStationFavoritesNotifier,
          builder: (_, isFavorite, __) {
            return Icon(isFavorite ? Icons.favorite_outlined : Icons.favorite_outline);
          },
        ),
      ),
    );
  }
}
