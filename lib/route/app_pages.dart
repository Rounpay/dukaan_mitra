import 'package:flutter_demo/modules/auth/signup/signup_screen.dart';
import 'package:get/get.dart';

import '../modules/auth/data/auth_repo.dart';
import '../modules/auth/login/login_controller.dart';
import '../modules/auth/login/login_screen.dart';
import '../modules/auth/signup/signup_controller.dart';
import '../modules/dashboard/dashboard_controller.dart';
import '../modules/dashboard/dashboard_screen.dart';
import '../modules/onboarding/onboarding_screen.dart';
import 'app_routes.dart';

/// @Created by akash on 08-12-2025.
/// Know more about author at https://akash.cloudemy.in

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
          Get.lazyPut(() => AuthRepo());
        Get.lazyPut(() => LoginController(repo: Get.find()));
      }),
    ),
    GetPage(
      name: AppRoutes.signupScreen,
      page: () => SignupScreen(),
      binding: BindingsBuilder(() {
          Get.lazyPut(() => AuthRepo());
        Get.lazyPut(() => SignupController(repo: Get.find()));
      }),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardScreen(),
      binding: BindingsBuilder(() {
       //  Get.lazyPut(() => DashboardRepo());
        Get.lazyPut(() => DashboardController(/*repo: Get.find()*/));
      }),
    ),
  ];
}
