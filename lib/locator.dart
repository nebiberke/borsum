import 'package:borsum/core/clients/network/network_client.dart';
import 'package:borsum/feature/news/data/datasources/news_remote_data_source.dart';
import 'package:borsum/feature/news/data/repositories/news_repository_impl.dart';
import 'package:borsum/feature/news/domain/repositories/news_repository.dart';
import 'package:borsum/feature/news/domain/usecases/uc_get_news_summary.dart';
import 'package:borsum/feature/news/domain/usecases/uc_get_news_with_id.dart';
import 'package:borsum/feature/news/presentation/bloc/news_bloc.dart';
import 'package:borsum/feature/news/presentation/cubit/news_summary_cubit.dart';
import 'package:borsum/feature/search/data/datasources/search_remote_data_source.dart';
import 'package:borsum/feature/search/data/repositories/search_repository_impl.dart';
import 'package:borsum/feature/search/domain/repositories/search_repository.dart';
import 'package:borsum/feature/search/domain/usecases/uc_search_stock.dart';
import 'package:borsum/feature/search/presentation/bloc/search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class Locator {
  /// [GetIt] instance
  static final _instance = GetIt.instance;

  /// Returns instance of [SearchBloc]
  static SearchBloc get searchBloc => _instance<SearchBloc>();

  /// Returns instance of [NewsBloc]
  static NewsBloc get newsBloc => _instance<NewsBloc>();

  /// Returns instance of [NewsSummaryCubit]
  static NewsSummaryCubit get newsSummaryCubit => _instance<NewsSummaryCubit>();

  static void setupLocator({
    required String baseUrl,
    required SupabaseClient supabase,
  }) {
    _instance

      // Client Dependencies
      ..registerFactory(Dio.new)

      // Clients
      ..registerLazySingleton(
        () => NetworkClient(dio: _instance(), baseUrl: baseUrl),
      )

      // Supabase Client
      ..registerLazySingleton<SupabaseClient>(() => supabase)

      // Search Remote Data Source
      ..registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl(supabaseClient: supabase),
      )

      // Search Repository
      ..registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(remoteDataSource: _instance()),
      )

      // Search Use Case
      ..registerLazySingleton<UcSearchStock>(
        () => UcSearchStock(repository: _instance()),
      )

      // Search Bloc
      ..registerFactory<SearchBloc>(
        () => SearchBloc(ucSearchStock: _instance()),
      )

      // News Remote Data Source
      ..registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(
          supabaseClient: supabase,
          networkClient: _instance(),
        ),
      )

      // News Repository
      ..registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(remoteDataSource: _instance()),
      )

      // News Use Case
      ..registerLazySingleton<UcGetNewsWithId>(
        () => UcGetNewsWithId(repository: _instance()),
      )

      // News Bloc
      ..registerFactory<NewsBloc>(
        () => NewsBloc(ucGetNewsWithId: _instance()),
      )

      // News Summary Use Case
      ..registerLazySingleton<UcGetNewsSummary>(
        () => UcGetNewsSummary(repository: _instance()),
      )

      // News Summary Cubit
      ..registerFactory<NewsSummaryCubit>(
        () => NewsSummaryCubit(ucGetNewsSummary: _instance()),
      );
  }
}
