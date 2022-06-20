import 'package:bloc/bloc.dart';
import 'package:fuel_finder/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';
import 'package:equatable/equatable.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final GasStationApi gasStationApi;
  final _customDelayStream = BehaviorSubject<String>();

  SearchBloc(this.gasStationApi) : super(SearchBlocState(filteredList: [], fullList: [])) {
    on<SearchInitEvent>(_onSearchInitEvent);
    on<SearchEmptyEvent>(_onSearchEmptyEvent);
    on<SearchInputEvent>(_onSearchInputEvent);
    add(const SearchInitEvent());
  }

  void onTextFieldChanged(String input) {
    if (input.isNotEmpty) {
      _customDelayStream.add(input);
    } else {
      add(const SearchEmptyEvent());
    }
  }

  void _onSearchInitEvent(SearchInitEvent event, Emitter emit) async {
    _customDelayStream.stream.distinct().debounceTime(const Duration(seconds: 1)).listen(
      (input) {
        add(SearchInputEvent(input));
      },
    );
    final gasStationList = await gasStationApi.getGasStationList();
    emit(SearchBlocState(filteredList: gasStationList, fullList: gasStationList));
  }

  void _onSearchEmptyEvent(SearchEmptyEvent event, Emitter emit) async {
    emit(SearchBlocState(filteredList: state.fullList, fullList: state.fullList));
  }

  void _onSearchInputEvent(SearchInputEvent event, Emitter emit) async {
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
    emit(SearchBlocState(filteredList: filteredList, fullList: state.fullList));
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

class SearchBlocState extends Equatable {
  final List<GasStationData> filteredList;
  final List<GasStationData> fullList;

  const SearchBlocState({
    required this.filteredList,
    required this.fullList,
  });

  @override
  String toString() {
    return "filteredList: ${filteredList.length}, fullList: ${fullList.length}";
  }

  @override
  List<Object?> get props => [filteredList, fullList];
}
