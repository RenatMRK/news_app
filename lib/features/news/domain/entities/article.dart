import 'package:equatable/equatable.dart';

/// 📰 Domain Entity: новостная статья
class NewsArticle extends Equatable {
  final String id;
  final String title;
  final String? summary;
  final String? content; // ✅ добавлено поле основного текста
  final Uri url;
  final Uri? imageUrl;
  final DateTime publishedAt;
  final NewsSource source;
  final String? author;
  final NewsCategory category;

  const NewsArticle({
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

  NewsArticle copyWith({
    String? id,
    String? title,
    String? summary,
    String? content,
    Uri? url,
    Uri? imageUrl,
    DateTime? publishedAt,
    NewsSource? source,
    String? author,
    NewsCategory? category,
  }) {
    return NewsArticle(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      source: source ?? this.source,
      author: author ?? this.author,
      category: category ?? this.category,
    );
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

/// 🏷 Источник новости
class NewsSource extends Equatable {
  final String? id;
  final String name;

  const NewsSource({this.id, required this.name});

  NewsSource copyWith({String? id, String? name}) =>
      NewsSource(id: id ?? this.id, name: name ?? this.name);

  @override
  List<Object?> get props => [id, name];
}

/// 🔖 Категории новостей
enum NewsCategory {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}


//ad5bf4b1609e4315b6d5f17cfe28138e
