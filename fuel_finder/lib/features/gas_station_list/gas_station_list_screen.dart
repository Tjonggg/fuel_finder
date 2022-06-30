import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/features/gas_station_list/widgets/gas_station_list_row.dart';
import 'package:fuel_finder/ui/ui.dart';
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

  // @override
  // void dispose() {
  //   routeObserver.unsubscribe(this);
  //   super.dispose();

  //   if (LocationProvider().positionStream != null) {
  //     LocationProvider().positionStream!.cancel();
  //   }
  // }

  // @override
  // void didPushNext() {
  //   if (LocationProvider().positionStream != null) {
  //     LocationProvider().positionStream!.cancel();
  //   }
  // }

  // @override
  // void didPopNext() {
  //   if (LocationProvider().refreshPosition != null) {
  //     LocationProvider().startLocationListener(refreshPostion: LocationProvider().refreshPosition!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Finder'),
        // actions: const [
        //   GasStationAppBarFavoritesListToggle(),
        // ],
      ),
      body: const GasStationListBuilder(),
    );
  }
}

class GasStationListBuilder extends StatelessWidget {
  const GasStationListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.center,
          showCursor: false,
          onChanged: Provider.of<GasStationListBloc>(context).onTextFieldChanged,
          decoration: const InputDecoration(hintText: 'Search'),
        ),
        Expanded(
          child: BlocBuilder<GasStationListBloc, GasStationListBlocState>(
            builder: (context, state) {
              if (state.gasStationList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: state.gasStationList.length,
                  itemBuilder: (context, index) {
                    return GasStationListRow(gasStationData: state.gasStationList[index]);
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
