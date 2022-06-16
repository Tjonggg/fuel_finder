import 'package:fuel_finder/services/storage_provider/storage_manager.dart';

import 'gas_station_favorite_notifier.dart';

class GasStationFavoriteManager {
  final StorageManager storageManager;
  final gasStationFavoriteNotifier = GasStationFavoriteNotifier();

  GasStationFavoriteManager(this.storageManager);

  Future<void> initFavorite({required int id}) async {
    gasStationFavoriteNotifier.value = await storageManager.isFavorite(id: id);
  }

  Future<bool> isFavorite({required int id}) async {
    return await storageManager.isFavorite(id: id);
  }

  void updateFavoriteStatus({required int id}) {
    gasStationFavoriteNotifier.toggleFavoriteStatus(id: id);
  }
}
