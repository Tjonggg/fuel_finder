import 'package:fuel_finder/features/gas_station/shared/controllers/gas_station_favorites_notifier.dart';
import 'package:fuel_finder/main.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';

class GasStationFavoriteManager {
  final gasStationFavoritesNotifier = GasStationFavoritesNotifier();
  final _storageProvider = getIt<StorageProvider>();

  Future<void> initFavorite({required int id}) async {
    gasStationFavoritesNotifier.value = await _storageProvider.isFavorite(id: id);
  }

  void updateFavoriteStatus({required int id}) {
    gasStationFavoritesNotifier.toggleFavoriteStatus(id: id);
  }
}
