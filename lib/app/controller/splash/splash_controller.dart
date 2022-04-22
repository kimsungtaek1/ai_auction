import 'dart:async';
import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:ai_auction/app/ui/android/root/root.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(Duration(seconds: 1), () {
      Get.offAllNamed(AppRoutes.ROOT, arguments: {'before_page':'null'});
    });
    super.onInit();
  }
}
