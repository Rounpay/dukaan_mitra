import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/modules/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../core/utils/spacing.dart';
import '../../core/widgets/rounded_button.dart';

class PurchaseHistory extends GetView<DashboardController> {
  const PurchaseHistory({super.key});

  static const List<Map<String, String>> completedItems = [
    {
      'name': 'Apple iPhone 16 Pro Max \n 256GB',
      'price': 'Rs.389,900.00',
      'image': 'https://m.media-amazon.com/images/I/61bK6PMOC3L._AC_SX200_.jpg',
    },
    {
      'name': 'Apple AirPods Max 2024',
      'price': 'Rs.199,900.00',
      'image': 'https://m.media-amazon.com/images/I/81xSSqfBFML._AC_SX200_.jpg',
    },
    {
      'name': 'Apple Mac Mini M2 Chip \n 8GB RAM 256GB',
      'price': 'Rs.189,900.00',
      'image': 'https://m.media-amazon.com/images/I/61a2y2WCUGL._AC_SX200_.jpg',
    },
    {
      'name': 'Spigen Galaxy Z Flip \n 4 Air Skin Case Glitter',
      'price': 'Rs.18,900.00',
      'image': 'https://m.media-amazon.com/images/I/71Q4j4z4+ML._AC_SX200_.jpg',
    },
    {
      'name': 'Spigen Ultra Hybrid 14 \n Pro Max Case',
      'price': 'Rs.14,900.00',
      'image': 'https://m.media-amazon.com/images/I/61c1ZUKQWLL._AC_SX200_.jpg',
    },
  ];

  static const List<Map<String, String>> canceledItems = [
    {
      'name': 'Samsung Galaxy A55 Tempered Glass',
      'price': 'Rs.1,500.00',
      'image':
          'https://m.media-amazon.com/images/I/51bCa8FEJMLL._AC_SX200_.jpg',
    },
    {
      'name': 'Spigen Ultra Hybrid 14 Pro Max Case',
      'price': 'Rs.14,900.00',
      'image': 'https://m.media-amazon.com/images/I/61c1ZUKQWLL._AC_SX200_.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceContainerLow,
        appBar: AppBar(
          backgroundColor: context.colorScheme.surface,
          elevation: 0.5,
          centerTitle: true,
          title: Text('Purchase History', style: context.textStyle.titleLarge),
          bottom: TabBar(
            labelColor: context.colorScheme.onSurface,
            unselectedLabelColor: context.colorScheme.onSurfaceVariant,
            labelStyle: context.textStyle.titleMedium,
            unselectedLabelStyle: context.textStyle.bodyMedium,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.5,
                color: context.colorScheme.primary,
              ),
            ),
            tabs: const [
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _buildList(items: completedItems, isCanceled: false),
            _buildList(items: canceledItems, isCanceled: true),
          ],
        ),
      ),
    );
  }

  Widget _buildList({
    required List<Map<String, String>> items,
    required bool isCanceled,
  }) {
    return ListView.builder(
      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final Map<String, String> item = items[index];
        return PurchaseCard(
          name: item['name'] ?? '',
          price: item['price'] ?? '',
          imageUrl: item['image'] ?? '',
          isCanceled: isCanceled,
        );
      },
    );
  }
}

class PurchaseCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;
  final bool isCanceled;

  const PurchaseCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isCanceled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: 12),
      padding:  EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 8,
            offset:  Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 72,
                  height: 72,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      color: context.colorScheme.outline,
                      size: 28,
                    ),
                  ),
                ),
              ),
              Spacing.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.textStyle.titleSmall?.copyWith(
                        color: context.colorScheme.onSurface,

                      ),
                    ),
                    Spacing.h8,
                    Text(
                      price,
                      style: context.textStyle.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacing.h12,
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.surface,
              radius: 20,
              enabled: !isCanceled,
              isLoading: false,
              onPressed: () {},
              child: Text(
                isCanceled ? 'Re-Order' : 'Review',
                style: context.textStyle.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
