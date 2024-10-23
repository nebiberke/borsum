import 'package:borsum/feature/news/presentation/views/news_detail_view.dart';
import 'package:borsum/feature/news/presentation/views/news_view.dart';
import 'package:borsum/feature/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  /// The [GoRouter] instance
  static GoRouter router = GoRouter(
    initialLocation: '/search',
    routes: [
      /// Search View
      GoRoute(
        path: '/search',
        name: 'Search',
        builder: (BuildContext context, GoRouterState state) =>
            const SearchView(),
      ),

      /// News View
      GoRoute(
        path: '/news',
        name: 'News',
        builder: (BuildContext context, GoRouterState state) =>
            const NewsView(),
        routes: [
          GoRoute(
            path: 'detail/:id',
            name: 'NewsDetail',
            builder: (BuildContext context, GoRouterState state) {
              final id = state.pathParameters['id']!;
              final newsId = int.tryParse(id) ?? 0;
              return NewsDetailView(newsId: newsId);
            },
          ),
        ],
      ),
    ],
  );
}
