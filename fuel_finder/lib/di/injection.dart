
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.registerLazySingleton<StorageProvider>(() => StorageProvider());
  $initGetIt(getIt);
}
