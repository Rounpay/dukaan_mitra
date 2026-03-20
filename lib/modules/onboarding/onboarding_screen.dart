import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/rounded_button.dart';
import 'package:flutter_demo/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/utils/spacing.dart';
import '../../core/widgets/page_dots_indicator.dart';

/// @Created by akash on 18-02-2026.
/// Know more about author at https://akash.cloudemy.in

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: SvgPicture.asset("assets/svg/flutter_logo.svg", width: 200)),
          Text(
            "Trading Made Easy",
            textAlign: TextAlign.center,
            style: context.textStyle.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
          Spacing.h16,
          PageDotsIndicator(count: 5, selectedIndex: 3),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundedButton(
                text: "Get Started",
                width: double.infinity,
                onPressed: () => Get.offAllNamed(AppRoutes.login),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
