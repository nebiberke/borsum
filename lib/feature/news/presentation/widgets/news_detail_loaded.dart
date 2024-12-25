part of '../views/news_detail_view.dart';

final class _NewsDetailLoaded extends StatelessWidget {
  const _NewsDetailLoaded({required this.news});
  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Column(
          children: [
            Image.network(
              news.image,
              width: 1.sw,
            ),
            ScreenUtil().setVerticalSpacing(24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  news.title,
                  style: context.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ScreenUtil().setVerticalSpacing(24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                news.description,
                style: context.textTheme.bodyMedium,
              ),
            ),
            ScreenUtil().setVerticalSpacing(24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                news.article,
                style: context.textTheme.bodyMedium,
              ),
            ),
            ScreenUtil().setVerticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
