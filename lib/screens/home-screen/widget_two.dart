import 'package:demo_navigation/logic/user-interface/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget_three.dart';

class WidgetTwo extends StatelessWidget {
  final String title;

  const WidgetTwo({Key? keyTwo, required this.title}) : super(key: keyTwo);

  @override
  Widget build(BuildContext context) {
    var handleTitle = Provider.of<AppBarTitle>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView.separated(
        separatorBuilder: (_, index) => SizedBox(
          height: 10,
        ),
        padding: EdgeInsets.all(9),
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              handleTitle.changeScreen(
                'Sub Index ${index + 1}',
              );
              handleTitle.moveForward('Sub Index ${index + 1}',
                  WidgetThree(title: 'Sub Index ${index + 1}'));
            },
            child: Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    child: Text('S ${index + 1}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Sub Index ${index + 1}'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
        ),
        itemCount: 10,
      ),
    );
  }
}