import 'package:flutter/cupertino.dart';

class Question {
  final int questionnaireId;
  final String title;
  final String description;
  final int dueDate;
  final int points;
  final String instructions;

  Question(
      {@required this.questionnaireId,
      @required this.title,
      @required this.description,
      @required this.dueDate,
      @required this.points,
      @required this.instructions});
}
