import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:geolocator/geolocator.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.registerSingleton<Geolocator>(Geolocator());
  $initGetIt(getIt);
}
