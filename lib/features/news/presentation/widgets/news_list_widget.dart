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
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
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
              borderRadius: BorderRadius.circular(14),
              border: Border.all(width: 2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: context.scaleH(112),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: article.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(article.imageUrl.toString()),
                            fit: BoxFit.cover,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.scaleW(100),
                        child: Text(
                          article.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (article.summary != null)
                        SizedBox(
                          width: context.scaleW(100),
                          child: Text(
                            article.summary!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ),
                      const Spacer(),
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
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
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
