import 'package:news_app/features/shared/favorites_core/domain/repository/i_favorites_repository.dart';

class IsFavorite {
  final IFavoritesRepository repository;

  IsFavorite(this.repository);

  Future<bool> call(String id) => repository.isFavorite(id);
}