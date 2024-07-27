import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/strings.dart';
import 'package:news_app/domain/core/failures.dart';
import 'package:news_app/domain/news.dart';
import 'package:news_app/domain/news_facade.dart';

@LazySingleton(as: NewsFacade)
class NewsRepository implements NewsFacade {
  @override
  Future<Either<MainFailure, News>> getNews() async {
    try {
      //TODO: fix url
      final Response response = await Dio(BaseOptions()).get(
          "$kBaseurl?country=us&category=business&apiKey=e4189b902bb848d6b13550cce29beafe");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(News.fromJson(response.data));
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (_) {
      return left(const MainFailure.clientFailure());
    }
  }
}
