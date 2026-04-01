import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:flutter_demo/route/app_routes.dart';
import 'package:get/get.dart';

import '../../../core/network/ui_state.dart';
import '../../../core/theme/theme_colors.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../purchase/details/purchase_details_screen.dart';
import '../dashboard_controller.dart';
import '../data/models/customer_portal_res.dart';

class PurchaseHistory extends GetView<DashboardController> {
  const PurchaseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        body: SafeArea(
          child: Obx(() {
            final state = controller.customerPortalState.value;
            return state.when(
              none: () => const SizedBox(),
              loading: () => const Center(child: Loader()),
              error: (msg) => Center(child: ErrorTextWidget(msg: msg)),
              success: (data) {
                final pending = data
                    .where(
                      (e) =>
                          PurchaseType.fromStatusId(e.loanStatusId) ==
                          PurchaseType.pending,
                    )
                    .toList();
                final completed = data
                    .where(
                      (e) =>
                          PurchaseType.fromStatusId(e.loanStatusId) ==
                          PurchaseType.completed,
                    )
                    .toList();
                final canceled = data
                    .where(
                      (e) =>
                          PurchaseType.fromStatusId(e.loanStatusId) ==
                          PurchaseType.canceled,
                    )
                    .toList();
          
                return TabBarView(
                  children: [
                    _buildList(context, pending, PurchaseType.pending),
                    _buildList(context, completed, PurchaseType.completed),
                    _buildList(context, canceled, PurchaseType.canceled),
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<CustomerPortalRes> items,
    PurchaseType type,
  ) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No Any ${type.name} orders',
          style: context.textStyle.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return purchaseCard(
          context: context,
          name: item.productName ?? '',
          loanId: item.loanId,
          price: 'Rs.${item.loanAmount ?? 0}',
          imageUrl: item.productImage?.firstOrNull?.imagePath ?? '',
          status: item.loanStatus ?? '',
          type: type,
        );
      },
    );
  }

  Widget purchaseCard({
    required BuildContext context,
    required int? loanId,
    required String name,
    required String price,
    required String imageUrl,
    required String status,
    required PurchaseType type,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  fit: BoxFit.cover,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _statusBadgeColor(context, type),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: context.textStyle.labelSmall?.copyWith(
                          color: _statusTextColor(context, type),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Spacing.h8,
                    Text(
                      name,
                      style: context.textStyle.titleSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    Spacing.h8,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Rs. ',
                            style: context.textStyle.bodySmall?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: price.replaceFirst('Rs.', '').trim(),
                            style: context.textStyle.titleMedium?.copyWith(
                              color: context.colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacing.h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (type != PurchaseType.canceled)
                RoundedButton(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.surface,
                  radius: 20,
                  enabled: true,
                  isLoading: false,
                  onPressed: () {
                    if (type == PurchaseType.completed) {
                     Get.toNamed(AppRoutes.purchaseDetailsScreen,arguments: {'loanId': loanId},
                     );
                    }
                  },
                  child: Text(
                    type == PurchaseType.pending ? 'Track' : 'View Details',
                    style: context.textStyle.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusBadgeColor(BuildContext context, PurchaseType type) {
    return switch (type) {
      PurchaseType.completed => ThemeColors.colorGreen.withOpacity(0.12),
      PurchaseType.canceled => ThemeColors.colorRed.withOpacity(0.12),
      PurchaseType.pending => context.colorScheme.surfaceContainerHighest,
    };
  }

  Color _statusTextColor(BuildContext context, PurchaseType type) {
    return switch (type) {
      PurchaseType.completed => ThemeColors.colorGreen,
      PurchaseType.canceled => ThemeColors.colorRed,
      PurchaseType.pending => context.colorScheme.onSurfaceVariant,
    };
  }
}

enum PurchaseType {
  completed(statusId: 9),
  canceled(statusId: 7),
  pending(statusId: null);
  final int? statusId;
  const PurchaseType({required this.statusId});
  static PurchaseType fromStatusId(int? id) {
    if (id == 8 || id == 9) return PurchaseType.completed;
    if (id == 6 || id== 7) return PurchaseType.canceled;
    return PurchaseType.pending;
  }
}
