import 'package:borsum/core/enums/endpoint_enums.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class NewsRepository {
  Future<Either<Failure, NewsEntity>> getNewsWithId(int id);
  Future<Either<Failure, String>> getNewsSummary(
    String article,
    EndpointEnums endpoint,
  );
}
