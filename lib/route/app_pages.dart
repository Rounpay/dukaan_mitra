import 'package:flutter_demo/modules/auth/signup/signup_screen.dart';
import 'package:flutter_demo/modules/product/data/repo/product_detail_repo.dart';
import 'package:flutter_demo/modules/product/details/product_details_controller.dart';
import 'package:flutter_demo/modules/product/details/product_details_screen.dart';
import 'package:flutter_demo/modules/profile/data/repo/profile_repo.dart';
import 'package:flutter_demo/modules/purchase/details/purchase_controller.dart';
import 'package:get/get.dart';

import '../modules/auth/data/auth_repo.dart';
import '../modules/auth/login/login_controller.dart';
import '../modules/auth/login/login_screen.dart';
import '../modules/auth/signup/signup_controller.dart';
import '../modules/dashboard/dashboard_controller.dart';
import '../modules/dashboard/dashboard_screen.dart';
import '../modules/dashboard/filter/data/filter_repo.dart';
import '../modules/dashboard/filter/filter_controller.dart';
import '../modules/dashboard/filter/filter_screen.dart';

import '../modules/onboarding/onboarding_screen.dart';
import '../modules/profile/update/update_profile_controller.dart';
import '../modules/profile/update/update_profile_screen.dart';
import '../modules/purchase/data/purchase_repo.dart';
import '../modules/purchase/details/purchase_details_screen.dart';
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
      name: AppRoutes.updateProfile,
      page: () => UpdateProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileRepo());
        Get.lazyPut(() => UpdateProfileController(repo: Get.find()));
      }),
    ),

    GetPage(
      name: AppRoutes.filterScreen,
      page: () => FilterScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FilterRepo());
        Get.lazyPut(() => FilterController(repo: Get.find()));
      }),
    ),

    GetPage(
      name: AppRoutes.productDetailsScreen,
      page: () => ProductDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProductDetailsRepo());
        Get.lazyPut(() => ProductDetailsController(repo: Get.find()));
      }),
    ),

    GetPage(
      name: AppRoutes.purchaseDetailsScreen,
      page: () => PurchaseDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PurchaseRepo());
        Get.lazyPut(() => PurchaseController(repo: Get.find()));
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
