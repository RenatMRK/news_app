import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

/// DTO для новостной статьи в слое данных
class NewsArticleDto extends Equatable {
  final String id;
  final String title;
  final String? summary;
  final String url;
  final String? imageUrl;
  final String publishedAt; // Используем String для JSON-сериализации
  final NewsSourceDto source;
  final String? author;
  final String category; // Используем String для JSON-сериализации

  const NewsArticleDto({
    required this.id,
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.source,
    required this.category,
    this.summary,
    this.imageUrl,
    this.author,
  });

  /// Создание DTO из JSON
  factory NewsArticleDto.fromJson(Map<String, dynamic> json) {
    return NewsArticleDto(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      url: json['url'] as String,
      imageUrl: json['imageUrl'] as String?,
      publishedAt: json['publishedAt'] as String,
      source: NewsSourceDto.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      category: json['category'] as String,
    );
  }

  /// Преобразование DTO в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'url': url,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
      'source': source.toJson(),
      'author': author,
      'category': category,
    };
  }

  /// Маппинг DTO в доменную модель NewsArticle
  NewsArticle toDomain() {
    return NewsArticle(
      id: id,
      title: title,
      summary: summary,
      url: Uri.parse(url),
      imageUrl: imageUrl != null ? Uri.parse(imageUrl!) : null,
      publishedAt: DateTime.parse(publishedAt),
      source: source.toDomain(),
      author: author,
      category: _mapStringToCategory(category),
    );
  }

  /// Маппинг строки категории в enum NewsCategory
  NewsCategory _mapStringToCategory(String category) {
    switch (category.toLowerCase()) {
      case 'business':
        return NewsCategory.business;
      case 'entertainment':
        return NewsCategory.entertainment;
      case 'general':
        return NewsCategory.general;
      case 'health':
        return NewsCategory.health;
      case 'science':
        return NewsCategory.science;
      case 'sports':
        return NewsCategory.sports;
      case 'technology':
        return NewsCategory.technology;
      default:
        return NewsCategory.general; // Значение по умолчанию
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        url,
        imageUrl,
        publishedAt,
        source,
        author,
        category,
      ];
}

/// DTO для источника новости
class NewsSourceDto extends Equatable {
  final String? id;
  final String name;

  const NewsSourceDto({this.id, required this.name});

  /// Создание DTO из JSON
  factory NewsSourceDto.fromJson(Map<String, dynamic> json) {
    return NewsSourceDto(
      id: json['id'] as String?,
      name: json['name'] as String,
    );
  }

  /// Преобразование DTO в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  /// Маппинг DTO в доменную модель NewsSource
  NewsSource toDomain() {
    return NewsSource(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}