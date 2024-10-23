import 'package:borsum/core/clients/network/network_client.dart';
import 'package:borsum/feature/search/data/datasources/search_remote_data_source.dart';
import 'package:borsum/feature/search/data/repositories/search_repository_impl.dart';
import 'package:borsum/feature/search/domain/repositories/search_repository.dart';
import 'package:borsum/feature/search/domain/usecases/uc_search_stock.dart';
import 'package:borsum/feature/search/presentation/bloc/bloc/search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class Locator {
  /// [GetIt] instance
  static final _instance = GetIt.instance;

  /// Returns instance of [SearchBloc]
  static SearchBloc get searchBloc => _instance<SearchBloc>();

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
      );
  }
}
