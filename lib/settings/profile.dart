import 'package:baba_spira/Consts/color.dart';
import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/settings/update.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  void initState() {
    super.initState();
    initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        centerTitle: true,
        elevation: 0,
        title: Text(profile),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Center(
                                    child: Text(
                                      "Kontoinformasjon",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Update(
                                            sharedPreferences
                                                .getInt("userId".toString())),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.red,
                              thickness: 2,
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(userName),
                                    subtitle: Text(sharedPreferences
                                        .getString("username".toString())),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.people),
                                    title: Text(fullName),
                                    subtitle: Text(
                                        "${sharedPreferences.getString("fullName".toString())}"),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text(email1),
                                    subtitle: Text(sharedPreferences
                                        .getString("email".toString())),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.location_city),
                                    title: Text(security2),
                                    subtitle: Text(sharedPreferences.getString(
                                        "securityNumber".toString())),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Image.asset(
                        "images/spire.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
