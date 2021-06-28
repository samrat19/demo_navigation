import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'curved_navigation_bar.dart';

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
          if (handleTitle.currentIndex != 0) {
            handleTitle.changeIndex(0);
            return Future.value(false);
          } else if (handleTitle.currentIndex == 0) {
            handleTitle.changeIndex(0);
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
                      child: bottomNavBar(context),
                    ))
              ],
            ),
          ),
          drawer: Drawer(),
          //bottomNavigationBar: bottomNavBar(context)
        ));
  }

  Widget bottomNavBar(BuildContext context) {
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

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
      ),
    );
  }
}

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
