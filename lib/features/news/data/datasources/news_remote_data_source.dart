import 'package:logger/logger.dart';
import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/features/news/data/dto/news_article_dto.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

/// Абстрактный источник данных для новостей
abstract class INewsRemoteDataSource {
  Future<List<NewsArticleDto>> fetchTopHeadlines({
    required NewsCategory category,
    String country,
    int page,
    int pageSize,
  });
}

/// Реализация remote data source через NewsAPI.org
class NewsRemoteDataSourceImpl implements INewsRemoteDataSource {
  final ApiClient httpClient;
  final String apiKey;

  /// Логгер (один на весь источник)
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  NewsRemoteDataSourceImpl({
    required this.httpClient,
    required this.apiKey,
  });

  static const _baseUrl = 'https://newsapi.org/v2/top-headlines';

  @override
  Future<List<NewsArticleDto>> fetchTopHeadlines({
    required NewsCategory category,
    String country = 'us',
    int page = 1,
    int pageSize = 20,
  }) async {
    // 🔹 Собираем query-параметры
    final queryParams = {
      'apiKey': apiKey,
      'category': category.name,
      'country': country,
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };

    _logger.i('🌍 [REQUEST] $_baseUrl\nParams: $queryParams');

    // 🔹 Делаем запрос через абстракцию
    final response = await httpClient.get(_baseUrl, query: queryParams);

    // 🔹 Проверяем статус
    if (response['status'] != 'ok') {
      _logger.e('⚠️ Ошибка API: ${response['message']}');
      throw Exception('Ошибка API: ${response['message']}');
    }

    final articlesJson = response['articles'] as List<dynamic>;
    _logger.i('📰 Получено статей: ${articlesJson.length}');

    // 🔹 Пример первой статьи
    if (articlesJson.isNotEmpty) {
      final preview = articlesJson.first;
      _logger.d('🧩 Пример первой статьи: ${preview.toString().substring(0, 300)}...');
    }

    // 🔹 Преобразуем в DTO
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
