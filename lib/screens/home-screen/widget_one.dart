import 'package:demo_navigation/logic/user-interface/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget_two.dart';


class WidgetOne extends StatelessWidget {
  WidgetOne({Key? keyOne}) : super(key: keyOne);

  @override
  Widget build(BuildContext context) {
    var handleTitle = Provider.of<AppBarTitle>(context);
    return ListView.builder(
      padding: EdgeInsets.all(9),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            handleTitle.changeScreen('Index ${index + 1}');
            handleTitle.moveForward(
                'Index ${index + 1}', WidgetTwo(title: 'Index ${index + 1}'));
          },
          child: ListTile(
            title: Text('Index ${index + 1}'),
            tileColor: Colors.grey.withOpacity(0.6),
          ),
        ),
      ),
      itemCount: 10,
    );
  }
}