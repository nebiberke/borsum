import 'package:borsum/core/enums/endpoint_enums.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class UcGetNewsSummary {
  UcGetNewsSummary({required NewsRepository repository})
      : _repository = repository;
  final NewsRepository _repository;

  Future<Either<Failure, String>> call(
    String article,
    EndpointEnums endpoints,
  ) async {
    return _repository.getNewsSummary(article, endpoints);
  }
}
