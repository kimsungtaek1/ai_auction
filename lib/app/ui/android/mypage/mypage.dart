import 'package:ai_auction/app/controller/mypage/mypage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mypage extends GetView<MypageController> {
  @override
  Widget build(BuildContext context) {
    controller.loadUserProfile();

    return Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text(controller.title),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start, //왼쪽정렬
              children: <Widget>[
                Text('아이디 : ' + controller.user_id),
                Text('이름 : ' + controller.user_name),
                Text('전화번호 : ' + controller.user_phone),
                Text('가입경로 : ' + controller.user_channel),
                Text('회원등급 : ' + controller.user_grade),
                Text('가입일 : ' + controller.user_create_date),
                SizedBox(
                  height: 20,
                ),
                ((controller.userInform['book_list'] != null) &&
                        (controller.userInform['book_list'].length > 0) && (controller.book_list.length > 0))
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        child: ListView.separated(
                          padding: EdgeInsets.only(top: 0),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.userInform['book_list'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    //클릭하면 지도로 이동해야 한다.
                                    controller.itemClick(index);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(6),
                                      child: Row(children: [
                                        SizedBox(
                                            width: 200,
                                            child: Text(
                                                controller.book_list[index]
                                                    ['address_'],
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(controller.book_list[index]
                                            ['date_']),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(controller.book_list[index]
                                            ['predict'])
                                      ])),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(thickness: 1);
                          },
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        child: Text('즐겨찾기가 없습니다'),
                      ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amberAccent, // background
                    ),
                    child: const Text(
                      '로그아웃',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      controller.logout();
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amberAccent, // background
                    ),
                    child: const Text(
                      '회원탈퇴',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      controller.withdrawal();
                    },
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
