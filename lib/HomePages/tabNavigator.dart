import 'package:baba_spira/tips/searchPage.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';



class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "Hjem")
      child = Home();
    else if(tabItem == "Tips og råd")
      child =SearchPage();
    else if(tabItem == "Undersøkelser")
      child = Home();
       else if(tabItem == "Poeng")
      child = Home();
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child
        );
      },
    );
  }
}
