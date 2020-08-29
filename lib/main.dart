import 'package:baba_spira/authentiction/startupScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'babyData/add_baby.dart';
import 'homePages/bottomBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baba Spira',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFF5B041,
          const <int, Color>{
            50: const Color.fromRGBO(227, 123, 124, 0.1),
            100: const Color.fromRGBO(227, 123, 124, 0.2),
            200: const Color.fromRGBO(227, 123, 124, 0.3),
            300: const Color.fromRGBO(227, 123, 124, 0.4),
            400: const Color.fromRGBO(227, 123, 124, 0.5),
            500: const Color.fromRGBO(227, 123, 124, 0.6),
            600: const Color.fromRGBO(227, 123, 124, 0.7),
            700: const Color.fromRGBO(227, 123, 124, 0.8),
            800: const Color.fromRGBO(227, 123, 124, 0.9),
            900: const Color.fromRGBO(227, 123, 124, 1.0),
          },
        ),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // checking if the user is logged in
  bool loggedIn = false;
  bool infoPresent = false;
  SharedPreferences sharedPreferences;
  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      infoPresent = sharedPreferences.containsKey('signedin');
      if (infoPresent) {
        loggedIn = sharedPreferences.getBool('signedin');
      }
    });
  }

  // notification work
  void _navigateToItemDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBaby(),
      ),
    );
  }

  Future<void> _showItemDialog(Map<String, dynamic> message) async {
    final notification = message['notification'];
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notification['title']),
          content: Text(notification['body']),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loggedIn ? BottomBar(0) : StartUp();
  }
}
