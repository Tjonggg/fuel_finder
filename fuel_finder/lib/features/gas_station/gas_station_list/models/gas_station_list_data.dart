class GasStationListData {
  final String name;
  final String street;
  final String city;
  final String logo;
  final double latitude;
  final double longitude;
  final int id;

  GasStationListData({
    required this.name,
    required this.street,
    required this.city,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  factory GasStationListData.fromJson(dynamic json) {
    String _city =
        "${json['postcode'] as String} ${json['localiteit'] as String}";
    String _latitude = json['geo_lat'] as String;
    String _longitude = json['geo_lng'] as String;

    return GasStationListData(
      name: json['naam'] as String,
      street: json['straat_en_nr'] as String,
      city: _city,
      logo: json['logo_list'] as String,
      latitude: double.parse(_latitude),
      longitude: double.parse(_longitude),
      id: json['id'] as int,
    );
  }

  static List<GasStationListData> mapFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return GasStationListData.fromJson(data);
    }).toList();
  }
}
