import 'dart:convert';
import 'package:baba_spira/Consts/norwegian.dart';
import 'package:http/http.dart';
import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/HomePages/bottomBar.dart';
import 'package:baba_spira/tips/categoryArticlesPage.dart';
import 'package:baba_spira/widgets/inputTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBaby extends StatefulWidget {
  @override
  _AddBabyState createState() => _AddBabyState();
}

class _AddBabyState extends State<AddBaby> {
  bool showIndicator = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController childNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();

  // baby borned
  bool borned;

  void babyBorned(bool value) {
    setState(() {
      borned = value;
    });
  }

  // Gender
  int _babyGender;

  void selectGender(int value) {
    setState(() {
      _babyGender = value;
    });
  }

  // date selector
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime picked;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: CupertinoDatePicker(
              initialDateTime: selectedDate,
              onDateTimeChanged: (DateTime newdate) {
                picked = newdate;
              },
              maximumDate: DateTime.now(),
              minimumYear: 1900,
              maximumYear: DateTime.now().year.toInt(),
              minuteInterval: 1,
              mode: CupertinoDatePickerMode.date,
            ),
          );
        },
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
    }
    if (picked != null && picked != selectedDate)
      setState(
        () {
          selectedDate = picked;
        },
      );
  }

  void addBaby() async {
    setState(() {
      showIndicator = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('userId');

    final Client client = Client();

    var response = await client.post(
      'https://webapir20191026025421.azurewebsites.net/api/Children',
      headers: ({
        "Content-Type": "application/json",
      }),
      body: json.encode(({
        "userId": userId,
        "borned": borned,
        "gender": _babyGender,
        "childName": childNameController.text,
        "birthDate": "$selectedDate",
        "fatherName": fatherNameController.text,
        "motherName": motherNameController.text
      })),
    );

    setState(() {
      showIndicator = false;
    });

    print(response.body.toString());
    print(response.statusCode);

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            newBabyAdded,
            textAlign: TextAlign.center,
            style: TextStyle(color: pink),
          ),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (contect) => BottomBar(0),
                ),
              ),
            ),
          ],
        ),
      );

      Future.delayed(
        Duration(
          seconds: 1,
        ),
        () => Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (contect) => BottomBar(0),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            somethingWentWrong,
            textAlign: TextAlign.center,
            style: TextStyle(color: pink),
          ),
          content: Text(canNotAddBaby),
          actions: [
            FlatButton(
              child: Text(tryAgain),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showIndicator,
        progressIndicator: CircularProgressIndicator(),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: bouncingScrollPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: RaisedButton(
                    padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                    color: pink,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Feather.arrow_left,
                          size: 18.0,
                          color: Theme.of(context).bottomAppBarColor,
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Image.asset('images/spire.png'),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      left: 20.0,
                      top: 15.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: pink.withAlpha(100),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        width: 70.0,
                        height: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Text(
                        addBaby1,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Form(
                  key: formKey,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              isyourbabyborn,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20.0,
                              ),
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text('Ja'),
                              leading: Radio(
                                activeColor: pink,
                                autofocus: false,
                                value: true,
                                groupValue: borned,
                                onChanged: (value) => babyBorned(value),
                              ),
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text('Nei'),
                              leading: Radio(
                                activeColor: pink,
                                autofocus: false,
                                value: false,
                                groupValue: borned,
                                onChanged: (value) => babyBorned(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                      borned == null || borned
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Baby kjønn",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(babyBoy),
                                    leading: Radio(
                                      activeColor: pink,
                                      autofocus: false,
                                      value: 0,
                                      groupValue: _babyGender,
                                      onChanged: (value) => selectGender(value),
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(babyGirl),
                                    leading: Radio(
                                      activeColor: pink,
                                      autofocus: false,
                                      value: 1,
                                      groupValue: _babyGender,
                                      onChanged: (value) => selectGender(value),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      InputTile(
                        childName,
                        enterName,
                        childNameController,
                      ),
                      InputTile(
                        motherName,
                        enterName,
                        motherNameController,
                      ),
                      InputTile(
                        fatherName,
                        enterName,
                        fatherNameController,
                      ),
                      borned == null || borned
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 20.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    "Fødselsdato",
                                    // 'Date Of Birth:',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "${DateFormat.yMMMMEEEEd().format(selectedDate.toLocal())}",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 6.0),
                                  Center(
                                    child: RaisedButton(
                                      color: blueGreen,
                                      textColor:
                                          Theme.of(context).bottomAppBarColor,
                                      child: Text('å velge'.toUpperCase()),
                                      onPressed: () => _selectDate(context),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                        color: pink,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          print(selectedDate);
                          if (formKey.currentState.validate()) {
                            addBaby();
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              addBaby1.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).bottomAppBarColor,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(width: 40.0),
                            Icon(
                              Feather.arrow_right,
                              size: 18.0,
                              color: Theme.of(context).bottomAppBarColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
