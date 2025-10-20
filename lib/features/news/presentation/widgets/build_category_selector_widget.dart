import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/media_query_values.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class BuildCategorySelectorWidget extends StatelessWidget {
  final List<NewsCategory> categories;
  final NewsCategory selectedCategory;
  final ValueChanged<NewsCategory> onSelect;

  const BuildCategorySelectorWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: context.scaleH(44),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: context.scaleH(7)),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return GestureDetector(
            onTap: () => onSelect(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? scheme.primary : scheme.secondary,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: Text(
                  category.name[0].toUpperCase() +
                      category.name.substring(1).toLowerCase(),
                  style: TextStyle(
                    fontSize: context.scaleSp(14),
                    fontWeight: FontWeight.w400,
                    color: scheme.onPrimary,
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
