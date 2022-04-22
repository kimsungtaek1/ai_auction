
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:fl_chart/fl_chart.dart';

import 'app/data/provider/validate.dart';

const String kakaoMapKey = 'd6095ebc8ddebfaf71ea969d77669780';

void main() => runApp(MaterialApp(
  title: "App",
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  Future login() async {
    var response = await http
        .post(Uri.parse('http://kstbook1.dothome.co.kr/login_user.php'), body: {
      "email": _id.text,
      "pass": _pass.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data == 'Error') {
      showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: <Widget>[
                  new Text("로그인"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "비밀번호가 틀렸습니다",
                  ),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: new Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else if (data == 'NoUser') {
      showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: <Widget>[
                  new Text("로그인"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "아이디가 없습니다",
                  ),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: new Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else if (data == 'Success') {
      showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: <Widget>[
                  new Text("로그인"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "로그인 성공",
                  ),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: new Text("확인"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstPage(),
                      ),
                    );
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VERITAS AI 경매 예측시스템'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            ButtomPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: Container(
                      child: Image.asset('images/apt_image.jpg',
                          fit: BoxFit.fill)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _id,
                    scrollPadding: EdgeInsets.only(bottom: 80),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '아이디',
                      contentPadding: EdgeInsets.all(10.0),
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: _pass,
                    scrollPadding: EdgeInsets.only(bottom: 80),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '비밀번호',
                      contentPadding: EdgeInsets.all(10.0),
                    )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text('로그인'),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            NaverLoginPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: Text('네이버 로그인'),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            RegisterPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: Text('회원가입'),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NaverLoginPage extends StatefulWidget {
  const NaverLoginPage({Key? key}) : super(key: key);
  @override
  _NaverLoginPageState createState() => _NaverLoginPageState();
}

class _NaverLoginPageState extends State<NaverLoginPage> {
  String naver_name = '';
  String naver_email = '';
  // Fetch content from the json file
  Future<void> readJson() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();

    setState(() {
      naver_name = res.account.name;
      naver_email = res.account.email;
    });
  }

  @override
  void initState() {
    //1번만 실행
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
              ;
            },
          ),
          title: Text('VERITAS AI 경매 예측시스템'),
          centerTitle: true,
        ),
        body: Text(
          naver_name + ' ' + naver_email,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _passwordsameFocus = new FocusNode();
  FocusNode _nameFocus = new FocusNode();
  FocusNode _phoneFocus = new FocusNode();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future register() async {
    var response = await http.post(
        Uri.parse('http://kstbook1.dothome.co.kr/register_user.php'),
        body: {
          "email": _email.text,
          "pass": _pass.text,
          "user_channel": 'email',
          "user_name": _name.text,
          "user_phone": _phone.text,
        });
    var data = json.decode(response.body);
    if (data == 'Error') {
      showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: <Widget>[
                  new Text("회원가입"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "동일한 이메일이 존재합니다",
                  ),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: new Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else if (data == 'Success') {
      showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: <Widget>[
                  new Text("회원가입"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "회원가입 성공",
                  ),
                ],
              ),
              actions: <Widget>[
                new TextButton(
                  child: new Text("확인"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      resizeToAvoidBottomInset: false,
      body: new Form(
          key: formKey,
          child: Column(
            children: [
              _showEmailInput(),
              _showPasswordInput(),
              _showPasswordsameInput(),
              _showNameInput(),
              _showPhoneInput(),
              _showOkBtn()
            ],
          )),
    );
  }

  Widget _showEmailInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocus,
                  decoration: _textFormDecoration('이메일', '이메일을 입력해주세요'),
                  validator: (value) =>
                      CheckValidate().validateEmail(_emailFocus, value!),
                )),
          ],
        ));
  }

  Widget _showPasswordInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _pass,
                  focusNode: _passwordFocus,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: _textFormDecoration(
                      '비밀번호', '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.'),
                  validator: (value) =>
                      CheckValidate().validatePassword(_passwordFocus, value!),
                )),
          ],
        ));
  }

  Widget _showPasswordsameInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _confirmPass,
                  focusNode: _passwordsameFocus,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: _textFormDecoration('비밀번호확인', '동일한 비밀번호를 입력해주세요'),
                  validator: (value) => CheckValidate().validatePasswordsame(
                      _passwordsameFocus, value!, _pass.text),
                )),
          ],
        ));
  }

  Widget _showNameInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _name,
                  focusNode: _nameFocus,
                  keyboardType: TextInputType.name,
                  decoration: _textFormDecoration('이름', '이름을 입력해주세요'),
                  validator: (value) =>
                      CheckValidate().validateName(_nameFocus, value!),
                )),
          ],
        ));
  }

  Widget _showPhoneInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phone,
                  focusNode: _phoneFocus,
                  keyboardType: TextInputType.phone,
                  decoration: _textFormDecoration('휴대전화', '휴대전화번호를 입력해주세요'),
                  validator: (value) =>
                      CheckValidate().validatePhone(_phoneFocus, value!),
                )),
          ],
        ));
  }

  InputDecoration _textFormDecoration(hintText, helperText) {
    return new InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
      hintText: hintText,
      helperText: helperText,
      labelStyle: TextStyle(color: Colors.black),
      errorStyle: TextStyle(
        color: Colors.red,
        //color: isFileInvalid ?  Colors.green : Colors.red,
      ),
    );
  }

  Widget _showOkBtn() {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: MaterialButton(
          height: 50,
          child: Text('확인'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              print('폼성공');
              register();
            } else {
              print('폼실패');
            }
          },
        ));
  }
}

class ButtomPage extends StatefulWidget {
  const ButtomPage({Key? key}) : super(key: key);
  @override
  _ButtomPageState createState() => _ButtomPageState();
}

class _ButtomPageState extends State<ButtomPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex, //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'Music',
            icon: Icon(Icons.music_note),
          ),
          BottomNavigationBarItem(
            label: 'Places',
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  List _widgetOptions = [
    Text(
      'Favorites',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    Text(
      'Music',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    Text(
      'Places',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),

  ];
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List _first = [];
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/region1.json');
    final data = await json.decode(response);

    setState(() {
      _first = data["first"];
    });
  }

  @override
  void initState() {
    //1번만 실행
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
              ;
            },
          ),
          title: Text('VERITAS AI 경매 예측시스템'),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10), // 바깥쪽 여백
          itemCount: _first.length, //item 개수
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 3 / 2, //item 의 가로 1, 세로 1 의 비율
            mainAxisSpacing: 10, //수평 Padding
            crossAxisSpacing: 10, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            //item 의 반목문 항목 형성
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  SecondPage(text: _first[index]["first"]),
                              transitionDuration: Duration.zero,
                            ),
                          );
                        },
                        child: Text(
                          _first[index]["first"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String text;
  const SecondPage({Key? key, required this.text}) : super(key: key);
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List _second = [];
  late final String previous_value;
  @override
  void initState() {
    //1번만 실행
    super.initState();
    previous_value = widget.text;
    readJson();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/region2.json');
    Map snap = jsonDecode(response);
    List data = snap["second"];
    setState(() {
      _second = data.where((d) => d["first"] == previous_value).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                Navigator.pop(context);
                ;
              },
            ),
            title: Text('VERITAS AI 경매 예측시스템'),
            centerTitle: true,
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(10), // 바깥쪽 여백
            itemCount: _second.length, //item 개수
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 3 / 2, //item 의 가로 1, 세로 1 의 비율
              mainAxisSpacing: 10, //수평 Padding
              crossAxisSpacing: 10, //수직 Padding
            ),
            itemBuilder: (BuildContext context, int index) {
              //item 의 반목문 항목 형성
              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) =>
                                    KakaoMapPage(
                                      second_text: _second[index]["second"],
                                      lat: _second[index]["lat"],
                                      lng: _second[index]["lng"],
                                    ),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Text(
                            _second[index]["second"],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}

class KakaoMapPage extends StatefulWidget {
  final String second_text;
  final double lat;
  final double lng;
  const KakaoMapPage(
      {Key? key,
        required this.second_text,
        required this.lat,
        required this.lng})
      : super(key: key);
  @override
  _KakaoMapPageState createState() => _KakaoMapPageState();
}

//********개발노트*******
//1. 지도 범위 내에 있는 마커들을 불러온다
//2. 지도를 움직이면 새로 마커들을 불러온다
class _KakaoMapPageState extends State<KakaoMapPage> {
  List data = [];
  late final String previous_value; //지역
  late final double previous_lat;
  late final double previous_lng;
  var i;
  var overlay_i;
  var predict;
  var predict_won;
  var result_price;
  var predict_range_text = "";
  var responseBody;
  var json_string;
  var json_text;
  var name;
  final List<int> showIndexes = const [4];
  final List<FlSpot> allSpots = const [
    FlSpot(0, 1),
    FlSpot(1, 2),
    FlSpot(2, 1.5),
    FlSpot(3, 3),
    FlSpot(4, 3.5),
    FlSpot(5, 1.5),
    FlSpot(6, 1),
  ];
  @override
  void initState() {
    //1번만 실행
    super.initState();
    previous_value = widget.second_text; //전에 값 받기
    previous_lat = widget.lat;
    previous_lng = widget.lng;
    json_string = readJson1();
    print('JSON디코드텍스트:');
    print(json_string);
  }

  // Fetch content from the json file
  Future<String> readJson1() async {
    http.Response res =
    await http.get(Uri.parse('http://kstbook1.dothome.co.kr/apt_json.php'));
    responseBody = res.body;
    List data = jsonDecode(responseBody);
    json_text = data.toList();
    //print(json_text);
    //특정마커를 클릭하면 그 클릭한 위도,경도로 찾게하자.
    return responseBody;
  }

  // Fetch content from the json file
  Future<String> readJson2() async {
    http.Response res = await http
        .post(Uri.parse('http://kstbook1.dothome.co.kr/apt_json_contents.php'));
    responseBody = res.body;
    List data = jsonDecode(responseBody);
    json_text = data.toList();
    //print(json_text);
    //특정마커를 클릭하면 그 클릭한 위도,경도로 찾게하자.
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final lineBarsData = [
      LineChartBarData(
          showingIndicators: showIndexes,
          spots: allSpots,
          isCurved: true,
          barWidth: 4,
          shadow: const Shadow(
            blurRadius: 8,
            color: Colors.black,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              const Color(0xff12c2e9).withOpacity(0.4),
              const Color(0xffc471ed).withOpacity(0.4),
              const Color(0xfff64f59).withOpacity(0.4),
            ],
          ),
          dotData: FlDotData(show: false),
          colors: [
            const Color(0xff12c2e9),
            const Color(0xffc471ed),
            const Color(0xfff64f59),
          ],
          colorStops: [
            0.1,
            0.4,
            0.9
          ]),
    ];

    final tooltipsOnBar = lineBarsData[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VERITAS AI 경매 예측시스템'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FutureBuilder(
                    future: json_string,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                      if (snapshot.hasData == false) {
                        return SizedBox(
                            width: size.width,
                            height: 400,
                            child: Center(child: CircularProgressIndicator()));
                      }
                      // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                      else {
                        print(snapshot.data.toString());
                        return KakaoMapView(
                          width: size.width,
                          height: 400,
                          kakaoMapKey: kakaoMapKey,
                          lat: previous_lat,
                          lng: previous_lng,
                          zoomLevel: 7,
                          customScript: '''
                      var overlays = [];
                      var positions = ''' +
                              snapshot.data.toString() +
                              ''';
////////////////////////테스트용/////////////////////////
                      var markerList = [];
                      var test_lat = 37.515;
                      var test_lng = 127.035;
                      var markers = [];
                      map.setMinLevel(3); //최대확대레벨 자세히보인다
                      //map.setMaxLevel(7); //최대축소레벨 멀리보인다
                      for(var i = 0; i < 0; i++)
                      {
                        test_lat = Number(test_lat)+0.005;
                        test_lng = Number(test_lng)+0.005;
                        console.log("테스트:",test_lat,test_lng);
                        markerList.push([test_lat, test_lng]);
                      }
                      kakao.maps.event.addListener(map, "idle", function () {
                          var mapBounds = map.getBounds();
                          var markerObj, position;
                          for (var i = 0; i < markerList.length; i++) {                      
                              markerObj = markerList[i]
                              var marker = new kakao.maps.Marker({
                                position: new kakao.maps.LatLng(markerObj[0], markerObj[1]),
                                map: map
                              });
                              if (mapBounds.contain(marker.getPosition()) == true) {
                                  markers.push(marker);
                                  console.log(markerObj[0],markerObj[1]);
                              } else {
                                  markers = [];
                              }
                          }
                      });
                      function removeMarkers() { // 지도 위에 표시되고 있는 오버레이 제거
                          for (var i = 0; i < markers.length; i++) {
                              markers[i].setMap(null);
                          }
                          markers = [];
                      }
                      //addMarkers();
////////////////////////////////////////////////////                      
                      var latlng;
                      var zIndex=1;
                      makeOverlay();
                      function makeOverlay() {
                        for(var i = 0 ; i < positions.length ; i++){
                          latlng = new kakao.maps.LatLng(positions[i].lat,positions[i].lng);
                          var overlay = new kakao.maps.CustomOverlay({
                            map: map,
                            content: '<style>.customOverlay{position:relative;bottom:40px;width:100px;height:30px;background:#fff;</style><div class="customOverlay" onclick="onTapOverlay.postMessage('+i+');this.parentElement.style.zIndex=zIndex;zIndex++;"><div style="font-size:10px;padding:2px;">'+positions[i].apt_name+'</div><div style="font-size:8px;padding:2px;">'+positions[i].date_+'</div></div>',
                            //클릭하면 오버레이에서 string메세지를 dart파일에 보냄, 그리고 z-index를 클릭할때 클릭한 요소를 계속해서 1씩 올림. 그렇게 하는 이유는 z-index를 초기화하려면 전체 오버레이 z-index를 전부다 0으로 초기화해야하기 때문, 그리고 지도를 이동시키면 자동으로 오버레이들이 한번 삭제되므로(removeOverlay 함수에서) z-index가 자동으로 초기화됨
                            position: latlng,
                            yAnchor: 1,
                            zIndex: 0  
                          });
                          overlay.setMap(map);
                          overlays.push(overlay); //overlay를 리스트(overlays)에 넣음                          
                        }
                      }
                      function removeOverlay() { // 지도 위에 표시되고 있는 오버레이 제거
                          for (var i = 0; i < overlays.length; i++) {
                              overlays[i].setMap(null);
                          }
                          overlays = [];
                      }


                      var zoomControl = new kakao.maps.ZoomControl(); //지도 줌 보여주기
                      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
                      var mapTypeControl = new kakao.maps.MapTypeControl(); //지도 유형 보여주기
                      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
                    ''',
                          onTapOverlay: (message) {
                            setState(() {
                              i = message.message;
                              overlay_i = int.parse(i);
                              predict = json_text[overlay_i]['predict'];
                              predict_won = (int.parse(predict) / 100000000)
                                  .toStringAsFixed(2) +
                                  '억 원';
                              if (json_text[overlay_i]['result_price'] != '0') {
                                result_price =
                                json_text[overlay_i]['result_price'];
                              } else {
                                result_price = '유찰';
                              }
                            });
                          },
                        );
                      }
                    }),
                if (overlay_i != null)
                  Text("사건번호: " +
                      json_text[overlay_i]['court_'] +
                      " " +
                      json_text[overlay_i]['case_']),
                if (overlay_i != null)
                  Text("아파트명: " + json_text[overlay_i]['apt_name']),
                if (overlay_i != null)
                  Text("주소: " + json_text[overlay_i]['address_']),
                if (overlay_i != null) Text("예측가: " + predict),
                if (overlay_i != null) Text("낙찰가: " + result_price),
                if (overlay_i != null)
                  Text("경매개시일: " + json_text[overlay_i]['date_']),
                if (overlay_i != null)
                  SizedBox(
                    height: 30,
                  ),
                if (overlay_i != null)
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        rangeAnnotations: RangeAnnotations(
                          verticalRangeAnnotations: [
                            VerticalRangeAnnotation(
                              x1: 3,
                              x2: 5,
                              color: const Color(0xffD5DAE5),
                            ),
                          ],
                        ),
                        showingTooltipIndicators: showIndexes.map((index) {
                          return ShowingTooltipIndicators([
                            LineBarSpot(
                                tooltipsOnBar,
                                lineBarsData.indexOf(tooltipsOnBar),
                                tooltipsOnBar.spots[index]),
                          ]);
                        }).toList(),
                        lineTouchData: LineTouchData(
                          enabled: false,
                          getTouchedSpotIndicator: (LineChartBarData barData,
                              List<int> spotIndexes) {
                            return spotIndexes.map((index) {
                              return TouchedSpotIndicatorData(
                                FlLine(
                                  color: Colors.green,
                                ),
                                FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                      FlDotCirclePainter(
                                        radius: 8,
                                        color: lerpGradient(barData.colors,
                                            barData.colorStops!, percent / 100),
                                        strokeWidth: 2,
                                        strokeColor: Colors.black,
                                      ),
                                ),
                              );
                            }).toList();
                          },
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.red,
                            tooltipRoundedRadius: 8,
                            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                              return lineBarsSpot.map((lineBarSpot) {
                                return LineTooltipItem(
                                  predict_won, //텍스트 내용
                                  const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        lineBarsData: lineBarsData,
                        maxY: 5,
                        minY: 0,
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                            showTitles: false,
                          ),
                          bottomTitles: SideTitles(
                            showTitles: false,
                          ),
                          rightTitles: SideTitles(showTitles: false),
                          topTitles: SideTitles(showTitles: false),
                        ),
                        axisTitleData: FlAxisTitleData(
                          topTitle: AxisTitle(
                              showTitle: true,
                              titleText: '예측가 차트',
                              textAlign: TextAlign.left),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(
                          show: false,
                        ),
                      ),
                    ),
                  ),
                if (overlay_i != null)
                  SizedBox(
                    height: 100,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
