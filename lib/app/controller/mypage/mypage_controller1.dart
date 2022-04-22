import 'dart:convert';
import 'package:ai_auction/app/data/provider/request.dart';
import 'package:ai_auction/app/data/provider/url.dart';
import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
class MypageController extends GetxController {
  static MypageController get to => Get.find();
  final String title = '마이페이지';
  String user_id = '';
  String user_name = '';
  String user_phone = '';
  String user_channel = '';
  String user_grade = '';
  String user_create_date = '';
  final storage = FlutterSecureStorage();
  void loadUserProfile() async {
    String? userString= await storage.read(key: 'login');
    if (userString!=null){
      Map<String, dynamic> user = jsonDecode(userString);
      //print('저장된 아이디: '+user['user_id']+', 채널: '+user['user_channel']);
      Request request = Request(url: urlUserInform, body: {
        'user_id': user['user_id'],
        'user_channel': user['user_channel'],
      }); //로그인 요청, 컨트롤러에서 값을 가져감
      request.post().then((value) async {
        if (value.body == 'NoUser') {
          print(value.body);
        } else {
          print(value.body);
          Map<String, dynamic> userInform = jsonDecode(value.body);
          user_id=userInform['user_id'];
          user_name = userInform['user_name'];
          user_channel=userInform['user_channel'];
          user_phone=userInform['user_phone'];
          user_grade=userInform['user_grade'];
          user_create_date=userInform['user_create_date'];
        }
      }).catchError((onError) {});

    }
    //회원정보 불러오기
  }
  void logout() async {
    if (user_channel=='naver'){
      await FlutterNaverLogin.logOut();
      //await FlutterNaverLogin.logOutAndDeleteToken();
    }
    user_id='';
    user_name='';
    user_phone='';
    user_channel='';
    user_grade='';
    user_create_date='';
    await storage.deleteAll();
    Map<String, String> allValues2 = await storage.readAll();
    print('로그아웃시저장되는값:');
    print(allValues2);
    Get.offAllNamed(AppRoutes.ROOT, arguments: false);
  }
  @override
  void onClose() {
    super.onClose();
  }
}
