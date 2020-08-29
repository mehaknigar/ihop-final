import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/authentiction/startupScreen.dart';
import 'package:baba_spira/babyData/add_baby.dart';
import 'package:baba_spira/babyData/babyRecord.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/settings/profile.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  SharedPreferences sharedPreferences;
  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///////Logout function.Removing data stored in Shared Preference/////
  void logOut() async {
    await sharedPreferences.setBool('signedin', false);
    await sharedPreferences.remove('userId');
    await sharedPreferences.remove('fullName');
    await sharedPreferences.remove('email');
    await sharedPreferences.remove('username');
    await sharedPreferences.remove('userType');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StartUp()),
    );
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Stack(fit: StackFit.expand, children: <Widget>[
          ListView(children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
              child: Image.asset("images/spire.png"),
            ),
            SizedBox(height: 10),
            Divider(
              height: 4,
              color: pink,
            ),
            ListTile(
                leading: Icon(Icons.child_care, color: pink),
                title: Text(
                  addChild,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBaby(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.child_care, color: pink),
                title: Text(
                  childRecord,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BabyRecord(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.portable_wifi_off, color: pink),
                title: Text(
                  profile,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.exit_to_app, color: pink),
                title: Text(
                  logOut1,
                ),
                onTap: () {
                  logOut();
                }),
            ListTile(
                leading: Icon(Icons.share, color: pink),
                title: Text(
                  share,
                ),
                onTap: () {
                  Share.share("https://www.google.com/");
                  // Navigator.push(
                  //   context,
                  // MaterialPageRoute(
                  //   builder: (context) => ,
                  // ),
                  // );
                }),
          ]),
        ]),
      ),
    );
  }
}
