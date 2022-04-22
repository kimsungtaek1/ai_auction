import 'package:ai_auction/app/ui/android/service/service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class Region2 extends StatefulWidget {
  final String text;
  const Region2({Key? key, required this.text}) : super(key: key);
  @override
  _Region2State createState() => _Region2State();
}

class _Region2State extends State<Region2> {
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
                                    Service(
                                      no:'0',
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