import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failure.dart';
import '../model/article.dart';
import '../service/news_service.dart';
import 'repo.dart';

class NewsRepoImpl implements NewsRepo {
  final NewsService newsService;

  NewsRepoImpl(this.newsService);

  @override
  Future<Either<Failure, List<Article>>> fetchNews({
    required String category,
  }) async {
    try {
      final result = await newsService.getNews(category: category);
      return Right(result.articles ?? []);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
