class GasStationDetailsData {
  final String name;
  final String street;
  final String city;
  final String logo;
  double? distance;
  final List? products;
  final List? payments;
  final List? extras;

  GasStationDetailsData({
    required this.name,
    required this.street,
    required this.city,
    required this.logo,
    this.distance,
    this.products,
    this.payments,
    this.extras,
  });
}
