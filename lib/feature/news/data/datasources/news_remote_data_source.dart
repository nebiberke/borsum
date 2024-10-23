import 'package:borsum/core/error/exceptions.dart';
import 'package:borsum/feature/search/data/models/news_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class NewsRemoteDataSource {
  Future<NewsModel> getNewsWithId(int id);
}

final class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

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
}
