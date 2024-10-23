import 'package:borsum/core/clients/network/network_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class Locator {
  /// [GetIt] instance
  static final _instance = GetIt.instance;

  static void setupLocator(
      {required String baseUrl, required SupabaseClient supabase}) {
    _instance

      // Client Dependencies
      ..registerFactory(Dio.new)

      // Clients
      ..registerLazySingleton(
        () => NetworkClient(dio: _instance(), baseUrl: baseUrl),
      )

      // Supabase Client
      ..registerLazySingleton<SupabaseClient>(() => supabase);
  }
}
