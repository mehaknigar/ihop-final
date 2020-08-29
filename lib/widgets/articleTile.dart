import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/models/article.dart';
import 'package:baba_spira/tips/articlePage.dart';
import 'package:baba_spira/tips/categoryArticlesPage.dart';
import 'package:flutter/material.dart';

class ArticleTile extends StatelessWidget {
  final Article _article;

  ArticleTile(this._article);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.20;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlePage(_article),
            ),
          );
        },
        child: SizedBox(
          width: double.infinity,
         height: cardHeight,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  height: cardHeight,
                  width: cardHeight,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(
                      _article.image,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _article.title,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                                                      child: Text(
                              _article.content.length > 70
                                  ? "..." +
                                      _article.content.substring(0, 70) +
                                      "..."
                                  : _article.content,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _article.categories != null &&
                            _article.categoryIds.isNotEmpty
                        ? SingleChildScrollView(
                            physics: bouncingScrollPhysics,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _article.categories.map((index) {
                                return InkWell(
                                  onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryArticlesPage(index),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Chip(
                                      label: Text(
                                        index.categoryName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      backgroundColor: blueGreen,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
