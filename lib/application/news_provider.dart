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
    _setLoadingState();
    final countryCodeResult = await newsFacade.getCountryCodeFromRemoteConfig();

    countryCodeResult.fold(
      (failure) => _handleCountryCodeFailure(failure),
      (countryCode) => _handleCountryCodeSuccess(countryCode),
    );
  }

  void _setLoadingState() {
    isLoading = true;
    isError = false;
    notifyListeners();
  }

  void _handleCountryCodeFailure(RemoteConfigureFailure failure) async {
    isLoading = false;
    countryCodeFailureOrSuccess = Some(left(failure));
    notifyListeners();
    await _fetchNews();
  }

  void _handleCountryCodeSuccess(String countryCode) async {
    this.countryCode = countryCode;
    countryCodeFailureOrSuccess = Some(right(countryCode));
    notifyListeners();
    await _fetchNews();
  }

  Future<void> _fetchNews() async {
    final newsOption = await newsFacade.getNews(countryCode: countryCode);

    newsOption.fold(
      (failure) {
        isError = true;
        isLoading = false;
        newsFailureOrSuccess = Some(left(failure));
        notifyListeners();
      },
      (news) {
        isError = false;
        isLoading = false;
        this.news = news;
        newsFailureOrSuccess = Some(right(news));
        notifyListeners();
      },
    );
  }
}
