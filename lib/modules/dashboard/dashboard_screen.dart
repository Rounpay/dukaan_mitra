import 'package:flutter/material.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/floating_nav_bar.dart';
import 'package:flutter_demo/modules/dashboard/profile/profile_details_screen.dart';
import 'package:flutter_demo/modules/dashboard/purchase/purchase_history.dart';
import 'package:get/get.dart';
import '../../core/common_controller.dart';
import '../field_inspector/ fi_status/fi_status_screen.dart';
import 'dashboard_controller.dart';
import 'home/home_screen.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {

    final roleId = CommonController.to.userData.value?.roleId;
    final pages = roleId.isFieldInspector
        ? [
          FiStatusScreen(),
          ProfileDetailsScreen()
    ]
        : [
          HomeScreen(),
          PurchaseHistory(),
          ProfileDetailsScreen()
    ];

    final icons = roleId.isFieldInspector
        ? const [
          Icons.home_outlined,
          Icons.person_outline
    ]
        : const [
            Icons.home_outlined,
            Icons.shopping_bag_outlined,
            Icons.person_outline,
          ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(
        () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      bottomNavigationBar: SafeArea(
        child: Obx(() {
          return FloatingNavBar(
            selectedIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            icons: icons,
          );
        }),
      ),
    );
  }
}
