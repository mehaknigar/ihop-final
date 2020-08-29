import 'dart:convert';
import 'package:baba_spira/authentiction/signInScreen.dart';
import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/consts/url.dart';
import 'package:baba_spira/homePages/bottomBar.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool _isInAsyncCall = false;
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController securityNumber = TextEditingController();

  SharedPreferences sharedPreferences;
  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ////Registering User //////
  void addData() async {
    setState(() {
      _isInAsyncCall = true;
    });
    final Client client = Client();
    var response = await client.post(
      regurl,
      body: json.encode(({
        "Email": email.text,
        "FullName": fullname.text,
        "Username": username.text,
        "Password": password.text,
        "securityNumber": securityNumber.text,
        "UserType": 1
      })),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var jsonData = json.decode(response.body);

    if (response.statusCode == 201) {
      ////Storing User Data  Locally  Start //////
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      await prefs.setInt("userId", jsonData["userId"]);
      await prefs.setString("fullName", jsonData["fullName"]);
      await prefs.setString("email", jsonData["email"]);
      await prefs.setString("username", jsonData["username"]);
      await prefs.setInt("userType", jsonData["userType"]);
      await prefs.setString("securityNumber", jsonData["securityNumber"]);

      ////////////End/////////////
      // showDialog( context: context,
      // builder: (context) => AlertDialog(
      //           title: Text("Welcome",
      //             textAlign: TextAlign.center,
      //             style: TextStyle(color: Colors.green),
      //           ),
      //           content: Text("you have successfully registered and logged in..",
      //             softWrap: true,textAlign: TextAlign.center,),
      //           actions: [FlatButton(
      //                 child: Text('OK'),
      //                 onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar()));})],));
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
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
      setState(
        () {
          _isInAsyncCall = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: pink,
      //   elevation: 1,
      // ),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.4,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "images/spire.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    signuptext,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: pink,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: fullname,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return namerequired;
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
                          hintText: fullName,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: username,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return usernamerequired;
                          }
                          return null;
                        },
                        cursorColor: pink,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: pink),
                          ),
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
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: email,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return emailrequired;
                          }
                          return null;
                        },
                        cursorColor: pink,
                        keyboardType: TextInputType.emailAddress,
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
                              Icons.email,
                              color: pink,
                            ),
                          ),
                          hintText: email1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: password,
                        validator: (String value) {
                          if (value.isEmpty || value.length < 8) {
                            return pswrequired;
                          }
                          return null;
                        },
                        cursorColor: pink,
                        obscureText: true,
                        keyboardType: TextInputType.text,
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
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: securityNumber,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return securityNumber1;
                          }
                          return null;
                        },
                        cursorColor: pink,
                        keyboardType: TextInputType.text,
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
                              Icons.confirmation_number,
                              color: pink,
                            ),
                          ),
                          hintText: security2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FlatButton(
                        color: pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          //setState(() {
                          if (formKey.currentState.validate()) {
                            addData();
                          }
                          //});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15.0),
                          child: Text(
                            signuptext,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Text(
                        signintext,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
