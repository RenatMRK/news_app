part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final NewsArticle article;
  const ToggleFavoriteEvent(this.article);
}

class CheckFavoriteEvent extends FavoritesEvent {
  final String id;
  const CheckFavoriteEvent(this.id);
}
