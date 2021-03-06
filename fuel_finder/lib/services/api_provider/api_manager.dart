import 'dart:convert' as convert;
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

const String _authority = 'fuelfinder-copy.herokuapp.com';
const String _unencodedPath = '/stations.json';

@injectable
class ApiManager {
  Future<List<GasStationData>> getGasStationList() async {
    final _uri = Uri.http(_authority, _unencodedPath);
    final _response = await http.get(_uri);

    //TODO: improvement needed
    if (_response.statusCode == 200) {
      List _data = convert.jsonDecode(_response.body) as List<dynamic>;

      return GasStationData.mapFromSnapshot(_data);
    } else {
      throw Exception('Server response not ok');
    }
  }
}
