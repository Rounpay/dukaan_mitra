import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/rounded_button.dart';

import '../utils/spacing.dart';

/// @Created by akash on 04-03-2025.
/// Know more about author at https://akash.cloudemy.in

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({
    super.key,
    required this.msg,
    this.onRetry,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.broken = false,
    this.bottomBar = false,
    this.asset = 'assets/svg/no_data.json',
  });

  final MainAxisSize mainAxisSize;
  final String msg;
  final String asset;
  final VoidCallback? onRetry;
  final bool broken;
  final bool bottomBar;

  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: [
          Lottie.asset(height: 60.0, width: 60.0, asset, fit: BoxFit.fill),
          Text(
            msg.tr,
            style: context.textStyle.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RoundedButton(onPressed: onRetry, text: "Retry".tr),
            ),
        ],
      ),
    );
  }
}
