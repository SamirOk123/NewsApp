import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/domain/core/failures.dart';
import 'package:news_app/domain/core/remote_config_failure.dart';
import 'package:news_app/domain/news.dart';
import 'package:news_app/domain/news_facade.dart';

@injectable
class NewsProvider extends ChangeNotifier {
  NewsProvider({required this.newsFacade});
  final NewsFacade newsFacade;
  bool isLoading = false;
  bool isError = false;
  String countryCode = 'us';

  News news = News();

  Option<Either<MainFailure, News>> newsFailureOrSuccess = const None();
  Option<Either<RemoteConfigureFailure, String>> countryCodeFailureOrSuccess =
      const None();

  Future<void> getNews() async {
    isLoading = true;
    newsFailureOrSuccess = const None();
    notifyListeners();
    final Either<RemoteConfigureFailure, String> countryCodeOption =
        await newsFacade.getCountryCodeFromRemoteConfig();

    countryCodeOption.fold((failure) async {
      isLoading = false;
      countryCodeFailureOrSuccess = Some(left(failure));
      notifyListeners();
      final Either<MainFailure, News> newsOption =
          await newsFacade.getNews(countryCode: countryCode);

      newsOption.fold((failure) {
        isLoading = false;
        newsFailureOrSuccess = Some(left(failure));
        notifyListeners();
      }, (success) {
        isLoading = false;
        news = success;
        newsFailureOrSuccess = Some(right(success));
        notifyListeners();
      });
    }, (success) async {
      countryCode = success;
      countryCodeFailureOrSuccess = Some(right(success));
      notifyListeners();
      final Either<MainFailure, News> newsOption =
          await newsFacade.getNews(countryCode: countryCode);

      newsOption.fold((failure) {
        isError = true;
        isLoading = false;
        newsFailureOrSuccess = Some(left(failure));
        notifyListeners();
      }, (success) {
        isError = false;
        isLoading = false;
        news = success;
        newsFailureOrSuccess = Some(right(success));
        notifyListeners();
      });
    });
  }
}
