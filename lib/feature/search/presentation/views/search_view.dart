import 'package:borsum/app/widgets/custom_text_field.dart';
import 'package:borsum/feature/search/presentation/bloc/search_bloc.dart';
import 'package:borsum/feature/search/presentation/views/search_view_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part '../widgets/search_view_loaded.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SearchViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: searchBlocListener,
      builder: (context, state) {
        return _SearchViewLoaded(
          hintText: 'Hisse kodu giriniz...',
          searchController: searchController,
          onSubmitted: onSubmitted,
        );
      },
    );
  }
}
