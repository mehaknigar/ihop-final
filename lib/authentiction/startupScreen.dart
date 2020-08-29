import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/authentiction/signInScreen.dart';
import 'package:baba_spira/authentiction/signUpScreen.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:flutter/material.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                  Color(0xFFa8a8a8),
                  Color(0xFFffffff),
                ])),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset("images/spire.png", width: 260),
                  ),
                  Text(signinAndsignup,
                      style: TextStyle(fontSize: 17, color: Colors.grey[600])),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        color: pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 52, vertical: 15.0),
                          child: Text(
                            signintext,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                      ),
                      SizedBox(height: 12),
                      FlatButton(
                        color: signupbutton,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 52, vertical: 15.0),
                          child: Text(
                            signuptext,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                      )
                    ],
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
