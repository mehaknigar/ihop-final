import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class EnterGrowth extends StatefulWidget {
  final int childID;
  final DateTime db, lastDate;
  EnterGrowth(this.childID, this.db, this.lastDate);
  @override
  _EnterGrowthState createState() => _EnterGrowthState();
}

class _EnterGrowthState extends State<EnterGrowth> {
  bool showIndicator = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController diameterContoller = TextEditingController();

/////Start :Function for entering//////////
  void enterData() async {
    setState(() {
      showIndicator = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('userId');

    final Client client = Client();

    var response = await client.post(
      'https://webapir20191026025421.azurewebsites.net/api/growth',
      headers: ({
        "Content-Type": "application/json",
      }),
      body: json.encode(({
        "userId": userId,
        "weight": weightController.text,
        "height": heightController.text,
        "head": diameterContoller.text,
        "date": "$selectedDate",
        "childId": widget.childID,
      })),
    );

    setState(() {
      showIndicator = false;
    });

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            somethingWentWrong,
            textAlign: TextAlign.center,
            style: TextStyle(color: pink),
          ),
          content: Text(cannotAddGrowthEntries),
          actions: [
            FlatButton(
              child: Text(tryAgain),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  } /////End:Function for entering//////////

  // Start: date selector function ////////
  DateTime selectedDate = null;
  Future<Null> _selectDate(BuildContext context) async {
    DateTime picked;

    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().isAfter(widget.db) &&
              DateTime.now().isBefore(widget.db.add(new Duration(days: 1825)))
          ? DateTime.now()
          : widget.lastDate,
      firstDate: widget.db,
      lastDate: widget.db.add(new Duration(days: 1825)),
    );

    if (picked != null && picked != selectedDate)
      setState(
        () {
          selectedDate = picked;
        },
      );
  } // End: date selector function ////////

  double errorContainerHeight = 0;
  showFieldsError() {
    setState(() {
      errorContainerHeight = 34;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        errorContainerHeight = 0;
      });
    });
  }

  //  ICONS COLOR
  Color weightIconColor = blueGreen;
  Color heightIconColor = blueGreen;
  Color headIconColor = blueGreen;

  //  TOOLTIP KEY
  GlobalKey _weightToolTipKey = GlobalKey();
  GlobalKey _heightToolTipKey = GlobalKey();
  GlobalKey _headToolTipKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showIndicator,
      progressIndicator: CircularProgressIndicator(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(entertheGrowthEntry),
                Divider(
                  height: 50,
                  color: pink,
                ),
                Form(
                  key: formKey,
                  child: Text(
                    selectDate,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Text(
                  selectedDate != null
                      ? "${DateFormat.yMMMMEEEEd().format(selectedDate.toLocal())}"
                      : "Selected date",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 6.0),
                Center(
                  child: RaisedButton(
                    color: pink,
                    textColor: Theme.of(context).bottomAppBarColor,
                    child: Text(select.toUpperCase()),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: weightController,
                        onChanged: (String value) {
                          int val = int.parse(value);
                          if (val >= 1 && val <= 41) {
                            setState(() {
                              weightIconColor = blueGreen;
                            });
                          } else {
                            setState(() {
                              weightIconColor = Color(0xffff0033);
                            });
                          }
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "legg inn vekt";
                          }
                          return null;
                        },
                        cursorColor: pink,
                        decoration: InputDecoration(
                          suffixIcon: Tooltip(
                            message: weightAlert,
                            key: _weightToolTipKey,
                            child: IconButton(
                              onPressed: () {
                                final dynamic tooltip =
                                    _weightToolTipKey.currentState;
                                tooltip.ensureTooltipVisible();
                              },
                              icon: Icon(
                                Icons.info,
                                color: weightIconColor,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: pink),
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: "Vekt ",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'kg',
                        style: TextStyle(
                          color: Colors.black87,
                          // fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: heightController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "inn høyden";
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          int val = int.parse(value);
                          if (val >= 30 && val <= 151) {
                            setState(() {
                              heightIconColor = blueGreen;
                            });
                          } else {
                            setState(() {
                              heightIconColor = Color(0xffff0033);
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: pink,
                        decoration: InputDecoration(
                          suffixIcon: Tooltip(
                            message: heightAlert,
                            key: _heightToolTipKey,
                            child: IconButton(
                              onPressed: () {
                                final dynamic tooltip =
                                    _heightToolTipKey.currentState;
                                tooltip.ensureTooltipVisible();
                              },
                              icon: Icon(
                                Icons.info,
                                color: heightIconColor,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: pink),
                          ),
                          contentPadding: const EdgeInsets.all(
                            10.0,
                          ),
                          hintText: "Høyde",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'cm',
                        style: TextStyle(
                          color: Colors.black87,
                          // fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: diameterContoller,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "legg inn hodeomkrets";
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          int val = int.parse(value);
                          if ((val >= 20 && val <= 70)) {
                            setState(() {
                              headIconColor = blueGreen;
                            });
                          } else {
                            setState(() {
                              headIconColor = Color(0xffff0033);
                            });
                          }
                        },
                        cursorColor: pink,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Tooltip(
                            message: headAlert,
                            key: _headToolTipKey,
                            child: IconButton(
                              onPressed: () {
                                final dynamic tooltip =
                                    _headToolTipKey.currentState;
                                tooltip.ensureTooltipVisible();
                              },
                              icon: Icon(
                                Icons.info,
                                color: headIconColor,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: pink),
                          ),
                          contentPadding: const EdgeInsets.all(
                            10.0,
                          ),
                          hintText: "Hodeomkrets",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'cm',
                        style: TextStyle(
                          color: Colors.black87,
                          // fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: errorContainerHeight,
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Text(
                    formAlert,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffff0033),
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                    color: pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      if (formKey.currentState.validate() &&
                          heightController.text.isNotEmpty &&
                          weightController.text.isNotEmpty &&
                          diameterContoller.text.isNotEmpty) {
                        enterData();
                      } else
                        showFieldsError();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15.0),
                      child: Text(
                        submit,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
