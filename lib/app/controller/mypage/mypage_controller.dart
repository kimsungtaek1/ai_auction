import 'dart:convert';
import 'package:ai_auction/app/controller/root/root_controller.dart';
import 'package:ai_auction/app/data/provider/request.dart';
import 'package:ai_auction/app/data/provider/storage.dart';
import 'package:ai_auction/app/data/provider/url.dart';
import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
class MypageController extends GetxController {
  static MypageController get to => Get.find();
  final String title = '마이페이지';
  String user_id = '';
  String user_name = '';
  String user_phone = '';
  String user_channel = '';
  String user_grade = '';
  String user_create_date = '';
  var book_list=[];
  var userInform = Map<String, dynamic>();
  final SecureStorage storage = SecureStorage();

  void loadUserProfile() async {
    String? userString= await storage.readSecureData('user_id');
    if (userString!=null){
      Request request = Request(url: urlUserInform, body: {
        'user_id': userString,
      }); //로그인 요청, 컨트롤러에서 값을 가져감
      request.post().then((value) async {
        if (value.body == 'NoUser') {
          print('MypageController NoUser: '+value.body);
        } else {
          print('MypageController GetUser: '+value.body);
          userInform = jsonDecode(value.body);
          user_id=userInform['user_email'];
          user_name = userInform['user_name'];
          user_channel=userInform['user_channel'];
          user_phone=userInform['user_phone'];
          user_grade=userInform['user_grade'];
          user_create_date=userInform['user_create_date'];
          book_list=userInform['book_list'];
          print('마이페이지 request 후 book_list: $book_list');
        }
      }).catchError((onError) {});
    }
  }
  void logout() async {
    if (user_channel=='naver'){
      await FlutterNaverLogin.logOut();
      //await FlutterNaverLogin.logOutAndDeleteToken();
    }
    user_id='';
    user_name='';
    user_phone='';
    user_channel='';
    user_grade='';
    user_create_date='';
    book_list=[];
    await storage.deleteAllSecureData();
    print('로그아웃시저장되는값:');
    var logout_save=await storage.readAllSecureData();
    print(logout_save);
    Get.offAllNamed(AppRoutes.ROOT, arguments: {'before_page':'logout'});
  }
  void withdrawal() async {
    //회원탈퇴 네이버 or 이메일
  }
  void itemClick(int index){
    Get.offAllNamed(AppRoutes.ROOT, arguments: {'before_page':'book_item','no':book_list[index]['no'],'lat':book_list[index]['lat'],'lng':book_list[index]['lng']});
  }
  @override
  void onClose() {
    super.onClose();
  }
}
