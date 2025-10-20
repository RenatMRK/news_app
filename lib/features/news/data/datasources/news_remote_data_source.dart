import 'package:logger/logger.dart';
import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/features/news/data/dto/news_article_dto.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class INewsRemoteDataSource {
  Future<List<NewsArticleDto>> fetchTopHeadlines({
    required NewsCategory category,
    String country,
    int page,
    int pageSize,
    String? query,
  });
}

class NewsRemoteDataSourceImpl implements INewsRemoteDataSource {
  final ApiClient httpClient;
  final String apiKey;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 100,
      colors: true,
      printEmojis: true,
    ),
  );

  NewsRemoteDataSourceImpl({required this.httpClient, required this.apiKey});

  static const _topHeadlinesUrl = 'https://newsapi.org/v2/top-headlines';
  static const _searchUrl = 'https://newsapi.org/v2/everything';

  @override
  Future<List<NewsArticleDto>> fetchTopHeadlines({
    required NewsCategory category,
    String country = 'us',
    int page = 1,
    int pageSize = 20,
    String? query,
  }) async {
    final isSearch = query != null && query.isNotEmpty;
    final url = isSearch ? _searchUrl : _topHeadlinesUrl;

    final queryParams = {
      'apiKey': apiKey,
      'page': '$page',
      'pageSize': '$pageSize',
      if (isSearch) 'q': query,
      if (!isSearch) 'country': country,
      if (!isSearch) 'category': category.name,
      if (isSearch) 'language': 'ru',
      'sortBy': 'publishedAt',
    };

    _logger.i('🌍 [REQUEST] $url\nParams: $queryParams');

    final response = await httpClient.get(url, query: queryParams);

    if (response['status'] != 'ok') {
      _logger.e('⚠️ Ошибка API: ${response['message']}');
      throw Exception('Ошибка API: ${response['message']}');
    }

    final articlesJson = response['articles'] as List<dynamic>;
    _logger.i('📰 Получено статей: ${articlesJson.length}');

    final result = articlesJson.map((json) {
      final map = json as Map<String, dynamic>;
      return NewsArticleDto(
        id: map['url'] ?? '',
        title: map['title'] ?? '',
        summary: map['description'],
        url: map['url'] ?? '',
        imageUrl: map['urlToImage'],
        publishedAt: map['publishedAt'] ?? DateTime.now().toIso8601String(),
        source: NewsSourceDto.fromJson(map['source'] ?? {}),
        author: map['author'],
        category: category.name,
      );
    }).toList();

    _logger.i('✅ [SUCCESS] DTO готов (${result.length} элементов)');
    return result;
  }
}
