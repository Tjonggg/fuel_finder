import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/controllers/gas_station_favorite_manager.dart';

class GasStationAppbarFavoriteToggle extends StatefulWidget {
  final int gasStationId;

  const GasStationAppbarFavoriteToggle({
    Key? key,
    required this.gasStationId,
  }) : super(key: key);

  @override
  State<GasStationAppbarFavoriteToggle> createState() => _GasStationAppbarFavoriteToggleState();
}

class _GasStationAppbarFavoriteToggleState extends State<GasStationAppbarFavoriteToggle> {
  final _gasStationFavoriteManager = GasStationFavoriteManager();

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
          valueListenable: _gasStationFavoriteManager.gasStationFavoriteNotifier,
          builder: (_, isFavorite, __) {
            return Icon(isFavorite ? Icons.favorite_outlined : Icons.favorite_outline);
          },
        ),
      ),
    );
  }
}
