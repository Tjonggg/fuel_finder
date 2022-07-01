// emit(LocationBlocState(lastKnownPosition: currentPosition, currentPosition: currentPosition));
// final distance =
//       geolocator.distanceBetween(lastKnownPosition.latitude, lastKnownPosition.longitude, currentPosition.latitude, currentPosition.longitude);
// geolocator.distanceBetween(state.lastKnownPosition!.latitude, state.lastKnownPosition!.longitude, currentPosition.latitude, currentPosition.longitude);
// + last know position, niet in bbbloc

//   void _refreshGasStationList() {
//     double _distance;

//     //LocationProvider().initLocationProvider();
//     locationProvider.refreshPositionStream.listen(
//       (position) async {
//         if (enableLocationRefresh) {
//           for (var _gasStationListItem in _gasStationList!) {
//             _distance = locationProvider.geolocator
//                 .distanceBetween(position.latitude, position.longitude, _gasStationListItem.latitude, _gasStationListItem.longitude);

//             if (_distance > 999) {
//               final _temp = _distance / 1000;
//               _gasStationListItem.distance = '${_temp.toStringAsFixed(1)} km';
//             } else {
//               _gasStationListItem.distance = '${_distance.toStringAsFixed(0)} m';
//             }
//           }

//           _gasStationList!.sort(((a, b) => a.distance!.compareTo(b.distance!)));

//           _getGasStationListStreamController.add(_gasStationList!);
//         }
//       },
//     );
//   }
// }
