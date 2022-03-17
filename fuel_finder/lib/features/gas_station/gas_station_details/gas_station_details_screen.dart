import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_details/widgets/gas_station_details_item.dart';
import 'package:fuel_finder/features/gas_station/shared/models/gas_station_data.dart';
import 'package:fuel_finder/features/gas_station/shared/widgets/gas_station_logo.dart';

class GasStationDetailsScreen extends StatelessWidget {
  static const String id = 'gas_station_details_screen';

  const GasStationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gasStationData = ModalRoute.of(context)!.settings.arguments as GasStationData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GasStationLogo(
                    logoUrl: gasStationData.logo,
                    logoWidth: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gasStationData.name,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          gasStationData.street,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          gasStationData.city,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              //TODO: refactor code below!!!
              gasStationData.distance == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            //TODO: create icon widget
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/icons/icon_distance.png', fit: BoxFit.fitHeight),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 32.0, top: 0),
                            child: Text(
                              //TODO: don't forget to refactor here
                              (() {
                                if (gasStationData.distance!.toStringAsFixed(0).length > 2) {
                                  final _temp = gasStationData.distance! / 1000;
                                  return '${_temp.toStringAsFixed(1)} km';
                                } else {
                                  return '${gasStationData.distance!.toStringAsFixed(0)} m';
                                }
                              }()),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              GasStationDetailsItem(
                icon: 'assets/icons/icon_products.png', //TODO: put these away with the other const
                item: gasStationData.products!,
              ),
              GasStationDetailsItem(
                icon: 'assets/icons/icon_payments.png',
                item: gasStationData.payments!,
              ),
              GasStationDetailsItem(
                icon: 'assets/icons/icon_extras.png',
                item: gasStationData.extras!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}