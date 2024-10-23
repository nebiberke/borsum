import 'package:borsum/core/enums/bloc_state.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/core/utils/extensions/context_extension.dart';
import 'package:borsum/feature/search/presentation/bloc/search_bloc.dart';
import 'package:borsum/feature/search/presentation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

mixin SearchViewMixin on State<SearchView> {
  /// Controller for search text field
  final TextEditingController searchController = TextEditingController();

  /// Callback for search text field onSubmitted event
  void onSubmitted(String query) {
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(FetchSearchResults(query: query));
    }
  }

  /// Listener for search bloc
  void searchBlocListener(BuildContext context, SearchState state) {
    if (state.blocState == BlocState.loaded) {
      context.push('/news');
    } else if (state.blocState == BlocState.failure) {
      final errorMessage = state.failure is NetworkFailure
          ? 'Network error'
          : state.failure is UnknownFailure
              ? 'Unknown error'
              : 'Error';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(errorMessage, style: context.textTheme.titleLarge),
          ),
          backgroundColor: context.theme.colorScheme.error,
        ),
      );
    }
  }
}
