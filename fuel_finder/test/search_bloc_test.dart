import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockGasStationApi extends Mock implements GasStationApi {}

void main() {
  final mockGasStationApi = MockGasStationApi();

  group(
    'SearchBloc',
    () {
      when(() => mockGasStationApi.getGasStationList()).thenAnswer((_) async => []);
      blocTest(
        'emits empty SearchBlocState when there is no input',
        build: () => SearchBloc(mockGasStationApi),
        expect: () => [const SearchBlocState(filteredList: [], fullList: [])],
      );
    },
  );
}

// import 'package:collection/collection.dart';
// import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
// import 'package:fuel_finder/models/models.dart';

// void main() {
//   group("User starts typing", () {
//     test("On valid input", () {
//       final sut = SearchBloc();
//       final brusselsStation = GasStationData(
//         name: "Brussels station",
//         street: "Grand Rue",
//         city: "Brussels",
//         logo: "someLogo",
//         latitude: 10,
//         longitude: 10,
//         id: 1,
//       );
//       final aalstStation = GasStationData(
//         name: "Aalst station",
//         street: "Stationstraat",
//         city: "Aalst",
//         logo: "someOtherLogo",
//         latitude: 20,
//         longitude: 20,
//         id: 2,
//       );
//       final List<GasStationData> fullListMock = [brusselsStation, aalstStation];
//       print("fullListMock: $fullListMock");
//       final filteredList = sut.filterGasStationsList(fullListMock, input: "Aalst");
//       expect(filteredList.length, 1);
//       expect(filteredList.length, lessThanOrEqualTo(fullListMock.length));
//       expect(ListEquality().equals(filteredList, [aalstStation]), true);
//       expect(ListEquality().equals(filteredList, [brusselsStation]), false);
//     });
//   });
// }