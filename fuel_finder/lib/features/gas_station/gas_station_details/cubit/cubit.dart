import 'package:bloc/bloc.dart';

class FavoriteBloc extends Bloc<FavoriteBlocEvent, bool> {
  final StorageManager storageManager;

  FavoriteBloc(this.storageManager) : super(false) {
    add(InitEvent());
  }

  void userDidTapFavoriteToggle() {
    final newFavoriteStatus = !state;
    if (newFavoriteStatus == true) {
      add(UserDidSetThisStationAsFavorite());
    } else {
      add(UserRemovedStationFromHisFavorites());
    }
  }

  @override
  Stream<bool> mapEventToState(FavoriteBlocEvent event) async* {
    if (event is UserDidSetThisStationAsFavorite) {
      storageManager.setAsFavorite(stationId);
      yield true;
    }
    if (event is UserRemovedStationFromHisFavorites) {
      storageManager.removeFromFavorites(stationId);
      yield false;
    }
    if (event is InitEvent) {
      final isFavorite = await storageManager.isFavorite(someStationId);
      yield isFavorite;
    }
  }
}

class FavoriteBlocEvent {
  const FavoriteBlocEvent();
}

class UserDidSetThisStationAsFavorite extends FavoriteBlocEvent {
  final int stationId;

  const UserDidSetThisStationAsFavorite(this.stationId);
}

class UserRemovedStationFromHisFavorites extends FavoriteBlocEvent {
  final int stationId;

  const UserRemovedStationFromHisFavorites(this.stationId);
}

class InitEvent extends FavoriteBlocEvent {
  const InitEvent();
}
