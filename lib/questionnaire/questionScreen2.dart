// import 'package:baba_spira/consts/color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
// import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

// class Questionnaire2 extends StatefulWidget {
//   @override
//   _Questionnaire2State createState() => _Questionnaire2State();
// }

// class _Questionnaire2State extends State<Questionnaire2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Qestionnaire"),
//           backgroundColor: pink,
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Column(
//           children: <Widget>[
//           Container(
//             color: pink,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//               child: RoundedProgressBar(
//                 height: 20,
//                 style: RoundedProgressBarStyle(borderWidth: 0, widthShadow: 0),
//                 margin: EdgeInsets.symmetric(vertical: 16),
//                 borderRadius: BorderRadius.circular(20),
//                 percent: 30,
//               ),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       color: Colors.grey.shade200,
//                       padding: EdgeInsets.all(8.0),
//                       width: double.infinity,
//                       child: Text("Question ".toUpperCase())),
//                 ),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextFormField(
//                       validator: (String value) {
//                         if (value.isEmpty) {
//                           return "inn høyden";
//                         }
//                         return null;
//                       },
//                       onChanged: (String value) {},
//                       keyboardType: TextInputType.number,
//                       cursorColor: pink,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: pink),
//                         ),
//                         contentPadding: const EdgeInsets.all(
//                           10.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Text(
//                         'cm',
//                         style: TextStyle(
//                           color: Colors.black87,
//                           // fontSize: 20.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ]));
//   }
// }
