import 'package:shared_preferences/shared_preferences.dart';

class GasStationFavoritesController {
  bool isFavorites = false;

  // Future<void> _initFavorites() async {
  //   final _favorites = await SharedPreferences.getInstance();
  //   final List<String>? _favoritesList = _favorites.getStringList('favorites');

  //   print(widget.gasStationId);
  //   //_favorites.setStringList('favorites', <String>['3108']);

  //   if (_favoritesList != null) {
  //     _favoritesList.remove('3111');
  //     _isFavorite = _favoritesList.contains(widget.gasStationId.toString());
  //     if (_isFavorite) {
  //       setState(() {
  //         _isFavorite = true;
  //       });
  //     }
  //   }
  // }

  void changeFavorites() {
    // setState(() { _myState = newValue; });
    if (isFavorites) {
      isFavorites = false;
    } else {
      isFavorites = true;
    }
  }
}
