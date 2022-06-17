import 'package:bloc/bloc.dart';
import 'package:fuel_finder/services/storage_provider/storage_manager.dart';

class FavoriteBloc extends Bloc<FavoriteBlocEvent, bool> {
  final StorageManager storageManager;
  final int stationId;

  FavoriteBloc(this.storageManager, {required this.stationId}) : super(false) {
    add(const InitEvent());
  }

  void userDidTapFavoriteToggle() {
    final newFavoriteStatus = !state;
    if (newFavoriteStatus == true) {
      add(const UserDidSetThisStationAsFavorite());
    } else {
      add(const UserRemovedStationFromHisFavorites());
    }
  }

  @override
  Stream<bool> mapEventToState(FavoriteBlocEvent event) async* {
    if (event is UserDidSetThisStationAsFavorite) {
      storageManager.updateFavoriteStatus(id: stationId, status: true);
      yield true;
    }
    if (event is UserRemovedStationFromHisFavorites) {
      storageManager.updateFavoriteStatus(id: stationId, status: false);
      yield false;
    }
    if (event is InitEvent) {
      final isFavorite = await storageManager.isFavorite(id: stationId);
      yield isFavorite;
    }
  }
}

class FavoriteBlocEvent {
  const FavoriteBlocEvent();
}

class UserDidSetThisStationAsFavorite extends FavoriteBlocEvent {
  const UserDidSetThisStationAsFavorite();
}

class UserRemovedStationFromHisFavorites extends FavoriteBlocEvent {
  const UserRemovedStationFromHisFavorites();
}

class InitEvent extends FavoriteBlocEvent {
  const InitEvent();
}
