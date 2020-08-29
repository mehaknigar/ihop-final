import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/babyData/babyProfile.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:baba_spira/babyData/add_baby.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/models/babiesRecord.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawerScreen.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
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

  Future<List<BabiesRecord>> showData() async {
    var response = await http.get(
        "https://webapir20191026025421.azurewebsites.net/api/Children/getanchildrenbyuser/${sharedPreferences.getInt("userId".toString())}");
    var jsonData = json.decode(response.body);
    List<BabiesRecord> data = [];
    for (var u in jsonData) {
      BabiesRecord singleItem = BabiesRecord(
        childId: u["childId"],
        childName: u["childName"],
        birthDate: u["birthDate"],
        fatherName: u["fatherName"],
        motherName: u["motherName"],
      );
      data.add(singleItem);
    }
    return data;
  }

//////Start:Chart Data//////////////////
  List<CircularStackEntry> data = <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(
          50.33,
          Colors.white,
          rankKey: 'completed',
        ),
        CircularSegmentEntry(
          60.67,
          Colors.blue[900],
          rankKey: 'remaining',
        ),
      ],
      rankKey: 'progress',
    ),
  ];
  ////////End:Chart Data//////////////////

  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pink,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () => _drawerKey.currentState.openDrawer()),
            // IconButton(
            //   icon: Icon(
            //     Icons.grid_on,
            //     size: 32,
            //     color: Colors.white,
            //   ),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => SelectBaby(),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            WavyHeader(),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: showData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.data == null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : snapshot.data.length > 0
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BabyProfile(
                                                  snapshot.data[index].childId,
                                                  snapshot
                                                      .data[index].childName,
                                                  snapshot
                                                      .data[index].birthDate),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    "images/babyface.jpg"),
                                              ),
                                              Divider(
                                                height: 20,
                                              ),
                                              Text("Child Name:" +
                                                  snapshot
                                                      .data[index].childName),
                                              Text(snapshot
                                                  .data[index].birthDate),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(60.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Ingen barn ennå..!',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                OutlineButton(
                                  child: Text(
                                    addChild,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddBaby(),
                                      ),
                                    );
                                  },
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ],
                            ),
                          );
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.grey,
      //   heroTag: null,
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => AddBaby(),
      //         ));
      //   },
      //   label: Text('Add Child'),
      //   icon: Icon(Icons.add),
      // ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WavyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        GlobalKey<AnimatedCircularChartState>();
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      child: Container(
        color: pink,
        child: AnimatedCircularChart(
          key: _chartKey,
          size: const Size(300.0, 300.0),
          initialChartData: <CircularStackEntry>[
            CircularStackEntry(
              <CircularSegmentEntry>[
                CircularSegmentEntry(
                  50.33,
                  Colors.white,
                  rankKey: 'completed',
                ),
                CircularSegmentEntry(
                  60.67,
                  Colors.blue,
                  rankKey: 'remaining',
                ),
              ],
              rankKey: 'progress',
            ),
          ],
          chartType: CircularChartType.Radial,
          holeLabel: babyGrowth,
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        height: size.height / 2,
        width: double.infinity,
      ),
      clipper: BottomWaveClipper(),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 1.75);

    path.quadraticBezierTo(
        size.width / 14, size.height / 1.7, size.width / 9, size.height / 1.45);

    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);

    path.quadraticBezierTo(
        size.width / 1.33, size.height, size.width / 1.125, size.height / 1.45);

    path.quadraticBezierTo(
        size.width / 1.0769, size.height / 1.7, size.width, size.height / 1.75);

    path.lineTo(size.width, size.height / 1.75);
    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
//  WAVY HEADER WITHOUT BABY END //

class OuterCircleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      child: Container(
        color: pink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'some text',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        height: size.height / 3,
        width: double.infinity,
      ),
      clipper: OuterCircleClipper(),
    );
  }
}

class OuterCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 1.6287);

    // 1st point
    path.quadraticBezierTo(size.width / 7.9411, size.height / 1.3422,
        size.width / 3.6486, size.height / 1.3422);

    // 2nd point
    path.quadraticBezierTo(size.width / 3.3027, size.height / 1.3270,
        size.width / 3.1671, size.height / 1.2603);

    // 3rd point
    path.quadraticBezierTo(size.width / 2.8421, size.height / 1.0461,
        size.width / 2, size.height - 6);

    // 4th point
    path.quadraticBezierTo(size.width / 1.5428, size.height / 1.0461,
        size.width / 1.4614, size.height / 1.2603);

    // 5th point
    path.quadraticBezierTo(size.width / 1.4342, size.height / 1.3270,
        size.width / 1.377, size.height / 1.3422);

    // 6th point
    path.quadraticBezierTo(size.width / 1.1440, size.height / 1.3422,
        size.width, size.height / 1.6287);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
