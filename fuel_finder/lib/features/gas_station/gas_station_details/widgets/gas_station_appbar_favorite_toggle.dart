import 'package:flutter/material.dart';
import 'package:fuel_finder/constants/app_sizes.dart';

class GasStationAppbarFavoriteToggle extends StatelessWidget {
  final Function() onTap;
  final bool isFavorite;

  const GasStationAppbarFavoriteToggle({
    Key? key,
    required this.onTap,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.appBarIconPadding),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(isFavorite ? Icons.favorite_outlined : Icons.favorite_outline),
      ),
    );
  }
}
