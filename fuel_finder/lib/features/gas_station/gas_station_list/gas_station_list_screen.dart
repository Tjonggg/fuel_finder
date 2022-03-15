import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/controllers/gas_station_list_controller.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/models/gas_station_list_data.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/widgets/gas_station_list_row.dart';

class GasStationListScreen extends StatelessWidget {
  static const String id = 'gas_station_list_screen';

  const GasStationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Finder'),
      ),
      body: const GasStationListBuilder(),
    );
  }
}

class GasStationListBuilder extends StatelessWidget {
  const GasStationListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GasStationListController _gasStationListController =
        GasStationListController();

    _gasStationListController.initGasStationList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: TextField(
            textAlign: TextAlign.center,
            showCursor: false,
            onChanged: _gasStationListController.onTextFieldChanged,
            decoration: const InputDecoration(hintText: 'Search'),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: _gasStationListController.getGasStationListStream,
            builder:
                (context, AsyncSnapshot<List<GasStationListData>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot
                      .data!.length, //TODO: nice to have handle long list
                  itemBuilder: (context, index) {
                    return GasStationListRow(
                      name: snapshot.data![index].name,
                      street: snapshot.data![index].street,
                      city: snapshot.data![index].city,
                      logo: snapshot.data![index].logo,
                      id: snapshot.data![index].id,
                      distance: snapshot.data?[index].distance,
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
