import 'package:borsum/core/enums/bloc_state.dart';
import 'package:borsum/feature/news/presentation/bloc/news_bloc.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widgets/news_detail_loaded.dart';

class NewsDetailView extends StatefulWidget {
  const NewsDetailView({required this.newsId, super.key});
  final int newsId;

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(FetchNewsWithId(id: widget.newsId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return switch (state.blocState) {
            BlocState.loading || BlocState.initial => const Center(
                child: CircularProgressIndicator(),
              ),
            BlocState.loaded => _NewsDetailLoaded(news: state.result),
            BlocState.failure => const Center(
                child: Text('Error'),
              ),
          };
        },
      ),
    );
  }
}
