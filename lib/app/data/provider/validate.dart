import 'package:flutter/cupertino.dart';

class CheckValidate {
  String? validateEmail(FocusNode focusNode, String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
       //포커스를 해당 textformfield에 맞춘다.
      return '잘못된 이메일 형식입니다.';
    } else {
      return null;
    }
  }

  String? validatePassword(FocusNode focusNode, String value) {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      
      return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
    } else {
      return null;
    }
  }

  String? validatePasswordsame(
      FocusNode focusNode, String passwordsame, String password) {
    if (passwordsame != password) {
      
      return '동일한 비밀번호를 입력해주세요.';
    } else {
      String pattern =
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(passwordsame)) {
        
        return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
      } else {
        return null;
      }
    }
  }

  String? validateName(FocusNode focusNode, String value) {
    String pattern = r'^[가-힣]{2,6}$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return '2~6자의 한글이름을 입력해주세요';
    } else {
      return null;
    }
  }

  String? validatePhone(FocusNode focusNode, String value) {
    String pattern = r'^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return '숫자로 입력해주세요';
    } else {
      return null;
    }
  }
}
