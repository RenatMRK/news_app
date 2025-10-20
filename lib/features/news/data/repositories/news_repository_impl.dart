import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repository/i_news_repository.dart';
import 'package:news_app/features/news/data/datasources/news_remote_data_source.dart';


class NewsRepositoryImpl implements INewsRepository {
  final INewsRemoteDataSource remoteDataSource;

  const NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NewsArticle>> getTopHeadlines({
    required NewsCategory category,
    String country = 'us',
    int page = 1,
    int pageSize = 20,
    String? query,
  }) async {
    final dtos = await remoteDataSource.fetchTopHeadlines(
      category: category,
      country: country,
      page: page,
      pageSize: pageSize,
      query: query,
    );

    return dtos.map((dto) => dto.toDomain()).toList();
  }
}
