import 'package:flutter/material.dart';

class GasStationLogo extends StatelessWidget {
  final String logoUrl;
  final double logoWidth;

  const GasStationLogo({
    Key? key,
    required this.logoUrl,
    required this.logoWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: logoWidth,
      child: logoUrl == ''
          ? const Text(
              'No logo',
              textAlign: TextAlign.center,
            )
          : Image.network(logoUrl),
    );
  }
}
