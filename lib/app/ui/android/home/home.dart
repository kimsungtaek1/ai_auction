import 'package:ai_auction/app/controller/root/root_controller.dart';
import 'package:ai_auction/app/ui/android/region1/region1.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("홈페이지 버전 1.0.2"),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amberAccent, // background
                    ),
                    child: const Text(
                      '이벤트',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent, // background
                    ),
                    child: const Text(
                      '아파트 찾기',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      RootController.to.setCategoryPage(true);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              Region1(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent, // background
                    ),
                    child: const Text(
                      '전략 가이드',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent, // background
                    ),
                    child: const Text(
                      '기타',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
