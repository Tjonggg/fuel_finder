import 'dart:convert' as convert;
import 'package:fuel_finder/shared/models/gas_station_data.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class GasStationApi {
  static const String _authority = 'fuelfinder-copy.herokuapp.com';
  static const String _unencodedPath = '/stations.json';

  Future<List<GasStationData>> getGasStationList() async {
    final _uri = Uri.http(_authority, _unencodedPath);
    final _response = await http.get(_uri);

    if (_response.statusCode == 200) {
      List _data = convert.jsonDecode(_response.body) as List<dynamic>;

      return GasStationData.mapFromSnapshot(_data);
    } else {
      throw Exception('Server response not ok');
    }
  }
}
