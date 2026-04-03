import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:flutter_demo/core/widgets/rounded_button.dart';
import 'package:flutter_demo/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_demo/modules/field_inspector/fi_dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/icon_text_button.dart';
import '../../../core/widgets/image_picker_card.dart';
import '../../../core/widgets/text_field_with_label.dart';

class FiStatusScreen extends GetView<DashboardController> {
  const FiStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Inspector!",
              style: context.textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Here's your day overview",
              style: context.textStyle.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future(() {
              controller.fetchFiDashboard();
              controller.fetchAssignments();
            });
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                /*          Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.colorScheme.primary,
                        context.colorScheme.primary.withOpacity(0.75),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back",
                              style: context.textStyle.labelMedium?.copyWith(
                                color: context.colorScheme.onPrimary.withOpacity(
                                  0.85,
                                ),
                              ),
                            ),
                            Spacing.h4,
                            Text(
                              "Field Inspector",
                              style: context.textStyle.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            Spacing.h4,
                            Text(
                              "Here's your activity for today",
                              style: context.textStyle.bodySmall?.copyWith(
                                color: context.colorScheme.onPrimary.withOpacity(
                                  0.75,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),*/
                Obx(() {
                  return controller.fiDashboardState.value.when(
                    success: (data) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: buildStatsRow(
                                label: "Total ",
                                value: "${data.totalAssignments ?? 0}",
                                context,
                              ),
                            ),
                            Spacing.w12,
                            Expanded(
                              child: buildStatsRow(
                                label: "Assigned",
                                value: "${data.pendingInspections ?? 0}",
                                context,
                              ),
                            ),
                            Spacing.w12,
                            Expanded(
                              child: buildStatsRow(
                                label: "Completed",
                                value: "${data.completedReports ?? 0}",
                                context,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    error: (error) => ErrorTextWidget(
                      msg: error,
                      onRetry: controller.fetchFiDashboard,
                    ),
                    loading: () => Loader(),
                    none: () => const SizedBox(),
                  );
                }),

                Spacing.h8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(() {
                    return Row(
                      children: [
                        _tabItem(context, "All", 0),
                        Spacing.w8,
                        _tabItem(context, "Assigned", 1),
                        Spacing.w8,
                        _tabItem(context, "Completed", 2),
                      ],
                    );
                  }),
                ),
                Spacing.h8,
                Obx(() {
                  return controller.assignmentState.value.when(
                    success: (data) {
                      final filteredData = switch (controller
                          .selectedTab
                          .value) {
                        1 => data.where((e) => e.status.isAssigned).toList(),
                        2 => data.where((e) => e.status.isCompleted).toList(),
                        _ => data,
                      };
                      return ListView.builder(
                        itemCount: filteredData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = filteredData[index];
                          return fieldInspectorCard(
                            context,
                            statusLabel: item.status ?? "",
                            customerName: item.customerName ?? "",
                            phone: item.mobileNumber ?? "",
                            date: item.assignedDate != null
                                ? DateFormat(
                                    'dd MMM yyyy',
                                  ).format(DateTime.parse(item.assignedDate!))
                                : "",
                            productIcon: Icons.shopping_bag_outlined,
                            productName: item.productName ?? "",
                            price: "₹ ${item.mrp}",
                            location: item.address ?? "",
                            assignmentId: item.assignmentId ?? 0,
                          );
                        },
                      );
                    },
                    error: (error) => ErrorTextWidget(
                      msg: error,
                      onRetry: controller.fetchAssignments,
                    ),
                    loading: () => Center(child: Loader()),
                    none: () => const SizedBox(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStatsRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textStyle.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          Spacing.h4,
          Text(
            value,
            style: context.textStyle.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(BuildContext context, String label, int index) {
    final isActive = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? context.colorScheme.primary
                : context.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive
                  ? context.colorScheme.primary
                  : context.colorScheme.outlineVariant,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: context.textStyle.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isActive
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldInspectorCard(
    BuildContext context, {
    required String statusLabel,
    required int? assignmentId,
    required String customerName,
    required String phone,
    required String date,
    required IconData productIcon,
    required String productName,
    required String price,
    required String location,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusLabel.fiBgColor(context.colorScheme),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    statusLabel,
                    style: context.textStyle.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: statusLabel.fiTextColor(context.colorScheme),
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            Spacing.h12,
            Text(
              customerName,
              style: context.textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
            Spacing.h4,
            Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 13,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                Spacing.w4,
                Text(
                  phone,
                  style: context.textStyle.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            Spacing.h8,

            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    'Assigned Date',
                    style: context.textStyle.labelSmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: context.textStyle.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),

            Spacing.h12,

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.colorScheme.outlineVariant,
                    ),
                  ),
                  child: Icon(
                    productIcon,
                    size: 20,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                Spacing.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        softWrap: true,
                        style: context.textStyle.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      Spacing.h4,
                      Text(
                        price,
                        style: context.textStyle.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacing.h12,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: context.colorScheme.error,
                ),
                Spacing.w4,
                Text(
                  location,
                  softWrap: true,
                  style: context.textStyle.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Spacing.h12,
            Row(
              children: [
                Expanded(
                  child: IconTextButton(
                    label: "Call",
                    icon: Icons.call,
                    onPressed: () {
                      phone.call();
                    },
                  ),
                ),

                if (!statusLabel.isCompleted) ...[
                  Spacing.w8,
                  Expanded(
                    child: RoundedButton(
                      text: "Submit",
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.surface,
                      radius: 8,
                      onPressed: assignmentId != null
                          ? () => openSubmitBottomSheet(context, assignmentId)
                          : null,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openSubmitBottomSheet(BuildContext context, int assignmentId) {
    final selectedFile = Rx<File?>(null);
    controller.selectedImagePath.value = null;
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      Obx(() {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: context.colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Text(
                    "Submit Report",
                    style: context.textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacing.h16,
                  TextFieldWithLabel(
                    controller: controller.remarksController,
                    label: "Remarks",
                    hint: "Enter your remarks here...",
                    minLines: 3,
                    padding: EdgeInsets.zero,
                    textInputType: TextInputType.multiline,
                    borderRadius: 12,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  Spacing.h16,
                  SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: ImagePickerCard(
                      file: selectedFile.value,
                      onImageSelected: (file) {
                        selectedFile.value = file;
                        controller.selectedImagePath.value = file?.path;
                      },
                    ),
                  ),
                  Spacing.h16,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: Get.back,
                          child: Text("Cancel"),
                        ),
                      ),
                      Spacing.w12,
                      Expanded(
                        child: RoundedButton(
                          text: "Submit",
                          radius: 10,
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary,
                          onPressed: () =>
                              controller.submitReport(assignmentId),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
