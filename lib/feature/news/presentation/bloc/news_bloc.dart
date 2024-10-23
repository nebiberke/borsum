import 'dart:async';

import 'package:borsum/core/enums/bloc_state.dart';
import 'package:borsum/core/error/failures.dart';
import 'package:borsum/feature/news/domain/usecases/uc_get_news_with_id.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required UcGetNewsWithId ucGetNewsWithId})
      : _ucGetNewsWithId = ucGetNewsWithId,
        super(NewsState()) {
    on<FetchNewsWithId>(_onFetchNewsWithId);
  }

  final UcGetNewsWithId _ucGetNewsWithId;

  Future<void> _onFetchNewsWithId(
    FetchNewsWithId event,
    Emitter<NewsState> emit,
  ) async {
    emit(state.copyWith(blocState: BlocState.loading));
    final result = await _ucGetNewsWithId(event.id);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            blocState: BlocState.failure,
            failure: failure,
          ),
        );
      },
      (news) {
        emit(
          state.copyWith(
            blocState: BlocState.loaded,
            result: news,
          ),
        );
      },
    );
  }
}
