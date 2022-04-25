import 'package:flutter/material.dart';
import 'package:fuel_finder/injection.dart';
import 'package:fuel_finder/services/storage_provider/storage_provider.dart';

class GasStationFavoriteNotifier extends ValueNotifier<bool> {
  final _storageProvider = getIt<StorageProvider>();

  GasStationFavoriteNotifier() : super(false);

  Future<void> toggleFavoriteStatus({required int id}) async {
    value = !value;
    _storageProvider.updateFavoriteStatus(id: id, status: value);
  }
}
