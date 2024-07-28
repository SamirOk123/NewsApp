import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/strings.dart';
import 'package:news_app/domain/core/api_key.dart';
import 'package:news_app/domain/core/failures.dart';
import 'package:news_app/domain/core/remote_config_failure.dart';
import 'package:news_app/domain/news.dart';
import 'package:news_app/domain/news_facade.dart';

@LazySingleton(as: NewsFacade)
class NewsRepository implements NewsFacade {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  @override
  Future<Either<MainFailure, News>> getNews(
      {required String countryCode}) async {
    try {
      final Response response = await Dio(BaseOptions()).get(
          "$kBaseurl?country=$countryCode&category=business&apiKey=$apiKey");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(News.fromJson(response.data));
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      print(e.toString());
      return left(const MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<RemoteConfigureFailure, String>>
      getCountryCodeFromRemoteConfig() async {
    try {
      await _remoteConfig.setDefaults({
        "country_code": "in",
      });
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1)));
      await _remoteConfig.fetchAndActivate();
      return right(_remoteConfig.getString("country_code"));
    } on FirebaseException catch (e) {
      if (e.message == "frequency of requests exceeds throttled limits") {
        return left(const RemoteConfigureFailure.throttled());
      }

      return left(const RemoteConfigureFailure.serverFailure());
    }
  }
}
