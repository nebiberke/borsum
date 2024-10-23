import 'package:borsum/feature/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';

mixin SearchViewMixin on State<SearchView> {
  /// Controller for search text field
  final TextEditingController searchController = TextEditingController();

  /// Callback for search text field onSubmitted event
  void onSubmitted(String value) {
    print(value);
  }
}
