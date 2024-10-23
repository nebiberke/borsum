part of '../views/news_view.dart';

final class _NewsViewLoaded extends StatelessWidget {
  const _NewsViewLoaded({required this.news});
  final List<NewsEntity> news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          childAspectRatio: 3 / 4,
        ),
        padding: EdgeInsets.all(16.r),
        itemCount: news.length,
        itemBuilder: (context, index) {
          final newsItem = news[index];
          return _NewsCard(newsItem: newsItem);
        },
      ),
    );
  }
}
