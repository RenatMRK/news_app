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

    return BlocProvider(
      create: (_) => sl<FavoritesBloc>()..add(CheckFavoriteEvent(article.id)),
      child: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final isFavorite =
              state is FavoriteStatusChanged ? state.isFavorite : false;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back, size: 36),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context
                        .read<FavoritesBloc>()
                        .add(ToggleFavoriteEvent(article));
                  },
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: scheme.outlineVariant,
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
                  // 📰 Заголовок
                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // 📄 Краткое описание
                  if (article.summary != null)
                    Text(
                      article.summary!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey[700]),
                    ),

                  // 👤 Автор + дата
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (article.author != null)
                        Expanded(
                          child: Text(
                            article.author!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ),
                      Text(
                        _formatPublishedAt(article.publishedAt),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 🖼 Фото
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

                  const SizedBox(height: 16),

                  // 📜 Основной контент
                  if (article.content != null)
                    Text(
                      article.content!,
                      style: Theme.of(context).textTheme.bodyMedium,
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

