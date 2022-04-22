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
    var value_bool = false;
    var user_id_bool = false.obs;
    //controller.loadUserProfile();
    if (get_value==false){
      controller.user_id='';
    } else{
      controller.changeRootPageId();
    }
    print('controller.user_id :');
    print(controller.user_id);
    if (controller.user_id==''){
      user_id_bool=false.obs;
    } else if(controller.user_id==null) {
      user_id_bool=false.obs;
    }else if(controller.user_id=='null') {
      user_id_bool=false.obs;
    } else if(controller.user_id!='') {
      user_id_bool=true.obs;
    }
    print('user_id_bool :');
    print(user_id_bool);
    if (get_value==null||get_value==''||get_value==false){
      value_bool = false;
      controller.changeRootPageIndex1(1);
    } else if (get_value==true) {
      value_bool = true;
      controller.changeRootPageIndex1(1);
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
              (value_bool==false&&user_id_bool==false)?Login():Mypage(),
            ],
          ),
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
                icon: (value_bool==false&&user_id_bool==false)
                    ? Icon(Icons.login, color: Colors.grey)
                    : Icon(Icons.logout, color: Colors.grey),
                label: (value_bool==false&&user_id_bool==false)? 'Login' : 'Mypage',
                activeIcon: (value_bool==false&&user_id_bool==false)
                    ? Icon(Icons.login, color: Colors.blue)
                    : Icon(Icons.logout, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
