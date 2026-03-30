import 'package:flutter/material.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/floating_nav_bar.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(
            () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar:
      SafeArea(
        child: Obx((){return FloatingNavBar(
          selectedIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
        );})
      ),
    );
  }
  
}