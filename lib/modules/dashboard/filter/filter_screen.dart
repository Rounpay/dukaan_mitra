import 'package:flutter/material.dart';
import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:get/get.dart';

import '../../../../core/common_controller.dart';
import 'filter_controller.dart';

class FilterScreen extends GetView<FilterController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.colorScheme.surface,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: context.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Filters',
          style: context.textStyle.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            categorySection(context),
            divider(),
            priceSection(context),
            divider(),
            brandSection(context),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildFilterBottomBar(context),
    );
  }

  Widget categorySection(BuildContext context) {
    return Obx(() {
      return CommonController.to.categoryState.value.when(
        success: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: context.textStyle.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacing.h8,
              ...List.generate(data.length, (index) {
                final item = data[index];
                return Obx(
                      () => Row(
                    children: [
                      Checkbox(
                        value: controller.selectedCategoryId.value == item.categoryId,
                        onChanged: (_) {
                          controller.selectedCategoryId.value = item.categoryId;
                        },
                      ),
                      Spacing.w8,
                      Text(item.categoryName ?? ""),
                    ],
                  ),
                );
              }),
            ],
          );
        },
        error: (error) => ErrorTextWidget(msg: error),
        loading: () => Loader(),
        none: () => const SizedBox(),
      );
    });
  }

  Widget priceSection(BuildContext context) {
    return Obx(() {
      final min = controller.priceRange.value.start.round();
      final max = controller.priceRange.value.end.round();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price Range', style: context.textStyle.titleMedium),
          Spacing.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹$min', style: context.textStyle.bodyMedium),
              Text('₹$max', style: context.textStyle.bodyMedium),
            ],
          ),
          RangeSlider(
            values: controller.priceRange.value,
            min: 0,
            max: controller.maxPrice.value,
            onChanged: controller.updatePrice,
          ),
        ],
      );
    });
  }

  Widget brandSection(BuildContext context) {
    return Obx(() {
      return CommonController.to.brandState.value.when(
        success: (brand) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Brand', style: context.textStyle.titleMedium),
              Spacing.h8,
              ...List.generate(brand.length, (index) {
                final item = brand[index];
                return Obx(
                      () => Row(
                    children: [
                      Checkbox(
                        value: controller.selectedBrandId.contains(item.brandId),
                        onChanged: (_) {
                          controller.toggleBrand(item.brandId!);
                        },
                      ),
                      Spacing.w8,
                      Text(item.brandName ?? ""),
                    ],
                  ),
                );
              }),
            ],
          );
        },
        error: (error) => ErrorTextWidget(msg: error),
        loading: () => Loader(),
        none: () => const SizedBox(),
      );
    });
  }

  Widget _buildFilterBottomBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          final isActive =
              controller.selectedCategoryId.value != null ||
                  controller.selectedBrandId.isNotEmpty ||
                  controller.priceRange.value.start != 0 ||
                  controller.priceRange.value.end != 999999;
          return Row(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isActive
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: controller.resetFilters,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        side: BorderSide(
                            color: context.colorScheme.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: context.textStyle.bodyMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacing.w16,
                  ],
                )
                    : const SizedBox.shrink(),
              ),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(
                      result: {
                        "categoryId": controller.selectedCategoryId.value,
                        "brandId": controller.selectedBrandId,
                        "minPrice": controller.priceRange.value.start,
                        "maxPrice": controller.priceRange.value.end,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.bottomNavigationColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Show Results',
                    style: context.textStyle.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Divider(),
    );
  }
}