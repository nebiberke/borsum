part of 'news_bloc.dart';

abstract final class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchNewsWithId extends NewsEvent {
  FetchNewsWithId({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
