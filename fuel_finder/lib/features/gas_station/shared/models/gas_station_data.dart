import 'package:fuel_finder/features/gas_station/gas_station_details/models/gas_station_details_data.dart';

class GasStationData {
  final String name;
  final String street;
  final String city;
  final String logo;
  final double latitude;
  final double longitude;
  final int id;
  String? distance;
  List<GasStationDetailsData>? products;
  List<GasStationDetailsData>? payments;
  List<GasStationDetailsData>? extras;

  GasStationData({
    required this.name,
    required this.street,
    required this.city,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.id,
    this.distance,
    this.products,
    this.payments,
    this.extras,
  });

  factory GasStationData.fromJson(dynamic json) {
    List<dynamic> _productsList = json['producten'] as List<dynamic>;
    List<GasStationDetailsData> _products = _productsList.map((e) => GasStationDetailsData.fromJson(e)).toList();

    List<dynamic> _paymentsList = json['betalingen'] as List<dynamic>;
    List<GasStationDetailsData> _payments = _paymentsList.map((e) => GasStationDetailsData.fromJson(e)).toList();

    List<dynamic> _extrasList = json['diversen'] as List<dynamic>;
    List<GasStationDetailsData> _extras = _extrasList.map((e) => GasStationDetailsData.fromJson(e)).toList();

    return GasStationData(
      name: json['naam'] as String,
      street: json['straat_en_nr'] as String,
      city: "${json['postcode'] as String} ${json['localiteit'] as String}",
      logo: json['logo_list'] as String,
      latitude: double.parse(json['geo_lat'] as String),
      longitude: double.parse(json['geo_lng'] as String),
      id: json['id'] as int,
      products: _products,
      payments: _payments,
      extras: _extras,
    );
  }

  static List<GasStationData> mapFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return GasStationData.fromJson(data);
    }).toList();
  }
}
