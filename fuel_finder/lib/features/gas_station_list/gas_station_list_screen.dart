import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/app.dart';
import 'package:fuel_finder/features/gas_station_list/widgets/gas_station_appbar_favorites_list_toggle.dart';
import 'package:fuel_finder/features/gas_station_list/widgets/gas_station_list_row.dart';
import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
import 'package:fuel_finder/services/location_provider/location_manager.dart';
import 'package:fuel_finder/shared/models/gas_station_data.dart';
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

    if (LocationManager().positionStream != null) {
      LocationManager().positionStream!.cancel();
    }
  }

  @override
  void didPushNext() {
    if (LocationManager().positionStream != null) {
      LocationManager().positionStream!.cancel();
    }
  }

  @override
  void didPopNext() {
    if (LocationManager().refreshPosition != null) {
      LocationManager().startLocationListener(refreshPostion: LocationManager().refreshPosition!);
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
    // final _gasStationListProvider = Provider.of<GasStationListController>(context);
    // _gasStationListProvider.initGasStationList();
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.center,
          showCursor: false,
          onChanged: Provider.of<SearchBloc>(context).onTextFieldChanged,
          decoration: const InputDecoration(hintText: 'Search'),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, List<GasStationData>>(
            builder: (context, gasStationList) {
              if (gasStationList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: gasStationList.length,
                  itemBuilder: (context, index) {
                    return GasStationListRow(gasStationData: gasStationList[index]);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
