import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/shared/favorites_core/domain/repository/i_favorites_repository.dart';

class ToggleFavorite {
  final IFavoritesRepository repository;

  ToggleFavorite(this.repository);

  Future<void> call(NewsArticle article) => repository.toggleFavorite(article);
}