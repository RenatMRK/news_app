import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';



abstract class FavoritesListState extends Equatable {
  const FavoritesListState();
  @override
  List<Object?> get props => [];
}

class FavoritesListInitial extends FavoritesListState {}
class FavoritesListLoading extends FavoritesListState {}
class FavoritesListError extends FavoritesListState {
  final String message;
  const FavoritesListError(this.message);
}
class FavoritesListLoaded extends FavoritesListState {
  final List<NewsArticle> favorites;
  const FavoritesListLoaded(this.favorites);
}
