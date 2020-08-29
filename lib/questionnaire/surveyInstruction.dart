import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/models/question.dart';
import 'package:baba_spira/questionnaire/surveyCall.dart';
import 'package:flutter/material.dart';

class SurveyInstruction extends StatefulWidget {
  final Question data1;
  final int userID;
  SurveyInstruction(this.data1, this.userID);
  @override
  _SurveyInstructionState createState() => _SurveyInstructionState();
}

class _SurveyInstructionState extends State<SurveyInstruction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  widget.data1.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.data1.instructions,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FlatButton(
                color: pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurveyCall(
                            widget.data1.questionnaireId, widget.userID),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15.0),
                  child: Text(
                    "Start undersøkelse",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
