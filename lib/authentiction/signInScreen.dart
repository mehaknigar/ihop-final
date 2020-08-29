import 'dart:convert';
import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/authentiction/signUpScreen.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/consts/url.dart';
import 'package:baba_spira/homePages/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  bool _isInAsyncCall = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  void getData() async {
    setState(() {
      _isInAsyncCall = true;
    });
    final Client client = Client();
    var response = await client.post(
      signurl,
      body: json.encode(({
        "Username": userNameController.text,
        "Password": passWordController.text,
      })),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("signedin", true);
      await prefs.setInt("userId", jsonData["userId"]);
      await prefs.setString("fullName", jsonData["fullName"]);
      await prefs.setString("email", jsonData["email"]);
      await prefs.setString("username", jsonData["username"]);
      await prefs.setInt("userType", jsonData["userType"]);
      await prefs.setString("securityNumber", jsonData["securityNumber"]);

      print(prefs.getBool("signedin"));

      setState(() {
        _isInAsyncCall = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomBar(0)));
    } else {
      print(jsonData[0].toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            jsonData[0].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: pink),
          ),
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
      setState(() {
        _isInAsyncCall = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.4,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(),
        child: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Image.asset(
                      "images/spire.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    signintext,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: pink,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 8),
                    child: TextFormField(
                      controller: userNameController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return enterUsername;
                        }
                        return null;
                      },
                      cursorColor: pink,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: pink)),
                        contentPadding: const EdgeInsets.all(
                          16.0,
                        ),
                        prefixIcon: Material(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.person,
                            color: pink,
                          ),
                        ),
                        hintText: userName,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
                    child: TextFormField(
                      controller: passWordController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return enterPassword;
                        }
                        return null;
                      },
                      cursorColor: pink,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: pink)),
                        contentPadding: const EdgeInsets.all(
                          16.0,
                        ),
                        prefixIcon: Material(
                          color: Colors.transparent,
                          child: Icon(
                            Icons.lock,
                            color: pink,
                          ),
                        ),
                        hintText: psw,
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
                        if (formKey.currentState.validate()) {
                          getData();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15.0),
                        child: Text(
                          signintext,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "eller",
                      style: TextStyle(color: color2),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    account,
                    style: TextStyle(color: pink, fontSize: 12),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      signuptext,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
