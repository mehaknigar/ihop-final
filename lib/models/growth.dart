import 'package:flutter/cupertino.dart';

class Growth {
  final int growthId;
  final int userId;
  final double weight;
  final double height;
  final double head;
  final DateTime date;
  final int childId;

  Growth(
      {@required this.childId,
      @required this.userId,
      @required this.weight,
      @required this.height,
      @required this.date,
      @required this.head,
      @required this.growthId});
}
