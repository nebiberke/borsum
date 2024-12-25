import 'package:borsum/core/enums/bloc_state.dart';
import 'package:borsum/core/enums/endpoint_enums.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/news/domain/usecases/uc_get_news_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './news_summary_state.dart';

final class NewsSummaryCubit extends Cubit<NewsSummaryState> {
  NewsSummaryCubit({
    required UcGetNewsSummary ucGetNewsSummary,
  })  : _ucGetNewsSummary = ucGetNewsSummary,
        super(const NewsSummaryState());

  final UcGetNewsSummary _ucGetNewsSummary;

  Future<void> fetchNewsSummary(String article, EndpointEnums endpoints) async {
    emit(state.copyWith(blocState: BlocState.loading));
    final result = await _ucGetNewsSummary(article, endpoints);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            blocState: BlocState.failure,
            failure: failure,
          ),
        );
      },
      (summary) {
        emit(
          state.copyWith(
            blocState: BlocState.loaded,
            summary: summary,
          ),
        );
      },
    );
  }
}
