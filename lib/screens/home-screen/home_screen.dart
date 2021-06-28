import 'package:demo_navigation/logic/user-interface/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? demoKey}) : super(key: demoKey);

  @override
  Widget build(BuildContext context) {
    var handleTitle = Provider.of<AppBarTitle>(context);
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomCenter,
            child: child,
          );
        },
        child: handleTitle.widgets[handleTitle.widgets.length - 1],
      ),
      drawer: Drawer(),
    );
  }
}