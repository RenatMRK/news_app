import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repository/i_news_repository.dart';

/// ✅ UseCase: Получить новости по категории
///
/// Это чистая бизнес-логика — ни Dio, ни http, ни JSON.
/// Вся конкретика будет в data-слое.
class GetNews {
  final INewsRepository repository;

  const GetNews(this.repository);

  /// Возвращает список статей по заданной категории
  Future<List<NewsArticle>> call(GetNewsParams params) async {
    return repository.getTopHeadlines(
      category: params.category,
      country: params.country,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

/// Параметры для GetNews (immutable + Equatable)
class GetNewsParams extends Equatable {
  final NewsCategory category;
  final String country;
  final int page;
  final int pageSize;

  const GetNewsParams({
    required this.category,
    this.country = 'us',
    this.page = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [category, country, page, pageSize];
}
