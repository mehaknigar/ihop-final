import 'package:flutter/material.dart';

class BabiesRecord{
  final int childId;
  final String childName;
  final String birthDate;
  final String fatherName;
  final String motherName;

   BabiesRecord({
     @required this.childId,
     @required this.childName,
     @required this.birthDate,
     @required this.fatherName,
     @required this.motherName
   });

}