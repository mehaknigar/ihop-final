import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/models/question.dart';
import 'package:baba_spira/questionnaire/surveyInstruction.dart';
import 'package:baba_spira/widgets/noDataView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int userID;

  SharedPreferences sharedPreferences;

  Future<List<Question>> getQuestions() async {
    sharedPreferences = await SharedPreferences.getInstance();

    userID = sharedPreferences.getInt("userId");

    var response = await http.get(
        "https://webapir20191026025421.azurewebsites.net/api/Questionnaire/getbyuser/${sharedPreferences.getInt("userId").toString()}");
    var jsonData = json.decode(response.body);
    List<Question> list = [];

    for (var u in jsonData) {
      Question singleItem = Question(
        questionnaireId: u["questionnaireId"],
        title: u["title"],
        description: u["description"],
        dueDate: u["dueDate"],
        points: u["points"],
        instructions: u["instructions"],
      );
      list.add(singleItem);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return SurveyLayout(snapshot.data[index], userID);
                      },
                    )
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
    );
  }
}

class SurveyLayout extends StatelessWidget {
  final int userID;
  final Question data;
  SurveyLayout(this.data, this.userID);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurveyInstruction(data, userID),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.blue,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          data.title,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          data.description,
                          softWrap: true,
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RoundedProgressBar(
                          childCenter: Text(
                            data.points.toString() + "%",
                            style: TextStyle(color: Colors.white),
                          ),
                          height: 18,
                          style: RoundedProgressBarStyle(
                            borderWidth: 0,
                            widthShadow: 0,
                            colorBackgroundIcon: pink,
                            colorProgress: pink,
                            colorProgressDark: Colors.white,
                            colorBorder: Colors.white,
                            backgroundProgress: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 16),
                          borderRadius: BorderRadius.circular(20),
                          percent: data.points.roundToDouble(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.question_answer,
                                color: pink,
                                size: 35,
                              ),
                              Text(
                                data.dueDate.toString(),
                                style: TextStyle(fontSize: 32),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Center(
                              child: Text(
                            "utgår",
                            style: TextStyle(fontSize: 20),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
