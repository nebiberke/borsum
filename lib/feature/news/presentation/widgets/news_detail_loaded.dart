part of '../views/news_detail_view.dart';

final class _NewsDetailLoaded extends StatelessWidget {
  const _NewsDetailLoaded({required this.news});
  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(news.title),
    );
  }
}
