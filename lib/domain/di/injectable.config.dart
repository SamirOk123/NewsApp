// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/login_provider.dart' as _i12;
import '../../application/news_provider.dart' as _i8;
import '../../application/signup_provider.dart' as _i13;
import '../../application/textfield_provider.dart' as _i9;
import '../../infrastructure/auth_repository.dart' as _i11;
import '../../infrastructure/core/firebase_injectable_module.dart' as _i14;
import '../../infrastructure/news_repository.dart' as _i7;
import '../auth_facade.dart' as _i10;
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
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i5.FirebaseRemoteConfig>(
      () => firebaseInjectableModule.firebaseRemoteConfig);
  gh.lazySingleton<_i6.NewsFacade>(
      () => _i7.NewsRepository(get<_i5.FirebaseRemoteConfig>()));
  gh.factory<_i8.NewsProvider>(
      () => _i8.NewsProvider(newsFacade: get<_i6.NewsFacade>()));
  gh.factory<_i9.TextfieldProvider>(() => _i9.TextfieldProvider());
  gh.lazySingleton<_i10.AuthFacade>(() => _i11.AuthRepository(
        get<_i4.FirebaseFirestore>(),
        get<_i3.FirebaseAuth>(),
      ));
  gh.factory<_i12.LoginProvider>(
      () => _i12.LoginProvider(authFacade: get<_i10.AuthFacade>()));
  gh.factory<_i13.SignupProvider>(
      () => _i13.SignupProvider(authFacade: get<_i10.AuthFacade>()));
  return get;
}

class _$FirebaseInjectableModule extends _i14.FirebaseInjectableModule {}
