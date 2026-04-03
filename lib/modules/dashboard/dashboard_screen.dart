import 'package:flutter/material.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/floating_nav_bar.dart';
import 'package:flutter_demo/modules/dashboard/profile/profile_details_screen.dart';
import 'package:flutter_demo/modules/dashboard/purchase/purchase_history.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';
import 'home/home_screen.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // 👈 add this
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [HomeScreen(),PurchaseHistory(),ProfileDetailsScreen() ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Obx(() {
          return FloatingNavBar(
            selectedIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            icons: const [
              Icons.home_outlined,
              Icons.shopping_bag_outlined,
              Icons.person_outline,
            ],
          );
        }),
      ),
    );
  }
}
