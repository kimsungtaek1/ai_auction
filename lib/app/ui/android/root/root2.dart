import 'dart:convert';
import 'package:ai_auction/app/controller/root/root_controller.dart';
import 'package:ai_auction/app/ui/android/home/home.dart';
import 'package:ai_auction/app/ui/android/login/login.dart';
import 'package:ai_auction/app/ui/android/mypage/mypage.dart';
import 'package:ai_auction/app/ui/android/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Root extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    var get_value = Get.arguments; //로그인에서 가져온 정보
    RxBool value_bool = false.obs;
    //controller.loadUserProfile();

    /*
    if (get_value == null&&(controller.user_id1!=''&&controller.user_channel1!='')){
      print('자동로그인 ${controller.user_id1} ${controller.user_channel1}');
      value_bool = true.obs;
      controller.changeRootPageIndex1(1);
    }
     */

    if (get_value == null&&(controller.user_id1!=''&&controller.user_channel1!='')){
      print('자동로그인');
      value_bool = true.obs;
      controller.changeRootPageIndex1(1);
    } else {
      if (get_value == null) {
        print('밸류값: null');
        value_bool = false.obs;
      } else {
        if (get_value==true){
          print('밸류값: $get_value');
          value_bool = true.obs;
          controller.changeRootPageIndex1(1);
        } else if (get_value==false){
          print('밸류값: $get_value');
          value_bool = false.obs;
          controller.changeRootPageIndex1(1);
        }
      }
    }


    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.rootPageIndex.value,
            children: [
              Search(),
              Navigator(
                onGenerateRoute: (routeSettings) {
                  return PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Home(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  );
                },
              ),
              (value_bool==true.obs)||(controller.user_id1!=null)?Mypage():Login(),
            ],
          ),
          bottomSheet: Text('자동로그인정보 : $get_value ${Get.find<RootController>().user_id1.value} ${Get.find<RootController>().user_channel1.value}'),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.rootPageIndex.value,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: controller.changeRootPageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore, color: Colors.grey),
                label: 'Search',
                activeIcon: Icon(Icons.explore, color: Colors.blue),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey),
                label: 'Home',
                activeIcon: Icon(Icons.home, color: Colors.blue),
              ),
              BottomNavigationBarItem(
                icon: (value_bool==true.obs)||(controller.user_id1!=null)
                    ? Icon(Icons.logout, color: Colors.grey)
                    : Icon(Icons.login, color: Colors.grey),
                label: (value_bool==true.obs)||(controller.user_id1!=null) ? 'Mypage' : 'Login',
                activeIcon: (value_bool==true.obs)||(controller.user_id1!=null)
                    ? Icon(Icons.logout, color: Colors.blue)
                    : Icon(Icons.login, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
