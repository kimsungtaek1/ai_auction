import 'dart:convert';

import 'package:ai_auction/app/controller/root/root_controller.dart';
import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_auction/app/data/provider/request.dart';
import 'package:ai_auction/app/data/provider/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  final String title = '로그인';
  final storage = FlutterSecureStorage();
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  @override
  void onInit() {
    emailTextController = TextEditingController(text: 'test@naver.com');
    passwordTextController = TextEditingController(text: 'k123456!');
    super.onInit();
  }

  void ApiLogin() async {
    Request request = Request(url: urlLogin, body: {
      'email': emailTextController.text,
      'pass': passwordTextController.text,
    }); //로그인 요청, 컨트롤러에서 값을 가져감

    request.post().then((value) async {
      if (value.body == 'WrongPass') {
        Get.dialog(
          AlertDialog(
            title: const Text('로그인 오류'),
            content: const Text('비밀번호를 올바르게 입력해주세요'),
            actions: [
              TextButton(
                child: const Text("확인"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      } else if (value.body == 'NoUser') {
        Get.dialog(
          AlertDialog(
            title: const Text('로그인 오류'),
            content: const Text('사용자가 없습니다'),
            actions: [
              TextButton(
                child: const Text("확인"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      } else {
        Map<String, dynamic> loginInform = jsonDecode(value.body);
        await storage.write(key: 'user_id', value: loginInform['user_id']);
        await storage.write(key: 'user_channel', value: loginInform['user_channel']);
        Get.offAllNamed(AppRoutes.ROOT, arguments: {'before_page':'login'});
      }
    }).catchError((onError) {});
  }

  Future<void> naverLogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    String naver_id;
    String naver_name;
    String naver_email;
    naver_id = res.account.id;
    naver_name = res.account.name;
    naver_email = res.account.email;

    //네이버 아이디가 존재하면 그냥 로그인하여 루트페이지로 가고, 존재하지 않으면 상세정보페이지로 가기
    Request request = Request(url: urlLoginSocial, body: {
      'user_id' : naver_id,
      'user_channel': 'naver',
    }); //로그인 요청, 컨트롤러에서 값을 가져감

    request.post().then((value) async {
      print(value.body);
      if (value.body=='NoUser'){
        print('네이버가입이안됨:'+value.body);
        Get.toNamed(AppRoutes.PHONE_VERIFICATION_SOCIAL,
            arguments: {'user_id': naver_id,'user_name': naver_name, 'user_email': naver_email, 'user_channel': 'naver'});
      } else{
        //로그인 정보 저장 후 루트페이지로 간다.
        print('네이버가입이되어있음:'+value.body);
        await storage.write(key: 'user_id', value: naver_id);
        await storage.write(key: 'user_channel', value: 'naver');
        Get.offAllNamed(AppRoutes.ROOT, arguments: {'before_page':'login'});
      }
    }).catchError((onError) {});

  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
