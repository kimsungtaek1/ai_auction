import 'package:ai_auction/app/data/provider/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_auction/app/controller/register/register_controller.dart';

class Register extends GetView<RegisterController> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _nameFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _phoneFocus = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.title,
          ),
          elevation: 0,
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
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
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0))),
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
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0))),
                    validator: (value) => CheckValidate()
                        .validatePassword(_passwordFocus, value!),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.password2TextController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: '비밀번호확인',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0))),
                    validator: (value) => CheckValidate().validatePasswordsame(
                        _passwordFocus,
                        value!,
                        controller.passwordTextController.text),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.nameTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: '이름',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0))),
                    validator: (value) =>
                        CheckValidate().validateName(_nameFocus, value!),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.phoneTextController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: '전화번호',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0))),
                    validator: (value) =>
                        CheckValidate().validatePhone(_phoneFocus, value!),
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
                      '가입 및 로그인',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.ApiRegister();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
