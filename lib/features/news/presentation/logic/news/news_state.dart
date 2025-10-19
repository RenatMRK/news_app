part of 'news_bloc.dart';



/// 🔹 Состояния BLoC (что видит UI)
abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

/// Состояние по умолчанию
class NewsInitial extends NewsState {}

/// Новости загружаются
class NewsLoading extends NewsState {}

/// Новости успешно загружены
class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;

  const NewsLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

/// Произошла ошибка
class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
