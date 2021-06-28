import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tools/curved_navigation_bar.dart';
import 'logic/user-interface/appbar_title.dart';
import 'screens/comment-screen/comment_screen.dart';
import 'screens/home-screen/home_screen.dart';

class DemoNavigation extends StatefulWidget {
  const DemoNavigation({Key? key}) : super(key: key);

  @override
  _DemoNavigationState createState() => _DemoNavigationState();
}

class _DemoNavigationState extends State<DemoNavigation> {
  List<Widget> _screens = [
    CommentScreen(),
    CommentScreen(),
    HomeScreen(),
    CommentScreen(),
    CommentScreen()
  ];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var handleTitle = Provider.of<AppBarTitle>(context);
    return WillPopScope(
        onWillPop: () async {
          print('current index: ${handleTitle.currentIndex}');
          if (handleTitle.currentIndex != 2) {
            handleTitle.changeIndex(2);
            return Future.value(false);
          } else if (handleTitle.currentIndex == 2) {
            handleTitle.changeIndex(2);
            if (handleTitle.widgets.length > 1) {
              handleTitle.moveBackWard();
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          } else {
            return Future.value(false);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: handleTitle.currentIndex == 0
              ? AppBar(
            title: Text('Favourites'),
          )
              : handleTitle.currentIndex == 1
              ? AppBar(
            title: Text('Help'),
          )
              : handleTitle.currentIndex == 3
              ? AppBar(title: Text('Message'))
              : handleTitle.currentIndex == 4
              ? AppBar(title: Text('Profile'))
              : AppBar(
            leading: handleTitle.currentScreen ==
                'home-screen'
                ? GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(Icons.menu),
            )
                : GestureDetector(
              onTap: () {
                handleTitle.moveBackWard();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            title: handleTitle.currentScreen == 'home-screen'
                ? Text('Home')
                : Text(handleTitle.currentScreen),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(child: _screens[handleTitle.currentIndex]),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: bottomNavigationBar(context,handleTitle.currentIndex),
                    ),
                )
              ],
            ),
          ),
          drawer: Drawer(),
          //bottomNavigationBar: bottomNavBar(context)
        ));
  }

  Widget bottomNavigationBar(BuildContext context, int index) {
    var handleTitle = Provider.of<AppBarTitle>(context);

    return ClipPath(
      clipper: ShapeBorderClipper(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
      child: CurvedNavigationBar(
        height: 70,
        color: Colors.grey.shade200,
        buttonBackgroundColor: Colors.lightGreen,
        backgroundColor: Colors.white,
        index: index,
        onTap: (value) {
          handleTitle.changeIndex(value);
        },
        items: [
          Icon(Icons.favorite_border_rounded,
              color:
              handleTitle.currentIndex == 0 ? Colors.white : Colors.grey),
          Icon(Icons.help,
              color:
              handleTitle.currentIndex == 1 ? Colors.white : Colors.grey),

          Icon(Icons.home_outlined,
              color:
              handleTitle.currentIndex == 2 ? Colors.white : Colors.grey),
          Icon(Icons.comment_outlined,
              color:
              handleTitle.currentIndex == 3 ? Colors.white : Colors.grey),
          Icon(Icons.person_add_outlined,
              color: handleTitle.currentIndex == 4 ? Colors.white : Colors.grey)
        ],
      ),
    );
  }
}