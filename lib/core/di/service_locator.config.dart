// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../app_bloc.dart' as _i7;
import '../../database/dao/server_ip_dao.dart' as _i4;
import '../../network/api/app_api.dart' as _i6;
import '../../network/error/error_handler.dart' as _i3;
import '../../network/http_client.dart' as _i5;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.ErrorHandlerI>(() => _i3.ErrorHandler());
  gh.lazySingleton<_i4.UrlSourceI>(() => _i4.UrlSource());
  gh.lazySingleton<_i5.HttpClientBase>(() => _i5.HttpClient(
        serverIpDao: gh<_i4.UrlSourceI>(),
        errorHandler: gh<_i3.ErrorHandlerI>(),
      ));
  gh.lazySingleton<_i6.AppApiI>(
      () => _i6.AppApi(httpClient: gh<_i5.HttpClientBase>()));
  gh.factory<_i7.AppBloc>(() => _i7.AppBloc(
        appApi: gh<_i6.AppApiI>(),
        urlSource: gh<_i4.UrlSourceI>(),
      ));
  return getIt;
}
