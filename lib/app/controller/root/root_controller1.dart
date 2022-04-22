import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  static RootController get to => Get.find();
  RxInt rootPageIndex = 1.obs;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RxBool isCategoryPageOpen = false.obs;

  void changeRootPageIndex(int index) {
    rootPageIndex(index);
  }
  void changeRootPageIndex1(int index) {
    rootPageIndex= (index).obs;
  }
  Future<bool> onWillPop() async {
    setCategoryPage(false);
    return !await navigatorKey.currentState!.maybePop();
  }

  void setCategoryPage(bool ck) {
    isCategoryPageOpen(ck);
  }

  void back() {
    setCategoryPage(false);
    onWillPop();
  }
}
