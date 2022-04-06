import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  //TODO: _favoritesList, _storageList OK?
  static const _favoritesListKey = 'favorites';

  Future<bool> isFavorite({required int id}) async {
    final List<String> _favoritesList = await getFavoritesList();

    if (_favoritesList.contains(id.toString())) {
      return true;
    }

    return false;
  }

  Future<List<String>> getFavoritesList() async {
    final _storageList = await SharedPreferences.getInstance();
    List<String>? _favoritesList = _storageList.getStringList(_favoritesListKey);

    if (_favoritesList == null) {
      _storageList.setStringList(_favoritesListKey, <String>[]);
      _favoritesList = _storageList.getStringList(_favoritesListKey);
    }

    return _favoritesList!;
  }

  Future<void> updateFavoriteStatus({required int id, required bool status}) async {
    final List<String> _favoritesList = await getFavoritesList();
    final _storageList = await SharedPreferences.getInstance();

    if (status) {
      _favoritesList.add(id.toString());
      _storageList.setStringList(_favoritesListKey, _favoritesList);
    } else {
      _favoritesList.remove(id.toString());
      _storageList.setStringList(_favoritesListKey, _favoritesList);
    }
  }
}
