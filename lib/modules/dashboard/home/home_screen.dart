import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:flutter_demo/modules/dashboard/data/models/product_response.dart';
import 'package:flutter_demo/route/app_routes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../core/widgets/search_text_field.dart';
import '../dashboard_controller.dart';

class HomeScreen extends GetView<DashboardController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bottomNavigationColor,
        elevation: 0,
        toolbarHeight: 140,
        flexibleSpace: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/dunka.png", height: 50, width: 50),
                  Spacing.w8,
                  Text(
                    'Macktech Mobiles',
                    style: context.textStyle.titleLarge?.copyWith(
                      color: context.colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SearchTextField(
              controller: controller.searchController,
              hint: "Search any Product..",
              onChanged: (value) {
                controller.searchProducts(value ?? '');
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        return controller.productState.value.when(
          success: (list) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchProducts();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: SizedBox(
                          height: 90,
                          child: Obx(() {
                            return controller.categoryState.value.when(
                              success: (data) {
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  itemCount: data.length,
                                  separatorBuilder: (_, _) => Spacing.w12,
                                  itemBuilder: (context, index) {
                                    final item = data[index];
                                    return circleIconItem(
                                      context,
                                      imagePath: item.imagePath ?? "",
                                      label: item.categoryName ?? "",
                                    );
                                  },
                                );
                              },
                              error: (error) => ErrorTextWidget(msg: error),
                              loading: () => Loader(),
                              none: () => SizedBox(),
                            );
                          }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Latest Promotion",
                          style: context.textStyle.titleMedium,
                        ),
                      ),
                      Column(
                        children: [
                          CarouselSlider(
                            items: controller.promoImages.map((image) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 200,
                              viewportFraction: 0.9,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(
                                milliseconds: 800,
                              ),
                              onPageChanged: (index, reason) {
                                controller.currentPage.value = index;
                              },
                            ),
                          ),
                          Spacing.h8,
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                controller.promoImages.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: controller.currentPage.value == index
                                      ? 20
                                      : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: controller.currentPage.value == index
                                        ? context.colorScheme.primary
                                        : Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacing.h16,

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Featured',
                              style: context.textStyle.titleMedium?.copyWith(
                                color: context.colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                _actionButton(
                                  context,
                                  icon: Icons.sort,
                                  label: 'Sort',
                                  onTap: () {
                                    sortBottomSheet(context);
                                  },
                                ),
                                const SizedBox(width: 8),
                                _actionButton(
                                  context,
                                  icon: Icons.tune,
                                  label: 'Filter',
                                  onTap: () {
                                    Get.toNamed(AppRoutes.filterScreen)?.then((
                                      result,
                                    ) {
                                      if (result != null) {
                                        controller.fetchFilteredProducts(
                                          categoryId: result["categoryId"],
                                          brandId: result["brandId"],
                                          minPrice: result["minPrice"],
                                          maxPrice: result["maxPrice"],
                                        );
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacing.h12,
                      Obx(() {
                        return controller.productState.value.when(
                          success: (product) {
                            if (product.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/empty_box.png",
                                        height: 140,
                                      ),
                                      Text(
                                        "No Products Found",
                                        style: context.textStyle.titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),

                                      /*   Spacing.h4,
                              Text(
                                "We couldn't find any items.\nTry adjusting your filters.",
                                textAlign: TextAlign.center,
                                style: context.textStyle.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),*/
                                    ],
                                  ),
                                ),
                              );
                            }

                            return MasonryGridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 220,
                                  ),
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemCount: product.length,
                              itemBuilder: (context, index) {
                                final item = product[index];
                                return _buildStaticCard(context, item);
                              },
                            );
                          },
                          error: (error) => ErrorTextWidget(msg: error),
                          loading: () => Loader(),
                          none: () => SizedBox(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error) => ErrorTextWidget(msg: error),
          loading: () => Loader(),
          none: () => SizedBox(),
        );
      }),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: context.colorScheme.onSurface, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: context.textStyle.bodySmall?.copyWith(
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleIconItem(
      BuildContext context, {
        required String? imagePath,
        required String label,
        double size = 60,
        double iconSize = 28,
        VoidCallback? onTap,
      }) {

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: imagePath != null && imagePath.isNotEmpty
                  ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return Icon(
                    Icons.category,
                    size: iconSize,
                    color: context.colorScheme.onSurfaceVariant,
                  );
                },
              )
                  : Icon(
                Icons.category,
                size: iconSize,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Spacing.h8,
          Text(
            label,
            style: context.textStyle.bodySmall,
          ),
        ],
      ),
    );
  }
  Widget _buildStaticCard(BuildContext context, ProductResponse item) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.productDetailsScreen,
          arguments: {'productId': item.productId},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    item.images?.isNotEmpty == true
                        ? item.images![0].imagePath ?? ''
                        : '',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return /*Image.asset(
                        "assets/images/dunka.png",
                        fit: BoxFit.cover,
                      );*/ Image.asset("assets/images/Image_not_available.png");
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? "",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyle.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacing.h8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.brandName ?? "",
                        style: context.textStyle.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 18,
                        color: context.colorScheme.onSurface,
                      ),
                    ],
                  ),
                  Spacing.h8,
                  Row(
                    children: [
                      Text(
                        "₹ ${item.offerPrice != null && item.offerPrice! < (item.mrp ?? 0)
                            ? item.offerPrice
                            : item.mrp ?? 0}",
                        style: context.textStyle.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Spacing.w8,
                      if (item.offerPrice != null &&
                          item.mrp != null &&
                          item.offerPrice! < item.mrp!)
                        Text(
                          "₹ ${item.mrp}",
                          style: context.textStyle.bodySmall?.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  Spacing.h4,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sortBottomSheet(BuildContext context) {
    RxInt selectedSort = 0.obs;
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: context.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Text(
                "SORT BY",
                style: context.textStyle.labelMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              Divider(height: 1, color: context.colorScheme.outlineVariant),
              Spacing.h16,
              Column(
                children: [
                  _sortOption(context, "All", 1, selectedSort),
                  _sortOption(context, "A-Z", 2, selectedSort),
                  _sortOption(context, "Price — High to Low", 3, selectedSort),
                  _sortOption(context, "Price — Low to High", 4, selectedSort),
                ],
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _sortOption(
    BuildContext context,
    String title,
    int index,
    RxInt selectedSort,
  ) {
    return Obx(
      () => InkWell(
        onTap: () {
          selectedSort.value = index;
          Get.back(result: index);
        },
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textStyle.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),

            Radio<int>(
              value: index,
              groupValue: selectedSort.value,
              activeColor: context.colorScheme.primary,
              onChanged: (value) {
                selectedSort.value = value!;
                Get.back(result: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
