import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/common/constants/app_icons.dart';
import 'package:news_app/common/extensions/media_query_values.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/logic/news/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/build_category_selector_widget.dart';
import 'package:news_app/features/news/presentation/widgets/news_list_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final categories = const [
    NewsCategory.business,
    NewsCategory.health,
    NewsCategory.entertainment,
    NewsCategory.general,
    NewsCategory.science,
    NewsCategory.sports,
    NewsCategory.technology,
  ];



  final ValueNotifier<NewsCategory> selectedCategory = ValueNotifier(
    NewsCategory.business,
  );

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(
      LoadNewsEvent(category: selectedCategory.value),
    );

    selectedCategory.addListener(() {
      context.read<NewsBloc>().add(
        LoadNewsEvent(category: selectedCategory.value),
      );
    });
  }

  @override
  void dispose() {
    selectedCategory.dispose();
    super.dispose();
  }

void _onSearchPressed() async {
  final result = await showSearch<String>(
    context: context,
    delegate: _NewsSearchDelegate(
      onQuerySelected: (query) {
        context.read<NewsBloc>().add(
          LoadNewsEvent(
            category: selectedCategory.value,
            query: query,
          ),
        );
      },
    ),
  );

  if (result != null && result.isNotEmpty) {
    context.read<NewsBloc>().add(
      LoadNewsEvent(category: selectedCategory.value, query: result),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppIcons.search),
          onPressed:  _onSearchPressed,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          ValueListenableBuilder<NewsCategory>(
            valueListenable: selectedCategory,
            builder: (context, value, _) {
              return BuildCategorySelectorWidget(
                categories: categories,
                selectedCategory: value,
                onSelect: (newCategory) => selectedCategory.value = newCategory,
              );
            },
          ),
           SizedBox(height: context.scaleH(10)),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  return NewsListWidget(
                    articles: state.articles,
             
                  );
                } else if (state is NewsError) {
                  return Center(child: Text('Ошибка: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsSearchDelegate extends SearchDelegate<String> {
  final void Function(String query) onQuerySelected;

  _NewsSearchDelegate({required this.onQuerySelected});

  @override
  String get searchFieldLabel => 'Поиск новостей...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

@override
Widget buildResults(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    onQuerySelected(query);
    close(context, query); 
  });

  return const SizedBox.shrink();
}
  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        query.isEmpty
            ? 'Введите запрос для поиска'
            : 'Нажмите Enter, чтобы искать "$query"',
      ),
    );
  }
}
