import 'dart:convert';
import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/homePages/drawerScreen.dart';
import 'package:baba_spira/models/category.dart';
import 'package:baba_spira/tips/searchResultsPage.dart';
import 'package:baba_spira/widgets/noDataView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../functions/connectivity.dart';
import 'categoryArticlesPage.dart';
import 'package:connectivity/connectivity.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;

  TextEditingController searchTextController = TextEditingController();
  BouncingScrollPhysics bouncingScrollPhysics = new BouncingScrollPhysics();

  Future<List<ArticleCategory>> getData() async {
    List<ArticleCategory> list = [];

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(
          "https://webapir20191026025421.azurewebsites.net/api/categories");

      var jsonData = json.decode(response.body);

      for (var u in jsonData) {
        ArticleCategory singleItem = ArticleCategory(
          categoryId: u["categoryId"],
          categoryName: u["categoryName"],
          image: u["image"],
        );

        list.add(singleItem);
      }
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 32,
                  color: pink,
                ),
                onPressed: () => _drawerKey.currentState.openDrawer()),
          ],
        ),
      ),
      drawer: MyDrawer(),
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
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResultPage(
                            value.toString(),
                          ),
                        ),
                      );
                    }
                  },
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
            flex: 2,
            child: Center(
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data == null
                      ? Container(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.data.length > 0
                          ? GridView.count(
                              physics: bouncingScrollPhysics,
                              padding: EdgeInsets.all(32.0),
                              crossAxisCount: 3,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                              children: List.generate(
                                snapshot.data.length,
                                (index) => CategoryItem(snapshot.data[index]),
                              ),
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

class CategoryItem extends StatelessWidget {
  final ArticleCategory _category;

  CategoryItem(this._category);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryArticlesPage(_category),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: CachedNetworkImage(
              imageUrl: _category.image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Text(
              _category.categoryName,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(27, 125, 153, 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
