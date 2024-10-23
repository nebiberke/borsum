import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:borsum/feature/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class UcSearchStock {
  UcSearchStock({required SearchRepository repository})
      : _repository = repository;
  final SearchRepository _repository;

  Future<Either<Failure, List<NewsEntity>>> call(String query) async {
    return _repository.searchStock(query);
  }
}
