import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/favorites/presentation/logic/favorites_list_event.dart';
import 'package:news_app/features/favorites/presentation/logic/favorites_list_state.dart';
import 'package:news_app/features/shared/favorites_core/domain/usecases/get_favorites.dart';


class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  final GetFavorites getFavorites;

  FavoritesListBloc(this.getFavorites) : super(FavoritesListInitial()) {
    on<LoadFavoritesEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadFavoritesEvent event, Emitter<FavoritesListState> emit) async {
    emit(FavoritesListLoading());
    try {
      final favorites = await getFavorites();
      emit(FavoritesListLoaded(favorites));
    } catch (e) {
      emit(FavoritesListError(e.toString()));
    }
  }
}
