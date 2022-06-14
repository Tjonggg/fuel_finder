import 'package:flutter/material.dart';
import 'package:fuel_finder/di/injection.dart';
import 'package:fuel_finder/services/storage_provider/storage_manager.dart';

class GasStationFavoriteNotifier extends ValueNotifier<bool> {
  final _storageProvider = getIt<StorageManager>();

  GasStationFavoriteNotifier() : super(false);

  Future<void> toggleFavoriteStatus({required int id}) async {
    value = !value;
    _storageProvider.updateFavoriteStatus(id: id, status: value);
  }
}
