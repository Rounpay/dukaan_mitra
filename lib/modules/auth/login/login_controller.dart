import 'package:flutter_demo/modules/auth/data/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/common_controller.dart';
import '../../../core/network/ui_state.dart';
import '../../../core/utils/extensions.dart';
import '../../../route/app_routes.dart';

/// @Created by akash on 02-03-2026.
/// Know more about author at https://akash.cloudemy.in

class LoginController extends GetxController{

  final AuthRepo repo;
  LoginController({required this.repo});

  final mobileNumberController = TextEditingController(text: "9044004486");
  final passwordController = TextEditingController(text: "Welcome@123");
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final rememberMe = false.obs;
  void toggleRemember(bool? value) {
    rememberMe.value = value ?? false;
  }
  void login() {
    if (formKey.currentState?.validate() == false) return;

    repo.login(
      {
        "MobileNo": mobileNumberController.text.trim(),
        "Password": passwordController.text.trim(),
      }, (state) {

        isLoading.value = state.isLoading;
        state.handleWithErrorBox(
            showLoader: false, (data) async {
          TextInput.finishAutofillContext();
          await CommonController.to.setUserData(data);
          Get.offAllNamed(AppRoutes.dashboard);
        });
      },
    );
  }

}