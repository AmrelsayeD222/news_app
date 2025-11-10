import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../model/article.dart';

abstract class NewsRepo {
  Future<Either<Failure, List<Article>>> fetchNews({required String category});
}
