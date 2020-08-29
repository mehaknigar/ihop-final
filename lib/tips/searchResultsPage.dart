import 'dart:convert';
import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/models/article.dart';
import 'package:baba_spira/widgets/articleTile.dart';
import 'package:baba_spira/widgets/noDataView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;


class SearchResultPage extends StatefulWidget {
  final String keyword;

  SearchResultPage(this.keyword);
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  TextEditingController searchTextController = TextEditingController();
  BouncingScrollPhysics bouncingScrollPhysics = new BouncingScrollPhysics();

  Future<List<Article>> getData() async {
    var response = await http.get(
        "https://webapir20191026025421.azurewebsites.net/api/articles/searchForArticles/${widget.keyword}");
    var jsonData = json.decode(response.body);

    List<Article> list = [];

    for (var u in jsonData) {
      Article singleItem = Article(
        id: u["articleId"],
        title: u["title"],
        content: u["content"],
        categoryIds: u["categoryIds"],
        categories: null,
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
          Expanded(
            flex: 1,
            child: Center(
              child: Card(
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                elevation: 11,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: TextField(
                  controller: searchTextController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultPage(value),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                  ),
                  cursorColor: pink,
                  autocorrect: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                    hintStyle: TextStyle(color: Colors.black26),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
