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


// class NewsDetailScreen extends StatefulWidget {
//   final NewsArticle article;

//   const NewsDetailScreen({super.key, required this.article});

//   @override
//   State<NewsDetailScreen> createState() => _NewsDetailScreenState();
// }

// class _NewsDetailScreenState extends State<NewsDetailScreen> {
//   bool? isFavorite;
//   final _favorites = sl<FavoritesStorage>();

//   @override
//   void initState() {
//     super.initState();
//     _initFavorite();
//   }

//   Future<void> _initFavorite() async {
//     isFavorite = await _favorites.isFavorite(widget.article.id);
//     setState(() {});
//   }

//   Future<void> _toggleFavorite() async {
//     await _favorites.toggleFavorite(widget.article);
//     final newValue = await _favorites.isFavorite(widget.article.id);
//     setState(() => isFavorite = newValue);
//   }

//   String _formatPublishedAt(DateTime date) =>
//       DateFormat('d MMM yyyy').format(date);

//   @override
//   Widget build(BuildContext context) {
//     final scheme = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => context.pop(),
//           icon: const Icon(Icons.arrow_back, size: 36),
//         ),
//         actions: [
//           IconButton(
//             onPressed: _toggleFavorite,
//             icon: Icon(
//               (isFavorite ?? false) ? Icons.star : Icons.star_border,
//               color: scheme.outlineVariant,
//               size: 38,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.article.title,
//               style: Theme.of(
//                 context,
//               ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             if (widget.article.summary != null)
//               Text(
//                 widget.article.summary!,
//                 style: Theme.of(
//                   context,
//                 ).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
//               ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (widget.article.author != null)
//                   Expanded(
//                     child: Text(
//                       widget.article.author ?? '',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(
//                         context,
//                       ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
//                     ),
//                   ),
//                 Text(
//                   _formatPublishedAt(widget.article.publishedAt),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             if (widget.article.imageUrl != null)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(27),
//                 child: Image.network(
//                   widget.article.imageUrl.toString(),
//                   height: context.scaleH(265),
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             const SizedBox(height: 16),
//             if (widget.article.content != null)
//               Text(
//                 widget.article.content!,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FavoritesStorage {
//   static const _key = 'favorites_articles';
//   final _logger = Logger();

//   /// Получаем все избранные
//   Future<List<NewsArticle>> getFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonList = prefs.getStringList(_key) ?? [];

//     _logger.d('📦 Загружено избранных: ${jsonList.length}');

//     return jsonList.map((item) {
//       final map = jsonDecode(item);
//       return NewsArticle(
//         id: map['id'],
//         title: map['title'],
//         summary: map['summary'],
//         content: map['content'],
//         url: Uri.parse(map['url']),
//         imageUrl: map['imageUrl'] != null ? Uri.parse(map['imageUrl']) : null,
//         publishedAt: DateTime.parse(map['publishedAt']),
//         source: NewsSource(
//           id: map['source']['id'],
//           name: map['source']['name'],
//         ),
//         author: map['author'],
//         category: NewsCategory.values.firstWhere(
//           (c) => c.name == map['category'],
//           orElse: () => NewsCategory.general,
//         ),
//       );
//     }).toList();
//   }

//   /// Проверяем, сохранена ли статья
//   Future<bool> isFavorite(String id) async {
//     final favorites = await getFavorites();
//     final result = favorites.any((a) => a.id == id);
//     _logger.d('🔍 Статья $id избранная: $result');
//     return result;
//   }

//   /// Добавить / удалить статью из избранных
//   Future<void> toggleFavorite(NewsArticle article) async {
//     final prefs = await SharedPreferences.getInstance();
//     final favorites = await getFavorites();

//     final exists = favorites.any((a) => a.id == article.id);
//     if (exists) {
//       favorites.removeWhere((a) => a.id == article.id);
//       _logger.w('🗑 Удалено из избранного: ${article.title}');
//     } else {
//       favorites.add(article);
//       _logger.i('⭐ Добавлено в избранное: ${article.title}');
//     }

//     final jsonList = favorites
//         .map(
//           (a) => jsonEncode({
//             'id': a.id,
//             'title': a.title,
//             'summary': a.summary,
//             'content': a.content,
//             'url': a.url.toString(),
//             'imageUrl': a.imageUrl?.toString(),
//             'publishedAt': a.publishedAt.toIso8601String(),
//             'source': {'id': a.source.id, 'name': a.source.name},
//             'author': a.author,
//             'category': a.category.name,
//           }),
//         )
//         .toList();

//     await prefs.setStringList(_key, jsonList);

//     // 💾 Показываем, что реально сохранилось
//     _logger.d('📥 Сохранено ${jsonList.length} избранных');
//     if (jsonList.isNotEmpty) {
//       _logger.d('🧩 Пример первого: ${jsonList.first.substring(0, 200)}...');
//     }
//   }
// }
