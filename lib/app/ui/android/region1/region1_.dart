import 'package:ai_auction/app/ui/android/region2/region2.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
class Region1 extends StatefulWidget {
  const Region1({Key? key}) : super(key: key);
  @override
  _Region1State createState() => _Region1State();
}
class _Region1State extends State<Region1> {
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
    return MaterialApp(
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
            childAspectRatio: 3 / 2, //item 의 가로 3, 세로 2 의 비율
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
                                  Region2(text: _first[index]["first"]),
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