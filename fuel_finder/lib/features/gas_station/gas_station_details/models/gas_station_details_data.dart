class GasStationDetailsData {
  final String gasStationDetailsItem;

  GasStationDetailsData({
    required this.gasStationDetailsItem,
  });

  factory GasStationDetailsData.fromJson(Map<String, dynamic> parsedJson) {
    return GasStationDetailsData(
      gasStationDetailsItem: parsedJson['name'] as String,
    );
  }
}
