// import 'package:baba_spira/tips/searchPage.dart';
// import 'package:custom_navigator/custom_navigator.dart';
// import 'package:flutter/material.dart';
// import 'package:baba_spira/consts/color.dart';
// import 'homeScreen.dart';

// class CustomNavigatorHomePage extends StatefulWidget {
//   CustomNavigatorHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _CustomNavigatorHomePageState createState() =>
//       _CustomNavigatorHomePageState();
// }

// class _CustomNavigatorHomePageState extends State<CustomNavigatorHomePage> {
//   final List<Widget> _children = [
//     Home(),
//     SearchPage(),
//     Home(),
//     Home(),
//   ];
//   Widget _page = Home();
//   int _currentIndex = 0;

//   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//    ////////////EXIT App ///////////////
//   Future<bool> _onBackPressed() {
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text('Do you really want to exit the app?'),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('No'),
//                   onPressed: () => Navigator.pop(context, false),
//                 ),
//                 FlatButton(
//                     child: Text('Yes'),
//                     onPressed: () => Navigator.pop(
//                           context,
//                           true,
//                         )),
//               ],
//             ));
//   }
//   /////////////////End //////////////////////
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//           child: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: pink,
//           items: _items,
//           selectedItemColor: Colors.blue,
//           onTap: (index) {
//             navigatorKey.currentState.maybePop();
//             setState(() => _page = _children[index]);
//             _currentIndex = index;
//           },
//           currentIndex: _currentIndex,
//         ),
//         body: CustomNavigator(
//           navigatorKey: navigatorKey,
//           home: _page,
//           pageRoute: PageRoutes.materialPageRoute,
//         ),
//       ),
//     );
//   }

//   final _items = [
//     BottomNavigationBarItem(
//       icon: Icon(
//         Icons.home,
//         color: Colors.white,
//       ),
//       title: Text(
//         'Hjem',
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         Icons.lightbulb_outline,
//         color: Colors.white,
//       ),
//       title: Text(
//         'Tips og råd',
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         Icons.note,
//         color: Colors.white,
//       ),
//       title: Text(
//         'Undersøkelser',
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         Icons.card_giftcard,
//         color: Colors.white,
//       ),
//       title: Text(
//         'Poeng',
//         style: TextStyle(color: Colors.white),
//       ),
//     ),
//   ];
// }

// // Drawer //
