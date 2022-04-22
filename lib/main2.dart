

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> data = [HomeTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    print('테스트');
    return new CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Flutter Cupertino Tabbar"),
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.wand_rays),
                label: "event",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: "Profile",
              )
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(child: ProfileTab());
                });
                break;
              case 1:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(child: HomeTab());
                });
                break;
              case 2:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(child: ProfileTab());
                });
                break;
              default:
                return const CupertinoTabView();
            }
          },
        ));
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: FlatButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeTabsecond()),
          ),
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
                child: Text(
              'next screen',
              style: TextStyle(fontSize: 24, color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: FlatButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileTabsecond()),
          ),
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
                child: Text(
              'next screen',
              style: TextStyle(fontSize: 24, color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}

class HomeTabsecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Text(
          "This is HomeTabsecond page",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ProfileTabsecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Text(
          "This is ProfileTabsecond page",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
