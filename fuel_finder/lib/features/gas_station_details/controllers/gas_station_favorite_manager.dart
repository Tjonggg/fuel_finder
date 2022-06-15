import 'package:fuel_finder/features/gas_station/gas_station_details/controllers/gas_station_favorite_notifier.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';

class GasStationFavoriteManager {
  final StorageProvider storageProvider;
  final gasStationFavoriteNotifier = GasStationFavoriteNotifier();

  GasStationFavoriteManager(this.storageProvider);

  Future<void> initFavorite({required int id}) async {
    gasStationFavoriteNotifier.value = await storageProvider.isFavorite(id: id);
  }

  Future<bool> isFavorite({required int id}) async {
    return await storageProvider.isFavorite(id: id);
  }

  void updateFavoriteStatus({required int id}) {
    gasStationFavoriteNotifier.toggleFavoriteStatus(id: id);
  }
}
