import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/news/domain/repositories/news_repository.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

class UcGetNewsWithId {
  UcGetNewsWithId({required NewsRepository repository})
      : _repository = repository;
  final NewsRepository _repository;

  Future<Either<Failure, NewsEntity>> call(int id) async {
    return _repository.getNewsWithId(id);
  }
}
