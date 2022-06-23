//emit(LocationBlocState(lastKnownPosition: currentPosition, currentPosition: currentPosition));
// final distance =
//       geolocator.distanceBetween(lastKnownPosition.latitude, lastKnownPosition.longitude, currentPosition.latitude, currentPosition.longitude);
// geolocator.distanceBetween(state.lastKnownPosition!.latitude, state.lastKnownPosition!.longitude, currentPosition.latitude, currentPosition.longitude);
// var lastKnownPosition = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

import 'package:fuel_finder/services/api_provider/api_manager.dart';
import 'package:fuel_finder/services/location_provider/location_bloc.dart';
import 'package:fuel_finder/services/storage_provider/storage_manager.dart';

class GasStationListController {
  final ApiManager gasStationApi;
  final LocationBloc locationProvider;
  final StorageManager storageManager;

  GasStationListController({
    required this.storageManager,
    required this.gasStationApi,
    required this.locationProvider,
  });

  //TODO add dispose of all the streams
  // List<GasStationData>? _gasStationList;
  // bool enableLocationRefresh = true;
  // final ValueNotifier<bool> showFavoritesList = ValueNotifier<bool>(false);

  // final StreamController<List<GasStationData>> _getGasStationListStreamController = StreamController<List<GasStationData>>.broadcast();
  // Stream<List<GasStationData>> get getGasStationListStream => _getGasStationListStreamController.stream;

  // Future<void> initGasStationList() async {
  //   try {
  //     _gasStationList = await gasStationApi.getGasStationList();
  //   } catch (e) {
  //     throw Exception("Couldn't fetch gas station list: $e");
  //   }

  //   if (_gasStationList != null) {
  //     _gasStationList!.sort(((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));

  //     _getGasStationListStreamController.add(_gasStationList!);

  //     _refreshGasStationList();
  //   }
  // }

  // void _refreshGasStationList() {
  //   double _distance;

  //   //LocationProvider().initLocationProvider();
  //   locationProvider.refreshPositionStream.listen(
  //     (position) async {
  //       if (enableLocationRefresh) {
  //         for (var _gasStationListItem in _gasStationList!) {
  //           _distance = locationProvider.geolocator
  //               .distanceBetween(position.latitude, position.longitude, _gasStationListItem.latitude, _gasStationListItem.longitude);

  //           if (_distance > 999) {
  //             final _temp = _distance / 1000;
  //             _gasStationListItem.distance = '${_temp.toStringAsFixed(1)} km';
  //           } else {
  //             _gasStationListItem.distance = '${_distance.toStringAsFixed(0)} m';
  //           }
  //         }

  //         _gasStationList!.sort(((a, b) => a.distance!.compareTo(b.distance!)));

  //         _getGasStationListStreamController.add(_gasStationList!);
  //       }
  //     },
  //   );
  // }

  // Future<void> toggleFavoriteList() async {
  //   final _favoritesList = await storageManager.getFavoritesList();

  //   if (_gasStationList == null) {
  //     try {
  //       _gasStationList = await gasStationApi.getGasStationList();
  //     } catch (e) {
  //       throw Exception("Couldn't fetch gas station list: $e");
  //     }
  //   }

  //   if (!showFavoritesList.value) {
  //     _getGasStationListStreamController.add(_gasStationList!.where(
  //       (value) {
  //         if (_favoritesList.contains(value.id.toString())) {
  //           return true;
  //         }
  //         return false;
  //       },
  //     ).toList());

  //     showFavoritesList.value = true;
  //   } else {
  //     _getGasStationListStreamController.add(_gasStationList!);
  //     showFavoritesList.value = false;
  //   }
  // }
}
