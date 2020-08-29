import 'package:baba_spira/consts/color.dart';
import 'package:baba_spira/questionnaire/surveyQuestions.dart';
import 'package:baba_spira/tips/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homeScreen.dart';

class BottomBar extends StatefulWidget {
  final int pageIndex;

  BottomBar(this.pageIndex);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedPage;
  List<Widget> pageList = List<Widget>();
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    pageList.add(Home());
    pageList.add(SearchPage());
    pageList.add(Survey());
    pageList.add(Home());

    super.initState();
    _selectedPage = widget.pageIndex;
  }

  ////////////EXIT App ///////////////
  Future<bool> _onBackPressed() {
    if (_selectedPage != 0) {
      setState(() {
        _selectedPage = 0;
      });

      return Future<bool>.value(false);
    }

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Vil du virkelig avslutte appen?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Nei'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text('Ja'),
            onPressed: () => SystemNavigator.pop(),
          ),
        ],
      ),
    );
  }
  /////////////////End //////////////////////

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
        //////Bottom AppBar/////
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: pink,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 26.2,
              ),
              title: Text(
                'Hjem',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.lightbulb_outline,
                color: Colors.white,
                size: 26.2,
              ),
              title: Text(
                'Tips og råd',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.note,
                color: Colors.white,
                size: 26.2,
              ),
              title: Text(
                'Undersøkelser',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 26.2,
              ),
              title: Text(
                'Poeng',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          currentIndex: _selectedPage,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
