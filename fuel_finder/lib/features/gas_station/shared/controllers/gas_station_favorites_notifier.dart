import 'package:flutter/material.dart';
import 'package:fuel_finder/main.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';

class GasStationFavoritesNotifier extends ValueNotifier<bool> {
  final _storageProvider = getIt<StorageProvider>();

  GasStationFavoritesNotifier() : super(false);

  Future<void> toggleFavoriteStatus({required int id}) async {
    value = !value;
    _storageProvider.updateFavoriteStatus(id: id, status: value);
  }
}
