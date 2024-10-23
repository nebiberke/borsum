part of '../views/search_view.dart';

final class _SearchViewLoaded extends StatelessWidget {
  const _SearchViewLoaded({
    required this.hintText,
    required this.searchController,
    required this.onSubmitted,
  });
  final String hintText;
  final TextEditingController searchController;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: CustomTextField(
            hintText: 'Hisse kodu giriniz...',
            controller: searchController,
            onSubmitted: onSubmitted,
          ),
        ),
      ),
    );
  }
}
