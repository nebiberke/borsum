import 'package:borsum/app/widgets/custom_text_field.dart';
import 'package:borsum/feature/search/presentation/views/search_view_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SearchViewMixin {
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
