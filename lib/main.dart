
import 'dart:convert';

import 'package:ai_auction/app/controller/splash/splash_controller.dart';
import 'package:ai_auction/app/ui/android/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'app/controller/login/login_controller.dart';
import 'app/controller/mypage/mypage_controller.dart';
import 'app/controller/root/root_controller.dart';
import 'app/controller/service/service_controller.dart';
import 'app/routes/app_pages.dart';
//import 'app/ui/android/root/root.dart';
import 'app/ui/theme/app_theme.dart';
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final storage = FlutterSecureStorage();
    String user_id = '';
    String user_channel = '';

    void loadUserProfile() async {
      String? userString= await storage.read(key: 'login');
      if (userString!=null){
        Map<String, dynamic> user = jsonDecode(userString);
        print('[메인]저장된 아이디: '+user['user_id']+', 채널: '+user['user_channel']);
        user_id=user['user_id'];
        user_channel=user['user_channel'];
      } else{
        user_id='';
        user_channel='';
      }
    }
    loadUserProfile();

    return GetMaterialApp(
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      //home: Root(),
      home: Splash(),
      initialBinding: BindingsBuilder(() {
        //Get.put을 사용하여 컨트롤러를 추가하면, 해당 코드가 실행되는 시점에
        // 컨트롤러가 메모리에 생성되게 됩니다.
        // 하지만 다음과 같이 Get.lazyPut을 사용하면,
        // 실제로 컨트롤러를 사용하는 시점에 컨트롤러가 메모리에 생성되게 됩니다.
        Get.put(SplashController());
        Get.put(RootController());
        Get.put(LoginController());
        Get.put(MypageController());
        Get.put(ServiceController());
        //Get.lazyPut<LoginController>(() => LoginController());
        //Get.lazyPut<MypageController>(() => MypageController());
      }),
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const String page1 = "Home";
const String page2 = "Service";
const String page3 = "Profile";
const String title = "Demo";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> _pages;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late int _currentIndex;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _page1 = const Page1();
    _page2 = const Page2();
    _page3 = Page3(changePage: _changeTab);
    _pages = [_page1, _page2, _page3];
    _currentIndex = 0;
    _currentPage = _page1;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _changeTab(index);
          },
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: page1,
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: page2,
              icon: Icon(Icons.home_repair_service),
            ),
            BottomNavigationBarItem(
              label: page3,
              icon: Icon(Icons.person),
            ),
          ]),
      drawer: Drawer(
        child: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              _navigationItemListTitle(page1, 0),
              _navigationItemListTitle(page2, 1),
              _navigationItemListTitle(page3, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navigationItemListTitle(String title, int index) {
    return ListTile(
      title: Text(
        '$title Page',
        style: TextStyle(color: Colors.blue[400], fontSize: 22.0),
      ),
      onTap: () {
        Navigator.pop(context);
        _changeTab(index);
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$page1 Page', style: Theme.of(context).textTheme.headline6),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$page2 Page', style: Theme.of(context).textTheme.headline6),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key, required this.changePage}) : super(key: key);
  final void Function(int) changePage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$page3 Page', style: Theme.of(context).textTheme.headline6),
          ElevatedButton(
            onPressed: () {changePage(0);},
            child: const Text('Switch to Home Page'),
          )
        ],
      ),
    );
  }
}*/