import 'package:ai_auction/app/controller/phone_verification_social/phone_verification_social_controller.dart';
import 'package:get/get.dart';


class PhoneVerificationSocialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneVerificationSocialController>(() => PhoneVerificationSocialController());
  }
}
