import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/common/constants/app_icons.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/logic/news/news_bloc.dart';
import 'package:news_app/features/news/presentation/pages/widgets/build_category_selector_widget.dart';
import 'package:news_app/features/news/presentation/pages/widgets/news_list_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppIcons.search),
          onPressed: () {},
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
          const SizedBox(height: 8),
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
