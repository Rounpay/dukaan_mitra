import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/managers/storage_manager.dart';
import '../../route/app_routes.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  RxInt currentIndex = 0.obs;
  final List<String> titles = [
    "Easy Purchase",
    "Track Business"
  ];

  final List<String> subtitles = [
    "Manage all your payments easily in one place",
    "Keep track of your daily transactions",
  ];
  final List<String> images = [
    "assets/images/img.png",
    "assets/images/img.png",
  ];
  int get totalPages => titles.length;
  bool get isLastPage => currentIndex.value == totalPages - 1;
  String get buttonLabel => isLastPage ? "Get Started" : "Next";

  @override
  void onInit() {
    pageController = PageController();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.onInit();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void onNextPressed() {
    if (isLastPage) {
      StorageManager.saveBool(StorageManager.onboardingDone, true);
      Get.offAllNamed(AppRoutes.login);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void onSkipPressed() {
    StorageManager.saveBool(StorageManager.onboardingDone, true);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
