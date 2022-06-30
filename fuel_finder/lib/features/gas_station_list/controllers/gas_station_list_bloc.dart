import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_finder/features/gas_station_list/gas_station_list.dart';
import 'package:fuel_finder/features/gas_station_search/gas_station_search.dart';
import 'package:fuel_finder/services/api_provider/api_provider.dart';

class GasStationListBloc extends Bloc<GasStationListBlocEvent, GasStationListBlocState> {
  final ApiManager apiManager;
  final SearchBloc searchBloc;

  List<GasStationData>? _gasStationList;

  var _gasStationSearchData = GasStationSearchData('', []);

  GasStationListBloc({
    required this.apiManager,
    required this.searchBloc,
  }) : super(const GasStationListBlocState([])) {
    on<ShowGasStationListEvent>(_onShowGasStationListEvent);
    on<ShowFilteredGasStationListEvent>(_onShowFilteredGasStationListEvent);
    add(ShowGasStationListEvent());
  }

  void _onShowGasStationListEvent(ShowGasStationListEvent event, Emitter emit) async {
    if (_gasStationList != null) {
      emit(GasStationListBlocState(_gasStationList!));
    } else {
      try {
        _gasStationList = await apiManager.getGasStationList();
        _gasStationList!.sort(((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));
      } catch (e) {
        _gasStationList = []; //TODO: improvement needed and local storage list?
        throw Exception("Couldn't fetch gas station list: $e");
      }
      emit(GasStationListBlocState(_gasStationList!));
    }
  }

  void _onShowFilteredGasStationListEvent(ShowFilteredGasStationListEvent event, Emitter emit) {
    emit(GasStationListBlocState(event.filteredGasStationList));
  }

  void onTextFieldChanged(String textFieldInput) async {
    if (textFieldInput.isNotEmpty) {
      _gasStationSearchData.searchInput = textFieldInput;
      _gasStationSearchData.searchList = _gasStationList!;

      // searchBloc.onTextFieldInput(_gasStationSearchData);
      // var searchBlocState = searchBloc.stream.last;
      // add(ShowFilteredGasStationListEvent(searchBlocState.));
    } else {
      add(ShowGasStationListEvent());
    }
  }
}

class GasStationListBlocEvent {}

class ShowGasStationListEvent extends GasStationListBlocEvent {}

class ShowFilteredGasStationListEvent extends GasStationListBlocEvent {
  final List<GasStationData> filteredGasStationList;

  ShowFilteredGasStationListEvent(this.filteredGasStationList);
}

class GasStationListBlocState {
  final List<GasStationData> gasStationList;

  const GasStationListBlocState(this.gasStationList);
}
