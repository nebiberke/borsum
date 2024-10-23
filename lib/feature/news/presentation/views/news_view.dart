import 'package:borsum/core/enums/bloc_state.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:borsum/feature/search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

part '../widgets/news_card.dart';
part '../widgets/news_loaded_widget.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return switch (state.blocState) {
          BlocState.initial || BlocState.loading => const Center(
              child: CircularProgressIndicator(),
            ),
          BlocState.loaded => _NewsViewLoaded(news: state.results),
          BlocState.failure => _buildErrorWidget(state, context),
        };
      },
    );
  }

  Center _buildErrorWidget(SearchState state, BuildContext context) {
    if (state.failure is NetworkFailure) {
      return const Center(
        child: Text('Network Failure'),
      );
    } else if (state.failure is UnknownFailure) {
      return const Center(
        child: Text('Server Failure'),
      );
    } else {
      return const Center(
        child: Text('Unknown Failure'),
      );
    }
  }
}
