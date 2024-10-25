part of 'news_summary_cubit.dart';

final class NewsSummaryState extends Equatable {
  const NewsSummaryState({
    this.blocState = BlocState.initial,
    String? summary,
    this.failure,
  }) : summary = summary ?? '';

  final BlocState blocState;
  final String summary;
  final Failure? failure;

  @override
  List<Object?> get props => [blocState, summary, failure];

  NewsSummaryState copyWith({
    BlocState? blocState,
    String? summary,
    Failure? failure,
  }) {
    return NewsSummaryState(
      blocState: blocState ?? this.blocState,
      summary: summary ?? this.summary,
      failure: failure ?? this.failure,
    );
  }
}
