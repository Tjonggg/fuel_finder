import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class StorageBloc extends Bloc<StorageBlocEvent, StorageBlocState> {
  final String? storigeKey;
  SharedPreferences? storageSharedPreferences;

  StorageBloc({this.storigeKey}) : super(const StorageBlocState([])) {
    on<InitStorageEvent>(_onInitStorageEvent);
    on<GetStorageEvent>(_onGetStorageEvent);
    on<UpdateDistinctStorageEvent>(_onUpdateDistinctStorageEvent);
    add(const InitStorageEvent());
  }

  void _onInitStorageEvent(InitStorageEvent event, Emitter emit) async {
    storageSharedPreferences = await SharedPreferences.getInstance();
  }

  void _onGetStorageEvent(GetStorageEvent event, Emitter emit) {
    final _requestedList = _checkStorageList(listKey: event.listKey);
    emit(StorageBlocState(_requestedList));
  }

  void _onUpdateDistinctStorageEvent(UpdateDistinctStorageEvent event, Emitter emit) {
    final _updateDistinctStorageList = _checkStorageList(listKey: event.listKey);
    if (_updateDistinctStorageList.contains(event.item)) {
      _updateDistinctStorageList.remove(event.item);
    } else {
      _updateDistinctStorageList.add(event.item);
    }
    storageSharedPreferences!.setStringList(event.listKey, _updateDistinctStorageList);
    emit(StorageBlocState(_updateDistinctStorageList));
  }

  List<String> _checkStorageList({required String listKey}) {
    var _requestedList = storageSharedPreferences!.getStringList(listKey);
    if (_requestedList == null) {
      storageSharedPreferences!.setStringList(listKey, <String>[]);
      _requestedList = storageSharedPreferences!.getStringList(listKey);
    }
    return _requestedList!;
  }
}

class StorageBlocEvent {
  const StorageBlocEvent();
}

class InitStorageEvent extends StorageBlocEvent {
  const InitStorageEvent();
}

class GetStorageEvent extends StorageBlocEvent {
  final String listKey;

  const GetStorageEvent({
    required this.listKey,
  });
}

class UpdateDistinctStorageEvent extends StorageBlocEvent {
  final String listKey;
  final String item;

  const UpdateDistinctStorageEvent({
    required this.listKey,
    required this.item,
  });
}

class StorageBlocState {
  final List<String>? stringList;

  const StorageBlocState(this.stringList);
}
