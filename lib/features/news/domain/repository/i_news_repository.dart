import 'package:news_app/features/news/domain/entities/article.dart';

abstract class INewsRepository {
  Future<List<NewsArticle>> getTopHeadlines({
    required NewsCategory category,
    String country,
    int page,
    int pageSize,
    String? query,
  });
}
