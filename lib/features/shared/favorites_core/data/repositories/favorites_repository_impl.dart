import 'package:news_app/features/shared/favorites_core/data/datasources/favorites_local_data_source.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/shared/favorites_core/domain/repository/i_favorites_repository.dart';

class FavoritesRepositoryImpl implements IFavoritesRepository {
  final IFavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl(this.localDataSource);

  @override
  Future<bool> isFavorite(String id) async {
    final rawList = await localDataSource.getFavoritesRaw();
    return rawList.any((e) => e['id'] == id);
  }

  @override
  Future<void> toggleFavorite(NewsArticle article) async {
    final rawList = await localDataSource.getFavoritesRaw();

    final exists = rawList.any((e) => e['id'] == article.id);
    if (exists) {
      rawList.removeWhere((e) => e['id'] == article.id);
    } else {
      rawList.add({
        'id': article.id,
        'title': article.title,
        'summary': article.summary,
        'content': article.content,
        'url': article.url.toString(),
        'imageUrl': article.imageUrl?.toString(),
        'publishedAt': article.publishedAt.toIso8601String(),
        'source': {'id': article.source.id, 'name': article.source.name},
        'author': article.author,
        'category': article.category.name,
      });
    }

    await localDataSource.saveFavoritesRaw(rawList);
  }

  @override
Future<List<NewsArticle>> getAllFavorites() async {
  final rawList = await localDataSource.getFavoritesRaw();
  return rawList.map((e) {
    return NewsArticle(
      id: e['id'],
      title: e['title'],
      summary: e['summary'],
      content: e['content'],
      url: Uri.parse(e['url']),
      imageUrl: e['imageUrl'] != null ? Uri.parse(e['imageUrl']) : null,
      publishedAt: DateTime.parse(e['publishedAt']),
      source: NewsSource(
        id: e['source']['id'],
        name: e['source']['name'],
      ),
      author: e['author'],
      category: NewsCategory.values.firstWhere(
        (c) => c.name == e['category'],
        orElse: () => NewsCategory.general,
      ),
    );
  }).toList();
}
}
