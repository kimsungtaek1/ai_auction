import 'package:ai_auction/app/controller/region2/region2_controller.dart';
import 'package:get/get.dart';


class Region2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Region2Controller>(() => Region2Controller());
  }
}
