import 'package:flutter/material.dart';

class GasStationDetailsItem extends StatelessWidget {
  const GasStationDetailsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Image'),
        Text('Text'),
      ],
    );
  }
}
