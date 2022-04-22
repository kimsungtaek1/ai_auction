import 'dart:convert';

import 'package:ai_auction/app/data/provider/storage.dart';
import 'package:ai_auction/app/ui/android/home/home.dart';
import 'package:ai_auction/app/ui/android/service/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  static RootController get to => Get.find();
  RxInt rootPageIndex = 1.obs;
  RxString rootPageBefore = ''.obs;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RxBool isCategoryPageOpen = false.obs;
  var user_id = '';
  var user_channel = '';
  String user_name = '';
  String user_phone = '';
  String user_grade = '';
  String user_create_date = '';
  var user_id1 = ''.obs;
  var user_channel1 = ''.obs;

  final SecureStorage storage = SecureStorage();
  @override
  void onInit() {
    storage.readSecureData('user_id').then((value) {
      if (value == null) {
        user_id = 'null';
      } else {
        user_id = value;
        print('루트컨:' + user_id);
      }
    });
    super.onInit();
  }

  void changeRootPageId() {
    storage.readSecureData('user_id').then((value) {
      if (value == null) {
        user_id = 'null';
      } else {
        user_id = value;
        print('changeRootPageId:' + user_id);
      }
    });
  }
  Navigator buildNavigator(Map<String, dynamic> itemClick) {
    if (itemClick!=null){
      if (itemClick['before_page'] == 'book_item')
        return Navigator(
          onGenerateRoute: (routeSettings) {
            return PageRouteBuilder(
              //pageBuilder: (context, animation1, animation2) => Service(no: int.parse(itemClick['no']), lat: double.parse(itemClick['lat'])+0.01, lng: double.parse(itemClick['lng'])),
              pageBuilder: (context, animation1, animation2) => Service(no: itemClick['no'], lat: double.parse(itemClick['lat'])+0.01, lng: double.parse(itemClick['lng'])),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          },
        );
      else
        return Navigator(
          onGenerateRoute: (routeSettings) {
            return PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => Home(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          },
        );
    } else {
      return Navigator(
        onGenerateRoute: (routeSettings) {
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Home(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          );
        },
      );
    }



  }
  void changeRootPageIndex(int index) {
    rootPageIndex(index);
  }

  void changeRootPageIndex1(int index) {
    rootPageIndex = (index).obs;
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
