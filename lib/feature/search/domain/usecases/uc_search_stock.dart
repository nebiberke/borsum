import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:borsum/feature/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class UcSearchStock {
  UcSearchStock({required SearchRepository searchRepository})
      : _searchRepository = searchRepository;
  final SearchRepository _searchRepository;

  Future<Either<Failure, List<NewsEntity>>> call(String query) async {
    return _searchRepository.searchStock(query);
  }
}
