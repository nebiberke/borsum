import 'package:borsum/core/error/exceptions.dart';
import 'package:borsum/feature/search/data/models/news_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SearchRemoteDataSource {
  Future<List<NewsModel>> searchStock(String query);
}

final class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  SearchRemoteDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<List<NewsModel>> searchStock(String query) async {
    try {
      final response = await _supabaseClient
          .from('news')
          .select()
          .eq('stock', query.toUpperCase());

      if (response.isEmpty) {
        throw NullResponseException();
      }

      return response.map(NewsModel.fromJson).toList();
    } catch (_) {
      throw UnknownException();
    }
  }
}
