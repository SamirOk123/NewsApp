import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/domain/core/failures.dart';
import 'package:news_app/domain/news.dart';
import 'package:news_app/domain/news_facade.dart';

@injectable
class NewsProvider extends ChangeNotifier {
  NewsProvider({required this.newsFacade});
  final NewsFacade newsFacade;
  bool isLoading = false;

  News news = News();

  Option<Either<MainFailure, News>> newsFailureOrSuccess = const None();

  getNews() async {
    isLoading = true;
    newsFailureOrSuccess = const None();
    notifyListeners();
    final Either<MainFailure, News> newsOption = await newsFacade.getNews();

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
  }
}
