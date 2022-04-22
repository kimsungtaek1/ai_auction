import 'package:ai_auction/app/controller/root/root_controller.dart';
import 'package:get/get.dart';


class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController());
  }
}
