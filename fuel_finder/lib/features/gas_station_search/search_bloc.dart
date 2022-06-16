import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fuel_finder/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final _gasStationApi = GasStationApi(); //TODO inject this API
  final _customDelayStream = BehaviorSubject<String>();

  SearchBloc() : super(SearchBlocState(filteredList: [], fullList: [])) {
    add(const SearchInitEvent());
  }

  void onTextFieldChanged(String input) {
    if (input.isNotEmpty) {
      print("TJONG before debounce $input");
      _customDelayStream.add(input);
    } else {
      add(const SearchEmptyEvent());
    }
  }

  @override
  Stream<SearchBlocState> mapEventToState(SearchBlocEvent event) async* {
    if (event is SearchEmptyEvent) {
      yield SearchBlocState(filteredList: state.fullList, fullList: state.fullList);
    }
    if (event is SearchInputEvent) {
      final filteredList = state.fullList.where(
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
      yield SearchBlocState(filteredList: filteredList, fullList: state.fullList);
    }
    if (event is SearchInitEvent) {
      _customDelayStream.stream.distinct().debounceTime(const Duration(seconds: 1)).listen(
        (input) {
          add(SearchInputEvent(input));
          print("TJONG after adding event $input");
        },
      );
      final gasStationList = await _gasStationApi.getGasStationList();
      yield SearchBlocState(filteredList: gasStationList, fullList: gasStationList);
    }
  }
}

class SearchBlocEvent {
  const SearchBlocEvent();
}

class SearchEmptyEvent extends SearchBlocEvent {
  const SearchEmptyEvent();
}

class SearchTypingEvent extends SearchBlocEvent {
  const SearchTypingEvent(); //TODO: try :)
}

class SearchInputEvent extends SearchBlocEvent {
  final String input;

  const SearchInputEvent(this.input);
}

class SearchInitEvent extends SearchBlocEvent {
  const SearchInitEvent();
}

class SearchBlocState {
  final List<GasStationData> filteredList;
  final List<GasStationData> fullList;

  SearchBlocState({
    required this.filteredList,
    required this.fullList,
  });
}
