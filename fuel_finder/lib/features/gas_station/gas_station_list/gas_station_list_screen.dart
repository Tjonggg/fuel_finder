import 'package:flutter/material.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/widgets/gas_station_appbar_favorites_list_toggle.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/controllers/gas_station_list_controller.dart';
import 'package:fuel_finder/features/gas_station/gas_station_list/widgets/gas_station_list_row.dart';
import 'package:fuel_finder/features/gas_station/shared/models/gas_station_data.dart';
import 'package:fuel_finder/main.dart';
import 'package:fuel_finder/services/location_provider/location_provider.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Finder'),
        actions: const [
          GasStationAppBarFavoritesListToggle(),
        ],
      ),
      body: const GasStationListBuilder(),
    );
  }
}

class GasStationListBuilder extends StatelessWidget {
  const GasStationListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _gasStationListProvider = Provider.of<GasStationListController>(context);
    _gasStationListProvider.initGasStationList();
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.center,
          showCursor: false,
          onChanged: _gasStationListProvider.onTextFieldChanged,
          decoration: const InputDecoration(hintText: 'Search'),
        ),
        Expanded(
          child: StreamBuilder(
            stream: _gasStationListProvider.getGasStationListStream,
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
