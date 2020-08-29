import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/HomePages/bottomBar.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/models/questioncall.dart';
import 'package:baba_spira/questionnaire/questionScreen.dart';
import 'package:baba_spira/widgets/noDataView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurveyCall extends StatefulWidget {
  final int qid;
  final int userID;
  SurveyCall(this.qid, this.userID);
  @override
  _SurveyCallState createState() => _SurveyCallState();
}

class _SurveyCallState extends State<SurveyCall> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Future<List<QuestionCall>> getQuestions() async {
    var response = await http.get(
        "https://webapir20191026025421.azurewebsites.net/api/Questions/GetByQuestionnaire/${widget.qid.toString()}");
    var jsonData = json.decode(response.body);
    List<QuestionCall> list = [];

    for (var u in jsonData) {
      QuestionCall singleItem = QuestionCall(
        questionId: u["questionId"],
        data: u["data"],
        questionnaireId: u["questionnaireId"],
        type: u["type"],
        index: u["index"],
      );
      list.add(singleItem);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => _onWillPop(),
          ),
          title: Text(quiz),
          backgroundColor: pink,
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: getQuestions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.data.length > 0
                    ? Questionnaire(snapshot.data, widget.userID)
                    : Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            EmptyView(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'No Survey.',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text(quizAlert),
          title: Text(warningAlert),
          actions: <Widget>[
            FlatButton(
              child: Text("Ja"),
              onPressed: () {
                //Navigator.pop(context, true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBar(2),
                  ),
                );
              },
            ),
            FlatButton(
              child: Text("Nei"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }
}
