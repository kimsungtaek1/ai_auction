import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_auction/app/data/provider/request.dart';
import 'package:ai_auction/app/data/provider/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  String title = '';
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late TextEditingController password2TextController;
  late TextEditingController phoneTextController;
  late TextEditingController nameTextController;
  @override
  void onInit() {
    title = '회원가입';
    emailTextController = TextEditingController(text: 'test@naver.com');
    passwordTextController = TextEditingController(text: 'k123456!');
    password2TextController = TextEditingController(text: 'k123456!');
    nameTextController = TextEditingController(text: '테스트');
    phoneTextController = TextEditingController(text: '01099999999');
    super.onInit();
  }

  void ApiRegister() async {
    final storage = FlutterSecureStorage();

    Request request = Request(url: urlRegister, body: {
      'user_email': emailTextController.text,
      'user_pass': passwordTextController.text,
      'user_phone': phoneTextController.text,
      'user_name': nameTextController.text,
      'user_channel': 'email'
    }); //로그인 요청, 컨트롤러에서 값을 가져감

    request.post().then((value) async {
      print('넘어온값:'+value.body);
      if (value.body == 'ExistUser') {
        Get.dialog(
          AlertDialog(
            title: const Text('회원가입 오류'),
            content: const Text('이미 사용중인 이메일입니다.'),
            actions: [
              TextButton(
                child: const Text("확인"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      } else {
        /*
        await storage.write(key: 'login', value: emailTextController.text);
        await storage.write(
            key: 'password',
            value: passwordTextController
                .text); //유저의 deviceid 또는 서버에서 받은 유저 고유값을 조합하면 더 강력한 보안이 됨.
        Map<String, String> allValues = await storage.readAll();
        print(allValues);
        Get.offAllNamed(AppRoutes.ROOT, arguments: false);
         */
        Get.back();
      }
    }).catchError((onError) {});
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    password2TextController.dispose();
    phoneTextController.dispose();
    nameTextController.dispose();
    super.onClose();
  }
}
