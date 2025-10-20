import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_app/app/di/di.dart';
import 'package:news_app/common/extensions/media_query_values.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/logic/favorites/favorites_bloc.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  String _formatPublishedAt(DateTime date) =>
      DateFormat('d MMM yyyy', 'ru').format(date);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final contentToShow =
        (article.content != null && article.content!.trim().isNotEmpty)
        ? article.content
        : article.summary;

    return BlocProvider(
      create: (_) => sl<FavoritesBloc>()..add(CheckFavoriteEvent(article.id)),
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final isFavorite = state is FavoriteStatusChanged
              ? state.isFavorite
              : false;
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: scheme.onPrimary,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back, size: 36, color: scheme.outline),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<FavoritesBloc>().add(
                      ToggleFavoriteEvent(article),
                    );
                  },
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: scheme.outline,
                    size: 38,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.scaleSp(33),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: context.scaleH(8)),
                  if (article.summary != null)
                    Text(
                      article.summary!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.scaleSp(27),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  SizedBox(height: context.scaleH(24)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (article.author != null)
                        Expanded(
                          child: Text(
                            article.author!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: context.scaleSp(19),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      Text(
                        _formatPublishedAt(article.publishedAt),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.scaleSp(19),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.scaleH(10)),
                  if (article.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(27),
                      child: Image.network(
                        article.imageUrl.toString(),
                        height: context.scaleH(265),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                  SizedBox(height: context.scaleH(10)),

                  if (contentToShow != null && contentToShow.trim().isNotEmpty)
                    Text(
                      contentToShow,
                      style: TextStyle(
                        fontSize: context.scaleSp(26),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
