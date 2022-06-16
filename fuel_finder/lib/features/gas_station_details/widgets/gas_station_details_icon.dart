import 'package:flutter/material.dart';

class GasStationDetailsIcon extends StatelessWidget {
  final String icon;

  const GasStationDetailsIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 25,
      child: Image.asset(
        icon,
        fit: BoxFit.contain,
      ),
    );
  }
}
