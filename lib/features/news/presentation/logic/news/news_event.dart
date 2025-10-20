part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNewsEvent extends NewsEvent {
  final NewsCategory category;
  final String country;
  final int page;
  final int pageSize;
  final String? query;

  const LoadNewsEvent({
    required this.category,
    this.country = 'us',
    this.page = 1,
    this.pageSize = 20,
    this.query,
  });

  @override
  List<Object?> get props => [category, country, page, pageSize, query];
}
