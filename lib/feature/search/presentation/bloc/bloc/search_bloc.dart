import 'package:borsum/core/enums/bloc_state.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:borsum/feature/search/domain/usecases/uc_search_stock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required UcSearchStock ucSearchStock})
      : _ucSearchStock = ucSearchStock,
        super(SearchState()) {
    on<FetchSearchResults>(_onFetchSearchResults);
  }

  final UcSearchStock _ucSearchStock;

  Future<void> _onFetchSearchResults(
    FetchSearchResults event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(blocState: BlocState.loading));
    final result = await _ucSearchStock(event.query);
    result.fold(
      (failure) => emit(
        state.copyWith(blocState: BlocState.failure, failure: failure),
      ),
      (searchResults) => emit(
        state.copyWith(blocState: BlocState.loaded, results: searchResults),
      ),
    );
  }
}
