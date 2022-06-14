import 'package:bloc/bloc.dart';
import 'package:fuel_finder/services/api_provider/gas_station_api.dart';
import 'package:fuel_finder/shared/models/gas_station_data.dart';

class SearchBloc extends Bloc<SearchBlocEvent, List<GasStationData>> {
  final GasStationApi _gasStationApi; 
  SearchBloc(this._gasStationApi) : super([]);

  void onTextFieldChanged(String input) {
    if (input.isNotEmpty) {
      add(SearchInput(input));
    } else {
      add(const SearchEmpty());
    }
  }

  @override
  Stream<List<GasStationData>> mapEventToState(SearchBlocEvent event) async* {
    final _gasStationList = await _gasStationApi.getGasStationList();
    if (event is SearchEmpty) {
      yield _gasStationList;
    }
    if (event is SearchInput) {
      yield _gasStationList.where(
        (gasStationData) {
          if (gasStationData.name.toLowerCase().contains(event.input.toLowerCase())) {
            return true;
          } else if (gasStationData.street.toLowerCase().contains(event.input.toLowerCase())) {
            return true;
          } else if (gasStationData.city.toLowerCase().contains(event.input.toLowerCase())) {
            return true;
          }
          return false;
        },
      ).toList();
    }
  }
}

class SearchBlocEvent {
  const SearchBlocEvent();
}

class SearchEmpty extends SearchBlocEvent {
  const SearchEmpty();
}

class SearchTyping extends SearchBlocEvent {
  const SearchTyping(); //TODO: try :)
}

class SearchInput extends SearchBlocEvent {
  final String input;
  const SearchInput(this.input);
}
