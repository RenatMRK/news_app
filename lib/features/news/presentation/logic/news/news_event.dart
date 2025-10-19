part of 'news_bloc.dart';


/// 🔹 События BLoC (что может происходить)
abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

/// Загрузить новости по категории
class LoadNewsEvent extends NewsEvent {
  final NewsCategory category;
  final String country;
  final int page;
  final int pageSize;

  const LoadNewsEvent({
    required this.category,
    this.country = 'us',
    this.page = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [category, country, page, pageSize];
}
