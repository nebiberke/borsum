import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class SearchRepository {
  Future<Either<Failure, List<NewsEntity>>> searchStock(String query);
}
