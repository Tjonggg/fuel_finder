import 'package:fuel_finder/di/injection.dart';
import 'package:fuel_finder/features/gas_station_details/controllers/gas_station_favorite_notifier.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';

class GasStationFavoriteManager {
  final gasStationFavoriteNotifier = GasStationFavoriteNotifier();
  final _storageProvider = getIt<StorageProvider>();

  Future<void> initFavorite({required int id}) async {
    gasStationFavoriteNotifier.value = await _storageProvider.isFavorite(id: id);
  }

  void updateFavoriteStatus({required int id}) {
    gasStationFavoriteNotifier.toggleFavoriteStatus(id: id);
  }
}
