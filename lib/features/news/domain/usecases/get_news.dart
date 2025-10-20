import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repository/i_news_repository.dart';


class GetNews {
  final INewsRepository repository;

  const GetNews(this.repository);

  Future<List<NewsArticle>> call(GetNewsParams params) async {
    return repository.getTopHeadlines(
      category: params.category,
      country: params.country,
      page: params.page,
      pageSize: params.pageSize,
      query: params.query,
    );
  }
}

class GetNewsParams extends Equatable {
  final NewsCategory category;
  final String country;
  final int page;
  final int pageSize;
  final String? query;

  const GetNewsParams({
    required this.category,
    this.country = 'us',
    this.page = 1,
    this.pageSize = 20,
    this.query,
  });

  @override
  List<Object?> get props => [category, country, page, pageSize, query];
}
