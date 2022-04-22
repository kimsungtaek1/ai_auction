import 'package:ai_auction/app/controller/service/service_controller.dart';
import 'package:get/get.dart';


class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceController>(() => ServiceController());
  }
}
