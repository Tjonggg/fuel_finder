import 'package:flutter_test/flutter_test.dart';
import 'package:fuel_finder/sandbox/sandbox.dart';

void main() {
  setUp(() {
    print("From within setUp()");
  });

  setUpAll(() {
    print("From within setUpAll()");
  });

  tearDown(() {
    print("From within tearDown()");
  });

  tearDownAll(() {
    print("From within tearDownAll()");
  });

  group("Unit tests for Flutter training day 5", () {
    test("StringHelper toUppercase test", () {
      final sut = StringHelper();
      final output = sut.toUpperCase("tjong");
      expect(output, "TJONG");
    });

    test("StringHelper toLowercase test", () {
      final sut = StringHelper();
      final output = sut.toLowerCase("TJONG");
      expect(output, "tjong");
    });
  });
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
