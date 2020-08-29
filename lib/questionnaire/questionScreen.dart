import 'dart:convert';
import 'package:baba_spira/HomePages/bottomBar.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/models/questioncall.dart';
import 'package:baba_spira/models/quizAnswer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Questionnaire extends StatefulWidget {
  final List<QuestionCall> questions;
  final int userID;
  Questionnaire(this.questions, this.userID);

  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<QuizAnswer> quizAnswers;

  int index;
  List<String> optionsData = [];
  bool showLoader;
  Function previousFunction = null;
  String nextBtnText = "Neste";

  //  FUNCTION TO SET QUESTION TEXT AND CREATE OPTIONS LIST
  String getQuestionData() {
    List data = widget.questions[index].data.split(";");

    if (optionsData != null) optionsData.clear();
    for (var i = 2; i < int.parse(data[1]) + 2; i++) optionsData.add(data[i]);

    return data[0];
  }

  //  FUNCTIONS TO CREATE LIST OF OPTIONS
  List<Widget> optionsListCreater() {
    List<Widget> optionsWidget = [];

    for (int i = 0; i < optionsData.length; i++) {
      optionsWidget.add(
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          onTap: () => setAnswer(optionsData[i]),
          title: Text(optionsData[i]),
          leading: Radio(
            activeColor: pink,
            autofocus: false,
            value: '${optionsData[i]}',
            groupValue: selectedOption,
            onChanged: (value) => setAnswer(value),
          ),
        ),
      );
    }

    return optionsWidget;
  }

  String selectedOption;

  //  setting "selectedOption" from answers array if it exists
  void setAnswerData() {
    selectedOption =
        quizAnswers[index] != null ? quizAnswers[index].answerData : '';
  }

  //  setting the options answer
  void setAnswer(String value) {
    setState(() {
      selectedOption = value;
    });
  }

  //  SETTING PREVIOUS BUTTON FUNCION OR NULL
  //  SETTING NEXT BUTTON TEXT TO "NEXT" OR "SUBMIT"
  void setFunctions() {
    previousFunction = index != 0 ? previousPressed : null;
    nextBtnText = index == widget.questions.length - 1 ? "sende inn" : "Neste";
  }

  void previousPressed() {
    if (index > 0) {
      setState(() {
        index--;
        setFunctions();
      });

      setAnswerData();
    }
  }

  void nextPressed() async {
    if (selectedOption != null && selectedOption != '') {
      quizAnswers[index] = QuizAnswer(
        answerData: selectedOption,
        questionId: widget.questions[index].questionId,
      );

      if (index < widget.questions.length - 1) {
        setState(() {
          index++;
        });

        setFunctions();
        setAnswerData();
      } else {
        await submitAnswer();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBar(2),
          ),
        );
      }
    }
  }

  Future<void> submitAnswer() async {
    setState(() {
      showLoader = true;
    });

    print(quizAnswers.length);

    for (var i = 0; i < quizAnswers.length - 1; i++) {
      var response = await http.post(
        "https://webapir20191026025421.azurewebsites.net/api/answers",
        body: json.encode({
          "questionId": "${quizAnswers[i].questionId.toString()}",
          "userId": "${widget.userID.toString()}",
          "data": "${quizAnswers[i].answerData.toString()}"
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(quizAnswers[i].questionId);
      print(response.body);
    }

    setState(() {
      showLoader = false;
    });
  }

  double getLoaderWidth() => (100 / widget.questions.length) * index;

  @override
  void initState() {
    super.initState();

    index = 0;
    showLoader = false;

    quizAnswers = new List(widget.questions.length);
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showLoader,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          child: Column(
            children: <Widget>[
              Container(
                color: pink,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RoundedProgressBar(
                    childCenter: Text(
                      "${getLoaderWidth().toString()}%",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    height: 20,
                    style:
                        RoundedProgressBarStyle(borderWidth: 0, widthShadow: 0),
                    margin: EdgeInsets.symmetric(vertical: 16),
                    borderRadius: BorderRadius.circular(20),
                    percent: getLoaderWidth(),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text(
                        getQuestionData(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: optionsListCreater(),
                    ),
                  ),
                  /* FormBuilderRadio(
                    attribute: "answer",
                    leadingInput: true,
                    initialValue: '',
                    options: options
                        .map((answer) => FormBuilderFieldOption(value: answer))
                        .toList(growable: false),
                    validators: [FormBuilderValidators.required()],
                  ), */
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: previousFunction,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () => nextPressed(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            nextBtnText == null ? '' : nextBtnText,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            AntDesign.arrowright,
                            color: pink,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
