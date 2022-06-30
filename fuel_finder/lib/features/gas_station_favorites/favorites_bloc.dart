// Future<bool> isFavorite({required int id}) async {
//     final List<String> _favoritesList = await getFavoritesList();

//     if (_favoritesList.contains(id.toString())) {
//       return true;
//     }

//     return false;
//   }


// class GasStationFavoriteManager {
//   final StorageManager storageManager;
//   final gasStationFavoriteNotifier = GasStationFavoriteNotifier();

//   GasStationFavoriteManager({
//     required this.storageManager,
//   });

//   Future<void> initFavorite({required int id}) async {
//     gasStationFavoriteNotifier.value = await storageManager.isFavorite(id: id);
//   }

//   Future<bool> isFavorite({required int id}) async {
//     return await storageManager.isFavorite(id: id);
//   }

//   void updateFavoriteStatus({required int id}) {
//     gasStationFavoriteNotifier.toggleFavoriteStatus(id: id);
//   }
// }


// class GasStationFavoriteNotifier extends ValueNotifier<bool> {
//   final _storageProvider = getIt<StorageManager>();

//   GasStationFavoriteNotifier() : super(false);

//   Future<void> toggleFavoriteStatus({required int id}) async {
//     value = !value;
//     _storageProvider.updateFavoriteStatus(id: id, status: value);
//   }
// }


// class FavoriteBloc extends Bloc<FavoriteBlocEvent, bool> {
//   final StorageManager storageManager;
//   final int stationId;

//   FavoriteBloc(this.storageManager, {required this.stationId}) : super(false) {
//     add(const InitEvent());
//   }

//   void userDidTapFavoriteToggle() {
//     final newFavoriteStatus = !state;
//     if (newFavoriteStatus == true) {
//       add(const UserDidSetThisStationAsFavorite());
//     } else {
//       add(const UserRemovedStationFromHisFavorites());
//     }
//   }

//   @override
//   Stream<bool> mapEventToState(FavoriteBlocEvent event) async* {
//     if (event is UserDidSetThisStationAsFavorite) {
//       storageManager.updateFavoriteStatus(id: stationId, status: true);
//       yield true;
//     }
//     if (event is UserRemovedStationFromHisFavorites) {
//       storageManager.updateFavoriteStatus(id: stationId, status: false);
//       yield false;
//     }
//     if (event is InitEvent) {
//       final isFavorite = await storageManager.isFavorite(id: stationId);
//       yield isFavorite;
//     }
//   }
// }

// class FavoriteBlocEvent {
//   const FavoriteBlocEvent();
// }

// class UserDidSetThisStationAsFavorite extends FavoriteBlocEvent {
//   const UserDidSetThisStationAsFavorite();
// }

// class UserRemovedStationFromHisFavorites extends FavoriteBlocEvent {
//   const UserRemovedStationFromHisFavorites();
// }

// class InitEvent extends FavoriteBlocEvent {
//   const InitEvent();
// }

//   Future<void> toggleFavoriteList() async {
//     final _favoritesList = await storageManager.getFavoritesList();

//     if (_gasStationList == null) {
//       try {
//         _gasStationList = await gasStationApi.getGasStationList();
//       } catch (e) {
//         throw Exception("Couldn't fetch gas station list: $e");
//       }
//     }

//     if (!showFavoritesList.value) {
//       _getGasStationListStreamController.add(_gasStationList!.where(
//         (value) {
//           if (_favoritesList.contains(value.id.toString())) {
//             return true;
//           }
//           return false;
//         },
//       ).toList());

//       showFavoritesList.value = true;
//     } else {
//       _getGasStationListStreamController.add(_gasStationList!);
//       showFavoritesList.value = false;
//     }
//   }
// }