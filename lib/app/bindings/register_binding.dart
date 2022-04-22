import 'package:ai_auction/app/controller/register/register_controller.dart';
import 'package:get/get.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
