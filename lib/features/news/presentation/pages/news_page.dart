import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/common/constants/app_icons.dart';
import 'package:news_app/common/extensions/media_query_values.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final categories = const [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  String selectedCategory = 'general';

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
          BuildCategorySelectorWidget(
            categories: categories,
            selectedCategory: selectedCategory,
            onSelect: (value) {
              setState(() => selectedCategory = value);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BuildNewsListWidget(selectedCategory: selectedCategory),
          ),
        ],
      ),
    );
  }
}

/// Категории
class BuildCategorySelectorWidget extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelect;

  const BuildCategorySelectorWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return GestureDetector(
            onTap: () => onSelect(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  category[0].toUpperCase() + category.substring(1),
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Список новостей (mock)
class BuildNewsListWidget extends StatelessWidget {
  final String selectedCategory;
  const BuildNewsListWidget({
    super.key,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final mockArticles = List.generate(
      10,
      (i) => {
        'title': 'Новость №${i + 1} (${selectedCategory.toUpperCase()})',
        'subtitle': 'Описание новости категории $selectedCategory',
      },
    );

    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: mockArticles.length,
      itemBuilder: (context, index) {
        final article = mockArticles[index];
        return Container(
          height: context.scaleH(112),
          child: Row(
            children: [
              Container(
                height: context.scaleH(112),
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(article['subtitle']!),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '3 часа назад',
                          textAlign: TextAlign.right,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
