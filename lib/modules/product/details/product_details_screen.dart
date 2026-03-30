import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/modules/product/details/product_details_controller.dart';
import 'package:get/get.dart';
import '../../../core/network/ui_state.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/theme/theme_colors.dart';
import '../../../core/widgets/loader.dart';
import '../../../core/widgets/rounded_button.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLow,
      appBar: AppBar(title: const Text("Product Details"), centerTitle: true),
      body: SingleChildScrollView(
        child: Obx(() {
          return controller.productDetailsState.value.when(
            success: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(context),
                  Spacing.h12,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.brandName ?? 'No Brand',
                          style: context.textStyle.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: ThemeColors.colorGold,
                            ),
                            Spacing.w4,
                            Text('4.8', style: context.textStyle.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Spacing.h8,

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      data.title ??"No Product Name",
                      style: context.textStyle.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Spacing.h12,

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          "₹ ${data.offerPrice != null && data.offerPrice! < (data.mrp ?? 0) ? data.offerPrice : data.mrp ?? 0}",
                          style: context.textStyle.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacing.w8,

                        if (data.offerPrice != null &&
                            data.mrp != null &&
                            data.offerPrice! < data.mrp!)
                          Text(
                            "₹ ${data.mrp}",
                            style: context.textStyle.bodyMedium?.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Spacing.h16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildIconInfoCard(
                            context,
                            icon: Icons.calendar_today_outlined,
                            label: 'DAILY EMI',
                            value: '₹ ${data.dailyEMI ?? 0}',
                          ),
                        ),
                        Spacing.w12,
                        Expanded(
                          child: _buildIconInfoCard(
                            context,
                            icon: Icons.access_time_outlined,
                            label: 'DURATION',
                            value: '${data.maxDuration ?? 0} Months',
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacing.h12,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: context.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: const Icon(
                              Icons.receipt_long_outlined,
                              size: 20,
                              color: Color(0xFF0D2353),
                            ),
                          ),
                          Spacing.w12,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PROCESSING FEE',
                                style: context.textStyle.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Spacing.h4,
                              Text(
                                '₹ ${data.processingFee ?? 0}',
                                style: context.textStyle.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Icon(
                            Icons.info_outline,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Spacing.h12,

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TOTAL PAYABLE AMOUNT',
                                  style: context.textStyle.labelSmall?.copyWith(
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '₹ ${data.finalAmount ?? 0}',
                                      style: context.textStyle.headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'INCL. TAXES',
                                      style: context.textStyle.labelSmall
                                          ?.copyWith(
                                            color: context
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colorScheme.outlineVariant,
                              ),
                            ),
                            child: Icon(
                              Icons.verified_outlined,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error) => ErrorTextWidget(msg: error),
            loading: () => SizedBox(),
            none: () => SizedBox(),
          );
        }),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Obx(() {
      final state = controller.productDetailsState.value;
      return state.when(
        loading: () => Center(child: Loader()),
        error: (e) => ErrorTextWidget(msg: e),
        none: () => SizedBox(),
        success: (data) {
          final images = data.images ?? [];
          if (images.isEmpty) {
            return Center(
              child: Image.asset("assets/images/Image_not_available.png"),
            );
          }
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  final img = images[index].imagePath ?? '';
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        img,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (_, _, _) => Image.asset(
                          "assets/images/Image_not_available.png",
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 340,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    controller.updateIndex(index);
                  },
                ),
              ),

              Spacing.h12,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: controller.currentIndex.value == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == index
                            ? ThemeColors.colorGold
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Obx(() {
          return RoundedButton(
            onPressed: controller.purchaseApply,
            isLoading: controller.loanApplyState.value.isLoading,
            text: 'Buy Now',
            radius: 10,
            backgroundColor: ThemeColors.colorOrange,
            foregroundColor: Colors.white,
          );
        }),
      ),
    );
  }

  Widget _buildIconInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colorScheme.outline.withOpacity(0.4),
              ),
            ),
            child: Icon(icon, size: 16, color: context.colorScheme.primary),
          ),
          const SizedBox(height: 14),
          Text(
            label,
            style: context.textStyle.labelSmall?.copyWith(
              fontSize: 11,
              color: context.colorScheme.onSurface.withOpacity(0.6),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.textStyle.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
