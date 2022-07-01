import 'package:bloc/bloc.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final _customDelayStream = BehaviorSubject<GasStationSearchData>();

  SearchBloc() : super(const SearchBlocState(filteredList: [])) {
    on<SearchInitEvent>(_onSearchInitEvent);
    on<SearchInputEvent>(_onSearchInputEvent);
    add(const SearchInitEvent());
  }

  void _onSearchInitEvent(SearchInitEvent event, Emitter emit) {
    _customDelayStream.stream.distinct().debounceTime(const Duration(seconds: 1)).listen(
      (debouncedGasStationSearchData) {
        add(SearchInputEvent(debouncedGasStationSearchData));
      },
    );
  }

  void _onSearchInputEvent(SearchInputEvent event, Emitter emit) {
    final filteredList = event.gasStationSearchData.searchList.where(
      (gasStationData) {
        if (gasStationData.name.toLowerCase().contains(event.gasStationSearchData.searchInput.toLowerCase())) {
          return true;
        } else if (gasStationData.street.toLowerCase().contains(event.gasStationSearchData.searchInput.toLowerCase())) {
          return true;
        } else if (gasStationData.city.toLowerCase().contains(event.gasStationSearchData.searchInput.toLowerCase())) {
          return true;
        }
        return false;
      },
    ).toList();
    emit(SearchBlocState(filteredList: filteredList));
  }

  void onTextFieldInput(GasStationSearchData gasStationSearchData) {
    if (gasStationSearchData.searchInput.isNotEmpty) {
      _customDelayStream.add(gasStationSearchData);
    }
  }
}

class SearchBlocEvent {
  const SearchBlocEvent();
}

class SearchInitEvent extends SearchBlocEvent {
  const SearchInitEvent();
}

class SearchInputEvent extends SearchBlocEvent {
  final GasStationSearchData gasStationSearchData;

  const SearchInputEvent(this.gasStationSearchData);
}

class SearchBlocState extends Equatable {
  final List<GasStationData> filteredList;

  const SearchBlocState({
    required this.filteredList,
  });

  @override
  String toString() {
    return "filteredList: ${filteredList.length}";
  }

  @override
  List<Object?> get props => [filteredList];
}
