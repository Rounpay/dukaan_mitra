import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/spacing.dart';
import '../../core/widgets/page_dots_indicator.dart';
import '../../core/widgets/rounded_button.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.totalPages,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      controller.images[index],
                      height: 180,
                    ),
                  Spacing.h24,
                    Text(
                      controller.titles[index],
                      textAlign: TextAlign.center,
                      style: context.textStyle.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacing.h12,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        controller.subtitles[index],
                        textAlign: TextAlign.center,
                        style: context.textStyle.bodyMedium,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Obx(
                () => PageDotsIndicator(
              count: controller.totalPages,
              selectedIndex: controller.currentIndex.value,
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(

                    () => RoundedButton(
                      radius: 10,
                  text: controller.buttonLabel,
                  width: double.infinity,
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.surface,
                  onPressed: controller.onNextPressed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}