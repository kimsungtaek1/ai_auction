import 'package:ai_auction/app/controller/region1/region1_controller.dart';
import 'package:get/get.dart';


class Region1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Region1Controller>(() => Region1Controller());
  }
}
