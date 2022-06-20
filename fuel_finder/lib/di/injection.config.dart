// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/api_provider/gas_station_api.dart' as _i3;
import '../services/location_provider/geolocator_wrapper.dart' as _i5;
import '../services/location_provider/location_bloc.dart' as _i4;
import '../services/storage_provider/storage_manager.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.GasStationApi>(() => _i3.GasStationApi());
  gh.factory<_i4.LocationBloc>(
      () => _i4.LocationBloc(geolocator: get<_i5.GeolocatorWrapper>()));
  gh.factory<_i6.StorageManager>(() => _i6.StorageManager());
  return get;
}
