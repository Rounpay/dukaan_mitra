import 'dart:async';
import 'dart:io';

import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

import '../theme/theme_colors.dart';
import '../widgets/rounded_button.dart';
import 'extensions.dart';

void showErrorDialog(
  String error, {
  String? msg,
  String positiveButtonName = 'OK',
  VoidCallback? onClose,
  VoidCallback? onAction,
}) {
  final context = Get.context;
  Get.defaultDialog(
    contentPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
    titlePadding: const EdgeInsets.only(top: 16, bottom: 8),
    title: 'Message',
    titleStyle: TextStyle(
      color: Colors.red[800],
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    middleText: msg != null ? '$error\n$msg' : error,
    textConfirm: onAction == null ? null : positiveButtonName,
    textCancel: onAction == null ? "OK" : 'Cancel',
    // cancelTextColor: context?.colorScheme.primary,
    // buttonColor: context?.colorScheme.primary,
    confirmTextColor: Colors.white,
    onConfirm: onAction == null
        ? null
        : () {
            Get.back();
            onAction.call();
          },
    onCancel: () {
      onClose?.call();
    },
  );
}

void showSuccessDialog(
  String data, {
  String? msg,
  String? buttonName,
  VoidCallback? onClose,
}) {
  Get.defaultDialog(
    barrierDismissible: onClose != null,
    contentPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
    titlePadding: const EdgeInsets.only(top: 16, bottom: 8),
    title: 'Message',
    titleStyle: TextStyle(
      color: Colors.green[800],
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    middleText: msg != null ? '$data\n$msg' : data,
    textConfirm: buttonName ?? '       OK       ',
    // buttonColor: Get.context?.colorScheme.primary,
    confirmTextColor: Colors.white,
    buttonColor: Colors.green[800],
    onConfirm: () {
      Get.back();
      onClose?.call();
    },
  );
}

String getErrorMsg(dynamic obj) {
  if (obj is GetHttpException) {
    return obj.message;
  } else if (obj is SocketException || obj is TimeoutException) {
    return "No internet connection or request timed out";
  } else if (obj is Response) {
    final status = obj.status;

    if (status.connectionError) {
      return "No internet connection";
    } else if (status.isUnauthorized) {
      return obj.statusText ?? "Unauthorized";
    } else if (status.isNotFound) {
      return "404 : Resource not found";
    } else if (status.isServerError) {
      return "${status.code} : Server error. Please try again later.";
    }
    try {
      return obj.body?["responseText"] ??
          obj.body?["message"] ??
          "${obj.statusCode ?? 'Unknown status'}\n${obj.statusText ?? ''}";
    } catch (e) {
      return "Some thing went wrong";
    }
  }

  return obj.toString() as String? ?? "Some thing went wrong";
}

void showErrorToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ThemeColors.colorRed,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showSuccessToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ThemeColors.colorGreen,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<T?> openBottomSheet<T>({
  required String title,
  required Widget body,
  VoidCallback? onClose,
  bool isDismissible = true,
  bool isScrollControlled = false,
  bool ignoreSafeArea = false,
}) {
  return Get.bottomSheet<T>(
    isScrollControlled: isScrollControlled,
    ignoreSafeArea: ignoreSafeArea,
    isDismissible: isDismissible,

    SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacing.h8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        title,
                        style: context.textStyle.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            if (onClose != null) {
                              onClose.call();
                            }
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.h8,
                Divider(
                  color: context.colorScheme.outline.withAlpha(60),
                  height: 0,
                ),
                Flexible(child: body),
              ],
            );
          },
        ),
      ),
    ),
  );
}

Future<void> showConfirmationDialog({
  String title = "Confirmation",
  String? message = "Are you sure you want to continue?",
  String negativeButton = "Cancel",
  String positiveButton = "Confirm",
  IconData icon = Icons.warning_rounded,
  Widget? body,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  return Get.dialog(
    Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(24),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Main Card
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.fromLTRB(20, 72, 20, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (message?.isNotEmpty == true) ...[
                  const SizedBox(height: 8),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],

                if (body != null) ...[Spacing.h16, body],

                Spacing.h16,
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        text: negativeButton,
                        backgroundColor: ThemeColors.colorRed,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Get.back();
                          onCancel?.call();
                        },
                      ),
                    ),
                    Spacing.w16,
                    Expanded(
                      child: RoundedButton(
                        text: positiveButton,
                        backgroundColor: ThemeColors.colorGreen,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Get.back();
                          onConfirm?.call();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Top Emoji + Wave Header
          Container(
            height: 88,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffF3D065),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
          ),

          // Emoji Avatar
          Container(
            margin: const EdgeInsets.only(top: 44),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.orange.shade600,
              child: Icon(icon, size: 32, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showCustomDialog({
  String title = "Confirmation",
  IconData icon = Icons.warning_rounded,
  required Widget body,
  VoidCallback? onConfirm,
  required BuildContext context,
}) {
  return Get.dialog(
    Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Main Card
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.fromLTRB(20, 72, 20, 24),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                body,
                Spacing.h16,
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        text: "Cancel",
                        backgroundColor: context.colorScheme.onErrorContainer,
                        foregroundColor: context.colorScheme.errorContainer,
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Spacing.w16,
                    Expanded(
                      child: RoundedButton(
                        text: "Confirm",
                        backgroundColor: context.colorScheme.inversePrimary,
                        foregroundColor: context.colorScheme.onSurface,
                        onPressed: () {
                          onConfirm?.call();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Top Emoji + Wave Header
          Container(
            height: 88,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colorScheme.tertiary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Align(
              alignment: AlignmentGeometry.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Agbalumo',
                    color: context.colorScheme.onTertiary,
                  ),
                ),
              ),
            ),
          ),

          // Emoji Avatar
          Container(
            margin: const EdgeInsets.only(top: 44),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: context.colorScheme.tertiaryContainer,
              child: Icon(
                icon,
                size: 32,
                color: context.colorScheme.onTertiaryContainer,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String getTimeZoneOffset() {
  final now = DateTime.now();
  final offset = now.timeZoneOffset;

  final utc =
      'UTC${offset.isNegative ? '-' : '+'}'
      '${offset.inHours.abs().toString().padLeft(2, '0')}:'
      '${(offset.inMinutes.abs() % 60).toString().padLeft(2, '0')}';

  return utc;
}

List<List<T>> divideListIntoChunks<T>(List<T> originalList, {int count = 19}) {
  List<List<T>> result = [];
  for (int i = 0; i < originalList.length; i += count) {
    int end = (i + count < originalList.length)
        ? i + count
        : originalList.length;
    result.add(originalList.sublist(i, end));
  }
  return result;
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
