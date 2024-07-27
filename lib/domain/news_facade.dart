import 'package:dartz/dartz.dart';
import 'package:news_app/domain/core/failures.dart';
import 'package:news_app/domain/news.dart';

abstract class NewsFacade {
  Future<Either<MainFailure, News>> getNews();
}
