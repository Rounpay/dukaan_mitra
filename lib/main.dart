import 'package:flutter_demo/route/app_pages.dart';
import 'package:flutter_demo/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/common_controller.dart';
import 'core/managers/storage_manager.dart';
import 'core/network/api_client.dart';
import 'core/theme/theme.dart';
void main() async {
  await StorageManager.init();
  Get.lazyPut(() => CommonController(), fenix: true);
  Get.lazyPut(() => ApiClient(), fenix: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final isLoggedIn = CommonController.to.loadLoginUserData();
    TextTheme textTheme = createTextTheme(context, "ABeeZee", "Agbalumo");
    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'Dukaan Mitra',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: isLoggedIn ? AppRoutes.dashboard : AppRoutes.onboarding,
    );
  }
}

