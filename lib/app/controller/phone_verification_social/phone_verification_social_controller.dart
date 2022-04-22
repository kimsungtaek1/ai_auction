import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_auction/app/data/provider/request.dart';
import 'package:ai_auction/app/data/provider/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PhoneVerificationSocialController extends GetxController {
  static PhoneVerificationSocialController get to => Get.find();
  final String title = '추가정보';
  var value = Get.arguments;
  late TextEditingController emailTextController;
  late TextEditingController phoneTextController;
  late TextEditingController nameTextController;
  @override
  void onInit() {
    print('아이디:'+value['user_id']);
    if (value['user_channel']=='naver'){
      emailTextController = TextEditingController(text: value['user_email']);
      nameTextController = TextEditingController(text: value['user_name']); //뒤에서 받아오기
    }
    phoneTextController = TextEditingController();
    super.onInit();
  }
  //번호 인증

  void socialRegister() async {
    final storage = FlutterSecureStorage();

    Request request = Request(url: urlRegisterSocial, body: {
      'user_id' : value['user_id'],
      'user_email': emailTextController.text,
      'user_name': nameTextController.text,
      'user_phone': phoneTextController.text,
      'user_channel': value['user_channel'],
    }); //로그인 요청, 컨트롤러에서 값을 가져감

    request.post().then((value) async {
      //회원가입 요청 후
      //정보 저장 및 메인화면으로 정보 가지고 이동
      await storage.write(key: 'login', value: value.body);
      Map<String, String> allValues = await storage.readAll();
      print(allValues);
      Get.offAllNamed(AppRoutes.ROOT, arguments: true);
      print(value.body);
    }).catchError((onError) {});
  }
  void backButton() async{
    await FlutterNaverLogin.logOutAndDeleteToken();
    Get.back();
  }
  @override
  void onClose() {
    phoneTextController.dispose();
    nameTextController.dispose();
    super.onClose();
  }
}
