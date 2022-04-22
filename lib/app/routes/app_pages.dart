import 'package:ai_auction/app/bindings/home_binding.dart';
import 'package:ai_auction/app/bindings/login_binding.dart';
import 'package:ai_auction/app/bindings/phone_verification_social_binding.dart';
import 'package:ai_auction/app/bindings/mypage_binding.dart';
import 'package:ai_auction/app/bindings/region1_binding.dart';
import 'package:ai_auction/app/bindings/region2_binding.dart';
import 'package:ai_auction/app/bindings/register_binding.dart';
import 'package:ai_auction/app/bindings/root_binding.dart';
import 'package:ai_auction/app/bindings/splash_binding.dart';
import 'package:ai_auction/app/ui/android/home/home.dart';
import 'package:ai_auction/app/ui/android/login/login.dart';
import 'package:ai_auction/app/ui/android/mypage/mypage.dart';
import 'package:ai_auction/app/ui/android/phone_verification_social/phone_verification_social.dart';
import 'package:ai_auction/app/ui/android/region1/region1.dart';
import 'package:ai_auction/app/ui/android/region2/region2.dart';
import 'package:ai_auction/app/ui/android/register/register.dart';
import 'package:ai_auction/app/ui/android/root/root.dart';
import 'package:ai_auction/app/ui/android/splash/splash.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
        name: AppRoutes.ROOT,
        page: () => Root(),
        binding: RootBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.REGION1,
        page: () => Region1(),
        binding: Region1Binding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.REGION2,
        page: () => Region2(text: '',),
        binding: Region2Binding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => Login(),
        binding: LoginBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.MYPAGE,
        page: () => Mypage(),
        binding: MypageBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.HOME,
        page: () => Home(),
        binding: HomeBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.PHONE_VERIFICATION_SOCIAL,
        page: () => PhoneVerificationSocial(),
        binding: PhoneVerificationSocialBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.REGISTER,
        page: () => Register(),
        binding: RegisterBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.SPLASH,
        page: () => Splash(),
        binding: SplashBinding(),
        transition: Transition.noTransition),
  ];
}
