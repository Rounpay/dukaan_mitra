/*
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/widgets/floating_nav_bar.dart';
import 'package:get/get.dart';
import 'fi_dashboard_controller.dart';

class FiDashboardScreen extends GetView<FiDashboardController> {
  const FiDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Obx(() {
          return FloatingNavBar(
            selectedIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            icons: const [Icons.home_outlined, Icons.person_outline],
          );
        }),
      ),
    );
  }
}
*/
