import 'package:demo_navigation/screens/home-screen/widget_one.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends ChangeNotifier {
  String currentScreen = 'home-screen';
  int currentIndex = 2;

  changeIndex(int val) {
    currentIndex = val;
    notifyListeners();
  }

  List<String> appBarTitle = ['home-screen'];
  List<Widget> widgets = [WidgetOne()];

  changeScreen(
      String screenName,
      ) {
    currentScreen = screenName;
    notifyListeners();
  }

  moveForward(String title, Widget widget) {
    appBarTitle.add(title);
    if (!widgets.contains(widget)) {
      widgets.add(widget);
    }
  }

  moveBackWard() {
    int totalLength = appBarTitle.length;
    int totalWidgets = widgets.length;
    appBarTitle.removeAt(totalLength - 1);
    widgets.removeAt(totalWidgets - 1);
    changeScreen(appBarTitle[appBarTitle.length - 1]);
  }
}