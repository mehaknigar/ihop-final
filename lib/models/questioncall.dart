import 'package:flutter/foundation.dart';

class QuestionCall {
  final int questionId;
  final String data;
  final int questionnaireId;
  final String type;
  final int index;

  QuestionCall(
      {@required this.questionId,
      @required this.data,
      @required this.questionnaireId,
      @required this.type,
      @required this.index});
}
