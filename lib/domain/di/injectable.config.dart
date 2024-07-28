// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/login_provider.dart' as _i5;
import '../../application/news_provider.dart' as _i8;
import '../../application/signup_provider.dart' as _i9;
import '../../infrastructure/auth_repository.dart' as _i4;
import '../../infrastructure/news_repository.dart' as _i7;
import '../auth_facade.dart' as _i3;
import '../news_facade.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AuthFacade>(() => _i4.AuthRepository());
  gh.factory<_i5.LoginProvider>(
      () => _i5.LoginProvider(authFacade: get<_i3.AuthFacade>()));
  gh.lazySingleton<_i6.NewsFacade>(() => _i7.NewsRepository());
  gh.factory<_i8.NewsProvider>(
      () => _i8.NewsProvider(newsFacade: get<_i6.NewsFacade>()));
  gh.factory<_i9.SignupProvider>(
      () => _i9.SignupProvider(authFacade: get<_i3.AuthFacade>()));
  return get;
}
