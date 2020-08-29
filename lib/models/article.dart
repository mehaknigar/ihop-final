import 'package:flutter/foundation.dart';
import 'category.dart';

class Article {
  final int id;
  final String title;
  final String content;
  final List<dynamic> categoryIds;
  final List<ArticleCategory> categories;
  final String image;

  Article({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.categoryIds,
    @required this.categories,
    @required this.image,
  });
}
