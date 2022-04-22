import 'package:ai_auction/app/controller/mypage/mypage_controller.dart';
import 'package:get/get.dart';


class MypageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MypageController>(() => MypageController());
  }
}
