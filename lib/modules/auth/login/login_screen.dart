import 'package:flutter/gestures.dart';
import 'package:flutter_demo/core/widgets/text_field_with_label.dart';
import 'package:flutter_demo/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../route/app_routes.dart';

/// @Created by akash on 18-02-2026.
/// Know more about author at https://akash.cloudemy.in

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/circle_scatter_haikei.svg',
            color: context.colorScheme.primaryContainer.withOpacityX(.1),
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacing.h48,
                  SafeArea(
                    bottom: false,
                    child: Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: context.textStyle.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacing.h8,
                  Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: context.textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacing.h4,
                  Text(
                    'Enter your mobile number and password\nto continue',
                    textAlign: TextAlign.center,
                    style: context.textStyle.bodySmall,
                  ),
                  Spacing.h48,
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Mobile Number',
                        textAlign: TextAlign.start,
                        style: context.textStyle.bodyMedium,
                      ),
                    ),
                  ),
                  TextFieldWithLabel(
                    controller: controller.mobileNumberController,
                    textInputType: TextInputType.text,
                    autofillHints: [AutofillHints.username],
                    hint: "Enter Your mobile number",
                    validator: (value) => (value?.length ?? 0) < 4
                        ? "Enter Your mobile number"
                        : null,
                    prefix: Icon(
                      Icons.person_outline,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Password',
                        textAlign: TextAlign.start,
                        style: context.textStyle.bodyMedium,
                      ),
                    ),
                  ),
                  PassWordTextFormFieldWithLabel(
                    controller: controller.passwordController,
                    hint: "Enter Your Password",
                    autofillHints: [AutofillHints.password],
                    textInputFormatter: [LengthLimitingTextInputFormatter(16)],
                    validator: (value) =>
                        value?.isEmpty == true ? "Password is required" : null,
                  ),
                  Row(
                    children: [
                      Spacing.w8,
                      Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: controller.toggleRemember,
                      )),
                      Text("Remember me", style: context.textStyle.bodyMedium),
                      Spacer(),
                     /* TextButton(
                        onPressed: () {},
                        child: Text("Forgot Password?"),
                      ),*/
                      Spacing.w8,
                    ],
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(
                        () => RoundedButton(
                          text: "Sign In",
                          isLoading: controller.isLoading.value,
                          width: double.infinity,
                          onPressed: controller.login,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Don’t have an account? ",
                          style: context.textStyle.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: context.textStyle.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.signupScreen);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
