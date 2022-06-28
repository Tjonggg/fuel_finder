import 'package:fuel_finder/services/location_provider/location_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.registerSingleton<GeolocatorWrapper>(GeolocatorWrapper());
  $initGetIt(getIt);
}
