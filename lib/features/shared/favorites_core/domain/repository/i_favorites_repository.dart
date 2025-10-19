import 'package:news_app/features/news/domain/entities/article.dart';

abstract class IFavoritesRepository {
  Future<void> toggleFavorite(NewsArticle article);
  Future<bool> isFavorite(String id);
  Future<List<NewsArticle>> getAllFavorites();
}
