import 'package:flutter/widgets.dart';
import 'package:fuel_finder/di/di.dart';
import 'package:fuel_finder/features/gas_station_details/gas_station_details.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';
import 'package:provider/provider.dart';

class GasStationDetailsProvider extends StatelessWidget {
  const GasStationDetailsProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => StorageManager(),
        ),
        Provider(
          create: (context) => GasStationFavoriteManager(
            storageManager: getIt<StorageManager>(),
          ),
        ),
      ],
      child: const GasStationDetailsScreen(),
    );
  }
}
