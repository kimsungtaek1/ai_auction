import 'package:ai_auction/app/data/provider/validate.dart';
import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_auction/app/controller/login/login_controller.dart';


class Login extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          controller.title,
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: '이메일',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 0))),
                validator: (value) =>
                    CheckValidate().validateEmail(_emailFocus, value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordTextController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: '비밀번호',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 0))),
                validator: (value) =>
                    CheckValidate().validatePassword(_passwordFocus, value!),
              ),
              SizedBox(height: 16),
              MaterialButton(
                color: Colors.green,
                splashColor: Colors.white,
                height: 45,
                minWidth: Get.width / 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Login',
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.ApiLogin();
                  }
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.REGISTER);
                },
                child: Text('회원가입'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('비밀번호 찾기'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.naverLogin();
                },
                child: Text('네이버 로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
