import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/babyData/updateBabyData.dart';
import 'package:baba_spira/homePages/bottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BabyRecordDetail extends StatefulWidget {
  final int childId;
  final String childName, childfather, childmother, birthdate;
  BabyRecordDetail(this.childId, this.childName, this.childfather,
      this.childmother, this.birthdate);

  @override
  _BabyRecordDetailState createState() => _BabyRecordDetailState();
}

class _BabyRecordDetailState extends State<BabyRecordDetail> {
  bool showIndicator = false;
///////funtion for deleting childs record ////////
  void deleteChild() async {
    setState(() {
      showIndicator = true;
    });
    final Client client = Client();
    var response = await client.delete(
      'https://webapir20191026025421.azurewebsites.net/api/Children/${widget.childId}',
      headers: ({
        "Content-Type": "application/json",
      }),
    );

    setState(() {
      showIndicator = false;
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            babydeleted,
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            somethingWentWrong,
            textAlign: TextAlign.center,
            style: TextStyle(color: pink),
          ),
          content: Text(cannotdeleteBaby),
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
  ////////////End of Function//////////

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.childName),
        backgroundColor: pink,
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showIndicator,
        progressIndicator: CircularProgressIndicator(),
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("images/babyface.jpg"),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          birthDate,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          'Fars navn:',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Mors navn :',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.childName,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        widget.birthdate,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        widget.childfather,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        widget.childmother,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        child: Text(
                          update,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (contect) =>
                                    UpdateBaby(widget.childId),
                              ));
                        },
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        child: Text(
                          delete1,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          deleteChild();
                        },
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
