import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../core/widgets/search_text_field.dart';
import '../dashboard/dashboard_controller.dart';

class HomeScreen extends GetView<DashboardController> {
  HomeScreen({super.key});

  final categories = [
    (label: 'Phones', icon: Icons.smartphone, color: Colors.blue),
    (label: 'Audio', icon: Icons.headphones, color: Colors.purple),
    (label: 'Cases', icon: Icons.phone_android, color: Colors.green),
    (label: 'Storage', icon: Icons.memory, color: Colors.red),
    (label: 'Other', icon: Icons.more_horiz, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bottomNavigationColor,
        elevation: 0,
        toolbarHeight: 190,
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
              onChanged: (value) {},
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Featured',
                    style: context.textStyle.titleMedium?.copyWith(
                      color: context.colorScheme.surface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      _actionButton(context, icon: Icons.sort, label: 'Sort'),
                      const SizedBox(width: 8),
                      _actionButton(context, icon: Icons.tune, label: 'Filter'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categories.length,
                  separatorBuilder: (_, _) => Spacing.w12,
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    return circleIconItem(
                      context,
                      icon: item.icon,
                      label: item.label,
                      iconColor: item.color,
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Latest Promotion",
                style: context.textStyle.titleMedium,
              ),
            ),

            /*  Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: controller.promoImages.length,
                    onPageChanged: (index) => controller.currentPage.value = index,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            controller.promoImages[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.promoImages.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.currentPage.value == index ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),*/
            Column(
              children: [
                CarouselSlider(
                  items: controller.promoImages.map((image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.currentPage.value == index ? 20 : 8,
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
            Spacing.h32,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "View all Promotion",
                          style: context.textStyle.bodySmall?.copyWith(
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacing.w4,
                        Icon(
                          Icons.arrow_forward_ios,
                          color: context.colorScheme.onSurface,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacing.h32,
            MasonryGridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
              ),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildStaticCard(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Container(
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
    );
  }

  Widget circleIconItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color iconColor,
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
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
          Spacing.h8,
          Text(label, style: context.textStyle.bodySmall),
        ],
      ),
    );
  }

  Widget _buildStaticCard(BuildContext context) {
    return Container(
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
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  "assets/images/handsome.jpg",
                  fit: BoxFit.cover,
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
                  "Product Name Example",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacing.h4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category",
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
                Spacing.h4,
               Text(
                 "Rs 14000",style: context.textStyle.bodyMedium?.copyWith(
                   fontWeight: FontWeight.w600,
                 ),
               ),
                Spacing.h4


              ],
            ),
          ),
        ],
      ),
    );
  }
}
