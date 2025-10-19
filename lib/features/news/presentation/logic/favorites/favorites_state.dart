part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoriteStatusChanged extends FavoritesState {
  final bool isFavorite;
  final DateTime timestamp; 

  FavoriteStatusChanged(this.isFavorite)
      : timestamp = DateTime.now(); 

  @override
  List<Object?> get props => [isFavorite, timestamp];
}