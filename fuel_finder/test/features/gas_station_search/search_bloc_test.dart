// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
// import 'package:fuel_finder/services/api_provider/api_provider.dart';
// import 'package:mocktail/mocktail.dart';

// class MockGasStationApi extends Mock implements ApiManager {}

// void main() {
//   final mockGasStationApi = MockGasStationApi();

//   group(
//     'Gas station SearchBloc',
//     () {
//       when(() => mockGasStationApi.getGasStationList()).thenAnswer((_) async => []);
//       blocTest(
//         'emits empty SearchBlocState when there is no input',
//         build: () => SearchBloc(mockGasStationApi),
//         expect: () => [const SearchBlocState(searchList: [], fullList: [])],
//       );
//     },
//   );
// }
