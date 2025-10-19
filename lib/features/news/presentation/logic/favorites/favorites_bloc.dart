import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/shared/favorites_core/domain/usecases/is_favorite.dart';
import 'package:news_app/features/shared/favorites_core/domain/usecases/toggle_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ToggleFavorite toggleFavorite;
  final IsFavorite isFavorite;

  FavoritesBloc(this.toggleFavorite, this.isFavorite)
      : super(FavoritesInitial()) {
    on<ToggleFavoriteEvent>(_onToggle);
    on<CheckFavoriteEvent>(_onCheck);
  }

  Future<void> _onToggle(
      ToggleFavoriteEvent event, Emitter<FavoritesState> emit) async {
    await toggleFavorite(event.article);
    final result = await isFavorite(event.article.id);
    emit(FavoriteStatusChanged(result));
  }

  Future<void> _onCheck(
      CheckFavoriteEvent event, Emitter<FavoritesState> emit) async {
    final result = await isFavorite(event.id);
    emit(FavoriteStatusChanged(result));
  }
}
