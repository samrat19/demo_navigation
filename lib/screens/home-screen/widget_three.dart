import 'package:flutter/material.dart';

class WidgetThree extends StatelessWidget {
  final String title;

  const WidgetThree({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }
}