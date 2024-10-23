part of 'news_bloc.dart';

final class NewsState extends Equatable {
  NewsState({
    this.blocState = BlocState.initial,
    NewsEntity? result,
    this.failure,
  }) : result = result ?? NewsEntity.empty();

  final BlocState blocState;
  final NewsEntity result;
  final Failure? failure;

  @override
  List<Object?> get props => [blocState, result, failure];

  NewsState copyWith({
    BlocState? blocState,
    NewsEntity? result,
    Failure? failure,
  }) {
    return NewsState(
      blocState: blocState ?? this.blocState,
      result: result ?? this.result,
      failure: failure ?? this.failure,
    );
  }
}
