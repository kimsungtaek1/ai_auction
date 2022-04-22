import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/controller/login/login_controller.dart';
import 'app/controller/root/root_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/ui/android/root/root.dart';
import 'app/ui/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Root(),
      initialBinding: BindingsBuilder(() {
        //Get.put을 사용하여 컨트롤러를 추가하면, 해당 코드가 실행되는 시점에
        // 컨트롤러가 메모리에 생성되게 됩니다.
        // 하지만 다음과 같이 Get.lazyPut을 사용하면,
        // 실제로 컨트롤러를 사용하는 시점에 컨트롤러가 메모리에 생성되게 됩니다.
        Get.put(RootController());
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    );
  }
}
