import 'package:borsum/core/error/exceptions.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/news/data/datasources/news_remote_data_source.dart';
import 'package:borsum/feature/news/domain/repositories/news_repository.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

final class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl({required NewsRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final NewsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, NewsEntity>> getNewsWithId(int id) async {
    try {
      final news = await _remoteDataSource.getNewsWithId(id);
      final newsEntity = NewsEntity.fromModel(news);
      return Right(newsEntity);
    } on NullResponseException {
      return Left(NullResponseFailure());
    } catch (_) {
      return Left(UnknownFailure());
    }
  }
}
