import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/constants/app_sizes.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/controllers/gas_station_favorite_manager.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/cubit/cubit.dart';
import 'package:provider/provider.dart';
import 'package:bloc/bloc.dart';

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
        onTap: Provider.of<FavoriteBloc>(context).userDidTapFavoriteToggle,
        child: BlocBuilder<FavoriteBloc, bool>(
          builder: (_, isFavorite) => Icon(isFavorite ? Icons.favorite_outlined : Icons.favorite_outline),
        ),
      ),
    );
  }
}
