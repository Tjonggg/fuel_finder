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
