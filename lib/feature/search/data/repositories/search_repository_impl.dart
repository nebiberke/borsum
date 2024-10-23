import 'package:borsum/core/error/exceptions.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/search/data/datasources/search_remote_data_source.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:borsum/feature/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

final class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl({required SearchRemoteDataSource searchRemoteDataSource})
      : _searchRemoteDataSource = searchRemoteDataSource;

  final SearchRemoteDataSource _searchRemoteDataSource;

  @override
  Future<Either<Failure, List<NewsEntity>>> searchStock(String query) async {
    try {
      final response = await _searchRemoteDataSource.searchStock(query);
      final newsEntities = response.map(NewsEntity.fromModel).toList();
      return Right(newsEntities);
    } on NullResponseException {
      return Left(NullResponseFailure());
    } catch (e) {
      debugPrint(e.toString());
      return left(UnknownFailure());
    }
  }
}
