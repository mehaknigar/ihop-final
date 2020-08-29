import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/models/babiesRecord.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/noDataView.dart';
import 'babyRecordDetail.dart';

class BabyRecord extends StatefulWidget {
  @override
  _BabyRecordState createState() => _BabyRecordState();
}

class _BabyRecordState extends State<BabyRecord> {
  bool loggedIn = false;
  bool infoPresent = false;
  SharedPreferences sharedPreferences;
  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      infoPresent = sharedPreferences.containsKey('signedin');
      if (infoPresent) {
        loggedIn = sharedPreferences.getBool('signedin');
        print(sharedPreferences.getInt("userId"));
      }
    });
  }

  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<List<BabiesRecord>> getData() async {
    var response = await http.get(
        "https://webapir20191026025421.azurewebsites.net/api/Children/getanchildrenbyuser/${sharedPreferences.getInt("userId".toString())}");
    var jsonData = json.decode(response.body);
    List<BabiesRecord> list = [];

    for (var u in jsonData) {
      BabiesRecord singleItem = BabiesRecord(
        childId: u["childId"],
        childName: u["childName"],
        birthDate: u["birthDate"],
        fatherName: u["fatherName"],
        motherName: u["motherName"],
      );
      list.add(singleItem);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(childRecord),
        backgroundColor: pink,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : snapshot.data.length > 0
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return CardData(snapshot.data[index]);
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          EmptyView(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'No child record.',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}

class CardData extends StatelessWidget {
  final BabiesRecord data;
  CardData(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("images/babyface.jpg"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Navn:" + data.childName,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              birthDate + data.birthDate,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BabyRecordDetail(
                                        data.childId,
                                        data.childName,
                                        data.fatherName,
                                        data.motherName,
                                        data.birthDate),
                                  ),
                                );
                              },
                              child: Icon(Icons.arrow_forward_ios))),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
