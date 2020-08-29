import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/growth/head.dart';
import 'package:baba_spira/growth/height.dart';
import 'package:baba_spira/growth/weight.dart';
import 'package:baba_spira/growthModule/EnterGrowth.dart';
import 'package:baba_spira/models/growth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GrowthEnteries extends StatefulWidget {
  final int childID;
  final DateTime db;
  GrowthEnteries(this.childID, this.db);
  @override
  _GrowthEnteriesState createState() => _GrowthEnteriesState();
}

class _GrowthEnteriesState extends State<GrowthEnteries> {
  SharedPreferences sharedPreferences;

  void initState() {
    super.initState();
    loadData();
  }

  List<Growth> dataList = [];
  bool dataLoaded = false;

  void loadData() async {
    setState(() {
      dataLoaded = false;
    });

    sharedPreferences = await SharedPreferences.getInstance();

    var response = await http.get(
        "https://webapir20191026025421.azurewebsites.net/api/Growth/getbychild/${widget.childID.toString()}");

    var jsonData = json.decode(response.body);

    dataList.clear();

    for (var u in jsonData["entries"]) {
      if (u["childId"] == widget.childID) {
        Growth singleItem = Growth(
          growthId: u["growthId"],
          userId: u["userId"],
          weight: u["weight"],
          height: u["height"],
          head: u["head"],
          date: DateTime.parse(u["date"]),
          childId: u["childId"],
        );
        dataList.add(singleItem);
      }
    }

    dataList.sort((a, b) => a.date.compareTo(b.date));

    if (mounted) {
      setState(() {
        dataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.red,
          appBarTheme: AppBarTheme(
            color: Colors.red,
            textTheme: TextTheme(
              headline: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: pink,
            title: Text(growthEntry),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Vekt"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Høyde"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Hodeomkrets"),
                ),
              ],
            ),
          ),
          body: dataLoaded || dataList.length != 0
              ? TabBarView(
                  children: [
                    Weight(dataList, widget.db),
                    Height(dataList, widget.db),
                    Head(dataList, widget.db),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: blueGreen,
              heroTag: null,
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  enterGrowthDialog(
                      context,
                      widget.childID,
                      dataList.length != 0
                          ? dataList[dataList.length - 1].date.add(
                                new Duration(days: 1),
                              )
                          : widget.db);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void enterGrowthDialog(
      BuildContext context, int childId, DateTime lastDate) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: lightGrey,
          content: EnterGrowth(childId, widget.db, lastDate),
        );
      },
    );
    loadData();
  }
}
