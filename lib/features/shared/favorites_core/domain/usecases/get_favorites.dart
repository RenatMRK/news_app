import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/shared/favorites_core/domain/repository/i_favorites_repository.dart';

class GetFavorites {
  final IFavoritesRepository repository;
  GetFavorites(this.repository);

  Future<List<NewsArticle>> call() => repository.getAllFavorites();
}