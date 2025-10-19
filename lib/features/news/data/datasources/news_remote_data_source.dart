import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/features/news/data/dto/news_article_dto.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

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
  final http.Client httpClient;
  final String apiKey;

  const NewsRemoteDataSourceImpl({
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
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'apiKey': apiKey,
      'category': category.name,
      'country': country,
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Ошибка при запросе: ${response.statusCode}');
    }

    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    if (jsonBody['status'] != 'ok') {
      throw Exception('Ошибка API: ${jsonBody['message']}');
    }

    final articlesJson = jsonBody['articles'] as List<dynamic>;

    return articlesJson.map((json) {
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
  }
}