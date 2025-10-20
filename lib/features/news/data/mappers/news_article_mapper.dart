import 'package:news_app/features/news/data/dto/news_article_dto.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

extension NewsArticleMapper on NewsArticleDto {
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
}
