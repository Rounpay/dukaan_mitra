import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:flutter_demo/modules/purchase/data/purchase_data_res.dart';
import 'package:flutter_demo/modules/purchase/details/purchase_controller.dart';
import 'package:get/get.dart';

class PurchaseDetailsScreen extends GetView<PurchaseController> {
  const PurchaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Purchase Details")),
      body: SafeArea(
        child: Obx((){
          return controller.loanState.value.when(
              success: (data) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      productCard(context,data),
                      Spacing.h16,
                      Row(
                        children: [
                          _StatCard(
                            icon: Icons.percent,
                            label: 'Interest',
                            value:"${(data.info?.interestRate ?? 0).toStringAsFixed(0)}%",
                          ),
                          Spacing.w12,
                          _StatCard(
                            icon: Icons.calendar_today_outlined,
                            label: 'Daily EMI',
                            value:  "₹${(data.emiSchedule?.elementAt(0).emiAmount ?? 0).toStringAsFixed(0)}",

                          ),
                        ],
                      ),
                      Spacing.h24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EMI Schedule',
                            style: context.textStyle.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.onSurface,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: context.colorScheme.outlineVariant,
                              ),
                            ),
                            child: Text(
                              "${data.info?.numberOfInstallment ?? ''} Installments",
                              style: context.textStyle.labelSmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacing.h24,
                      ListView.builder(
                        itemCount: data.emiSchedule?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = data.emiSchedule![index];
                          return _buildEmiTile(context, index,item);
                        },
                      ),
                    ],
                  ),
                );
              },
              error: (error)=>ErrorTextWidget(msg: error),
              loading:()=> Loader(),
              none: ()=>SizedBox()
          );
        })
      ),
    );
  }

  Widget productCard(BuildContext context, PurchaseDataRes data,) {

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: ThemeColors.colorGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data.info?.loanStatus??'PAYMENT COMPLETED',
                        style: context.textStyle.labelSmall?.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Spacing.h12,
                    Text(
                      data.info?.productName??'Godrej 87 L Edge Cool Blast Desert Air Cooler',
                      style: context.textStyle.titleMedium,
                    ),
                  ],
                ),
              ),
              Spacing.w12,
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 100,
                  height: 100,
                  color: context.colorScheme.surfaceContainerHighest,
                  child: Image.network(
                    data.info?.productImage?.firstOrNull?.imagePath ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return    Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: context.colorScheme.outline,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
         Spacing.h24,
          Divider(height: 1, color: context.colorScheme.outlineVariant),
       Spacing.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LabelValue(
                label: 'PURCHASE AMOUNT',
                value:  "₹ ${data.info?.loanAmount ?? 15990}",
                isLarge: true,
              ),
              Container(

                width: 1,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: context.colorScheme.outlineVariant,
              ),
              _LabelValue(
                label: 'DURATION',
                value: "${data.info?.duration ?? ''} ${data.info?.durationType ?? ''}",
                isLarge: true,
                align: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmiTile(BuildContext context, int index, EmiSchedule item) {
    final bool isPaid = (item.statusName ?? '').trim().toLowerCase() == 'paid';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  "${index + 1}",
                  style: context.textStyle.labelSmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              Spacing.w16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "₹ ${item.emiAmount ?? 0}",
                      style: context.textStyle.titleSmall,
                    ),
                    Spacing.h4,
                    Text(
                      item.dueDate ?? '',
                      style: context.textStyle.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isPaid
                      ? Colors.green.shade100
                      : context.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.statusName ?? "",
                  style: context.textStyle.labelSmall?.copyWith(
                    color: isPaid
                        ? ThemeColors.colorGreen
                        : context.colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;
  final bool isLarge;
  final CrossAxisAlignment align;

  const _LabelValue({
    required this.label,
    required this.value,
    this.isLarge = false,
    this.align = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          label,
          style: context.textStyle.labelSmall?.copyWith(
            letterSpacing: 0.5,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        Spacing.h4,
        Text(
          value,
          style: isLarge
              ? context.textStyle.titleMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          )
              : context.textStyle.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14),

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: iconColor ?? context.colorScheme.primary,
              ),
            ),
            Spacing.h8,
            Text(
              label,
              style: context.textStyle.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            Spacing.h4,
            Text(
              value,
              style: context.textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}