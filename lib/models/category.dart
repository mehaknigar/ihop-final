import 'package:flutter/foundation.dart';

class ArticleCategory {
  final int categoryId;
  final String categoryName, image;

  ArticleCategory({
    @required this.categoryId,
    @required this.categoryName,
    @required this.image,
  });
}
