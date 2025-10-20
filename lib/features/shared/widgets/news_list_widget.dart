import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/common/constants/app_routes.dart';
import 'package:news_app/common/extensions/media_query_values.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:intl/intl.dart';

class NewsListWidget extends StatelessWidget {
  final List<NewsArticle> articles;

  final void Function(NewsArticle)? onTapArticle;

  final Widget? icon;

  const NewsListWidget({
    super.key,
    required this.articles,
    this.icon,
    this.onTapArticle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      separatorBuilder: (_, __) => SizedBox(height: context.scaleH(16)),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return GestureDetector(
          onTap: () {
            if (onTapArticle != null) {
              onTapArticle!(article);
            } else {
              context.pushNamed(AppRoutes.newsDetailName, extra: article);
            }
          },
          child: Container(
            height: context.scaleH(112),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 0.5, color: scheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: scheme.onSurface.withValues(alpha: 0.15),
                  blurRadius: 6.1,
                  offset: const Offset(0, 3),
                ),
              ],
              color: scheme.surface,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.scaleW(123),
                  height: context.scaleH(112),
                  decoration: BoxDecoration(
                    image: article.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(article.imageUrl.toString()),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: scheme.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
                SizedBox(width: context.scaleW(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.scaleH(5)),

                      SizedBox(
                        width: context.scaleW(120),
                        child: Text(
                          article.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: context.scaleW(24),
                          ),
                        ),
                      ),
                      if (article.summary != null)
                        SizedBox(
                          width: context.scaleW(100),
                          child: Text(
                            article.summary!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: context.scaleSp(19),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    icon ?? const SizedBox(),
                    Text(
                      _formatPublishedAt(article.publishedAt),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: context.scaleSp(17),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: context.scaleW(11)),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatPublishedAt(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} мин назад';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ч назад';
    } else {
      return DateFormat('d MMM yyyy', 'ru').format(date);
    }
  }
}
