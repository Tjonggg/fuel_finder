import 'package:flutter/material.dart';

//TODO: nice to have, make theme and replace all const

class GasStationListRow extends StatelessWidget {
  final String name;
  final String street;
  final String city;
  final int id;
  final String? logo;
  final double? distance;

  const GasStationListRow({
    Key? key,
    required this.name,
    required this.street,
    required this.city,
    required this.id,
    this.logo,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.redAccent,
          ),
        ),
      ),
      child: ListTile(
        leading: Column(
          children: [
            SizedBox(
              width: 50,
              child: logo != ''
                  ? Image.network(logo!)
                  : const Text('Logo missing'), //TODO: this can be better
            ),
            distance != null
                ? Text(
                    '${distance!.toStringAsFixed(0)} m',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '$street $city',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
        trailing: const Text(
          '>', //TODO: change to something nice
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // onTap: () {},
      ),
    );
  }
}
