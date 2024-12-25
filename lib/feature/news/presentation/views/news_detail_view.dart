import 'package:borsum/core/enums/bloc_state.dart';
import 'package:borsum/core/enums/endpoint_enums.dart';
import 'package:borsum/core/utils/extensions/context_extension.dart';
import 'package:borsum/feature/news/presentation/bloc/news_bloc.dart';
import 'package:borsum/feature/news/presentation/cubit/news_summary_cubit.dart';
import 'package:borsum/feature/search/domain/entities/news_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part '../widgets/news_detail_loaded.dart';

final ValueNotifier<EndpointEnums?> selectedEndpointNotifier =
    ValueNotifier<EndpointEnums?>(null);

class NewsDetailView extends StatefulWidget {
  const NewsDetailView({required this.newsId, super.key});
  final int newsId;

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  late String newsArticle;
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
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffD1E910),
          ),
          onPressed: () => _showNewsSummary(context, newsArticle),
          child: Text(
            'Haberi Özetle',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return switch (state.blocState) {
            BlocState.loading || BlocState.initial => const Center(
                child: CircularProgressIndicator(),
              ),
            BlocState.loaded => Builder(
                builder: (context) {
                  newsArticle = state.result.article;
                  return _NewsDetailLoaded(news: state.result);
                },
              ),
            BlocState.failure => const Center(
                child: Text('Error'),
              ),
          };
        },
      ),
    );
  }

  Future<void> _showNewsSummary(BuildContext context, String article) async {
    await showDialog<EndpointEnums>(
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text('Haber Özeti'),
            content: const DropdownSelectorInputField(),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tamam'),
              ),
            ],
          ),
        );
      },
    );

    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      constraints: BoxConstraints(
        minHeight: 0.5.sh,
        minWidth: 1.sw,
      ),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32.r),
        ),
      ),
      builder: (context) => BlocBuilder<NewsSummaryCubit, NewsSummaryState>(
        builder: (context, state) {
          return switch (state.blocState) {
            BlocState.loading || BlocState.initial => const Center(
                child: CircularProgressIndicator(),
              ),
            BlocState.loaded => _NewsSummaryLoaded(newsSummary: state.summary),
            BlocState.failure => const Center(
                child: Text('Error'),
              ),
          };
        },
      ),
    );
    if (!context.mounted) return;
    if (selectedEndpointNotifier.value != null) {
      await context
          .read<NewsSummaryCubit>()
          .fetchNewsSummary(article, selectedEndpointNotifier.value!);
    }
  }
}

final class _NewsSummaryLoaded extends StatelessWidget {
  const _NewsSummaryLoaded({required this.newsSummary});
  final String newsSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScreenUtil().setVerticalSpacing(24),
          Text(
            'Haber Özeti Modeli',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          ScreenUtil().setVerticalSpacing(24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              newsSummary,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownSelectorInputField extends StatefulWidget {
  const DropdownSelectorInputField({super.key});
  @override
  State<DropdownSelectorInputField> createState() =>
      _DropdownSelectorInputFieldState();
}

class _DropdownSelectorInputFieldState
    extends State<DropdownSelectorInputField> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EndpointEnums?>(
      valueListenable: selectedEndpointNotifier,
      builder: (context, selectedEndpoint, child) {
        return DropdownButtonFormField<EndpointEnums>(
          value: selectedEndpoint,
          items: EndpointEnums.values.map((EndpointEnums endpoint) {
            return DropdownMenuItem<EndpointEnums>(
              value: endpoint,
              child: Text(endpoint.name),
            );
          }).toList(),
          onChanged: (EndpointEnums? newValue) {
            selectedEndpointNotifier.value = newValue;
          },
        );
      },
    );
  }
}
