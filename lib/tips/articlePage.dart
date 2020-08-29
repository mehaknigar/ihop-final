import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/models/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'categoryArticlesPage.dart';

class ArticlePage extends StatelessWidget {
  final Article _article;

  ArticlePage(this._article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              //fit: StackFit.expand,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Image.network(
                    _article.image,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                _article.categories != null && _article.categoryIds.isNotEmpty
                    ? Positioned(
                        bottom: 0,
                        child: SingleChildScrollView(
                          physics: bouncingScrollPhysics,
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: _article.categories.map((index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _article.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _article.content,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                bottom: 30,
              ),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      AntDesign.arrowleft,
                      color: pink,
                      size: 28,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: Text(
                        'tilbake',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
