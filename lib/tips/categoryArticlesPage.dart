import 'dart:convert';
import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/models/article.dart';
import 'package:baba_spira/widgets/articleTile.dart';
import 'package:baba_spira/widgets/noDataView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';

BouncingScrollPhysics bouncingScrollPhysics = new BouncingScrollPhysics();

class CategoryArticlesPage extends StatefulWidget {
  final ArticleCategory _category;

  CategoryArticlesPage(this._category);
  @override
  _CategoryArticlesPageState createState() => _CategoryArticlesPageState();
}

class _CategoryArticlesPageState extends State<CategoryArticlesPage> {
  TextEditingController searchTextController = TextEditingController();

  Future<List<Article>> getData() async {
    var response = await http.get(
        "https://webapir20191026025421.azurewebsites.net/api/articles/getarticles/${widget._category.categoryId}");
    var jsonData = json.decode(response.body);

    List<Article> list = [];

    var categoriesResponse = await http
        .get("https://webapir20191026025421.azurewebsites.net/api/categories");

    var data = json.decode(categoriesResponse.body);
    for (var u in jsonData) {
      List<ArticleCategory> articleCategory = [];

      for (var i = 0; i < u["categoryIds"].length; i++) {
        if (u["categoryIds"][i] == data[i]["categoryId"]) {
          ArticleCategory item = ArticleCategory(
            categoryId: data[i]["categoryId"],
            categoryName: data[i]["categoryName"],
            image: data[i]["image"],
          );

          articleCategory.add(item);
        }
      }

      Article singleItem = Article(
        id: u["articleId"],
        title: u["title"],
        content: u["content"],
        categoryIds: u["categoryIds"],
        categories: articleCategory,
        image: u["image"],
      );
      list.add(singleItem);
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            AntDesign.arrowleft,
            color: blueGreen,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget._category.categoryName,
              style: TextStyle(
                fontSize: 30,
                color: blueGreen,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data == null
                      ? Container(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.data.length > 0
                          ? ListView.builder(
                              physics: bouncingScrollPhysics,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ArticleTile(snapshot.data[index]);
                              },
                            )
                          : EmptyView();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
