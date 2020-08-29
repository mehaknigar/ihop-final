import 'package:baba_spira/Consts/norwegian.dart';
import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/growthModule/growthEnteries.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BabyProfile extends StatefulWidget {
  ///Storing ids here comming from homePage
  int id;
  String name;
  String dob;
  BabyProfile(this.id, this.name, this.dob);
  @override
  _BabyProfileState createState() => _BabyProfileState();
}

class _BabyProfileState extends State<BabyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(babyGrowth),
        centerTitle: true,
        backgroundColor: pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Calling Clipper which is being shown on the Screen
            OuterCircleHeader(widget.name),
            Container(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GrowthEnteries(
                              widget.id,
                              DateTime.parse(widget.dob),
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[300],
                        radius: 45,
                        child: Icon(
                          Icons.grid_on,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Text("Vekst"),
                    SizedBox(height: 3),
                  ],
                ),
                //     Column(
                //       children: <Widget>[
                //         CircleAvatar(
                //           backgroundColor: Colors.blue[300],
                //           radius: 45,
                //           child: Icon(
                //             Icons.healing,
                //             color: Colors.white,
                //             size: 35,
                //           ),
                //         ),
                //         SizedBox(height: 3),
                //         Text("Helse")
                //       ],
                //     ),
                //     Column(
                //       children: <Widget>[
                //         CircleAvatar(
                //           backgroundColor: Colors.blue[300],
                //           radius: 45,
                //           child: Icon(
                //             Icons.favorite,
                //             color: Colors.white,
                //             size: 35,
                //           ),
                //         ),
                //         SizedBox(height: 3),
                //         Text("Milepælene")
                //       ],
                //     ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(widget.name + '?'),
                    Text("Legg til et nytt minne i milepælene."),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Clipper  WAVY HEADER WITHOUT BABY END //
// ignore: must_be_immutable
class OuterCircleHeader extends StatelessWidget {
  String name;
  OuterCircleHeader(this.name);
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
              name.toUpperCase(),
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("images/babyface.jpg"),
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
