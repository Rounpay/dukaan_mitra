import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'loader.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const Loader(),
      ),
    );
  }

  static void show() {
    if (Get.isDialogOpen != true && Get.context != null) {
      Get.dialog(const ProgressDialog(), barrierDismissible: false);
    }
  }

  static void hide() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
