part of 'search_bloc.dart';

abstract final class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchSearchResults extends SearchEvent {
  FetchSearchResults({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
