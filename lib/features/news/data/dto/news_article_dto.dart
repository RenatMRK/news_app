import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class NewsArticleDto extends Equatable {
  final String id;
  final String title;
  final String? summary;
  final String? content; 
  final String url;
  final String? imageUrl;
  final String publishedAt;
  final NewsSourceDto source;
  final String? author;
  final String category;

  const NewsArticleDto({
    required this.id,
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.source,
    required this.category,
    this.summary,
    this.content,
    this.imageUrl,
    this.author,
  });

  factory NewsArticleDto.fromJson(Map<String, dynamic> json) {
    return NewsArticleDto(
      id: json['url'] ?? '', 
      title: json['title'] ?? '',
      summary: json['description'],
      content: json['content'], 
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? DateTime.now().toIso8601String(),
      source: NewsSourceDto.fromJson(json['source'] ?? {}),
      author: json['author'],
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'url': url,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
      'source': source.toJson(),
      'author': author,
      'category': category,
    };
  }

  NewsArticle toDomain() {
    return NewsArticle(
      id: id,
      title: title,
      summary: summary,
      content: content, 
      url: Uri.parse(url),
      imageUrl: imageUrl != null ? Uri.parse(imageUrl!) : null,
      publishedAt: DateTime.parse(publishedAt),
      source: source.toDomain(),
      author: author,
      category: _mapStringToCategory(category),
    );
  }

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
        return NewsCategory.general;
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        content,
        url,
        imageUrl,
        publishedAt,
        source,
        author,
        category,
      ];
}

class NewsSourceDto extends Equatable {
  final String? id;
  final String name;

  const NewsSourceDto({this.id, required this.name});

  factory NewsSourceDto.fromJson(Map<String, dynamic> json) {
    return NewsSourceDto(
      id: json['id'] as String?,
      name: json['name'] as String? ?? 'Неизвестный источник',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  NewsSource toDomain() {
    return NewsSource(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
