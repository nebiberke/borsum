part of 'search_bloc.dart';

final class SearchState extends Equatable {
  SearchState({
    this.blocState = BlocState.initial,
    List<NewsEntity>? results,
    this.failure,
  }) : results = results ?? [];

  final BlocState blocState;
  final List<NewsEntity> results;
  final Failure? failure;

  @override
  List<Object?> get props => [blocState, results, failure];

  SearchState copyWith({
    BlocState? blocState,
    List<NewsEntity>? results,
    Failure? failure,
  }) {
    return SearchState(
      blocState: blocState ?? this.blocState,
      results: results ?? this.results,
      failure: failure ?? this.failure,
    );
  }
}
