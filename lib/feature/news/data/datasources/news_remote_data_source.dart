import 'dart:convert';

import 'package:borsum/app/env/env.dart';
import 'package:borsum/core/clients/network/network_client.dart';
import 'package:borsum/core/enums/endpoint_enums.dart';
import 'package:borsum/core/error/exceptions.dart';
import 'package:borsum/feature/search/data/models/news_model.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class NewsRemoteDataSource {
  Future<NewsModel> getNewsWithId(int id);
  Future<String> getNewsSummary(String article, EndpointEnums endpoints);
}

final class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
    required NetworkClient networkClient,
  })  : _supabaseClient = supabaseClient,
        _networkClient = networkClient;

  final SupabaseClient _supabaseClient;
  final NetworkClient _networkClient;

  @override
  Future<NewsModel> getNewsWithId(int id) async {
    try {
      final response = await _supabaseClient.from('news').select().eq('id', id);

      if (response.isEmpty) {
        throw NullResponseException();
      }

      return NewsModel.fromJson(response.first);
    } catch (_) {
      throw UnknownException();
    }
  }

  @override
  Future<String> getNewsSummary(String article, EndpointEnums endpoints) async {
    try {
      final response = await _networkClient.post<List<dynamic>>(
        endpoints.path,
        data: jsonEncode({
          'inputs': article,
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Env.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 503 || response.statusCode != 200) {
        throw ServerException();
      }

      if (response.data != null && response.data!.isNotEmpty) {
        final data = List<Map<String, dynamic>>.from(response.data!);
        final summary = data[0]['summary_text'] as String;
        return summary;
      } else {
        throw NullResponseException();
      }
    } catch (_) {
      throw UnknownException();
    }
  }
}
