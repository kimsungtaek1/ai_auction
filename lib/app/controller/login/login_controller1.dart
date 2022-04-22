import 'dart:convert';

import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_auction/app/data/provider/request.dart';
import 'package:ai_auction/app/data/provider/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class LoginController extends GetxController {
  final String title = '로그인';
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  void apiLogin() async {
    final storage = FlutterSecureStorage();

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    Request request = Request(url: urlLogin, body: {
      'email': emailTextController.text,
      'pass': passwordTextController.text
    }); //로그인 요청, 컨트롤러에서 값을 가져감

    request.post().then((value) async {
      if (value.body=='Error'){

      }else if(value.body=='NoUser'){

      }else{

      }
      await storage.write(key: 'login', value: value.body);
      await storage.write(key: 'password', value: passwordTextController.text); //유저의 deviceid 또는 서버에서 받은 유저 고유값을 조합하면 더 강력한 보안이 됨.

      Map<String, String> allValues = await storage.readAll();
      print(allValues);

      Get.back();
      Get.offNamed(AppRoutes.ROOT, arguments: true);
      //Get.offNamed(AppRoutes.ROOT);
    }).catchError((onError) {});
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}