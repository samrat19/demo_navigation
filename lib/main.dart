import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'demo_navigation.dart';
import 'logic/user-interface/appbar_title.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppBarTitle(),
      child: MaterialApp(
        home: DemoNavigation(),
      ),
    );
  }
}
