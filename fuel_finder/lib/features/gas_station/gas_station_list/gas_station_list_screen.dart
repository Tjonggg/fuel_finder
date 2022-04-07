import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/widgets/gas_station_appbar_favorites_list_toggle.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/controllers/gas_station_list_controller.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/widgets/gas_station_list_row.dart';
import 'package:fuel_finder/features/gas_station/shared/models/gas_station_data.dart';
import 'package:fuel_finder/main.dart';
import 'package:fuel_finder/services/location_provider/location_provider.dart';

class GasStationListScreen extends StatefulWidget {
  static const String id = 'gas_station_list_screen';

  const GasStationListScreen({Key? key}) : super(key: key);

  @override
  State<GasStationListScreen> createState() => _GasStationListScreenState();
}

class _GasStationListScreenState extends State<GasStationListScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();

    if (LocationProvider.positionStream != null) {
      LocationProvider.positionStream!.cancel();
    }
  }

  @override
  void didPushNext() {
    if (LocationProvider.positionStream != null) {
      LocationProvider.positionStream!.cancel();
    }
  }

  @override
  void didPopNext() {
    if (LocationProvider.refreshPosition != null) {
      LocationProvider().startLocationListener(refreshPostion: LocationProvider.refreshPosition!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GasStationListController _gasStationListController = GasStationListController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Finder'),
        actions: [
          GasStationAppBarFavoritesListToggle(_gasStationListController),
        ],
      ),
      body: GasStationListBuilder(_gasStationListController),
    );
  }
}

class GasStationListBuilder extends StatelessWidget {
  final GasStationListController gasStationListController;

  // ignore: use_key_in_widget_constructors
  const GasStationListBuilder(this.gasStationListController);

  @override
  Widget build(BuildContext context) {
    gasStationListController.initGasStationList();
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.center,
          showCursor: false,
          onChanged: gasStationListController.onTextFieldChanged,
          decoration: const InputDecoration(hintText: 'Search'),
        ),
        Expanded(
          child: StreamBuilder(
            stream: gasStationListController.getGasStationListStream,
            builder: (context, AsyncSnapshot<List<GasStationData>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GasStationListRow(gasStationData: snapshot.data![index]);
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
