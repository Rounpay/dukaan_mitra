/// @Created by akash on 29-12-2025.
/// Know more about author at https://akash.cloudemy.in
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
enum SortOrder {
  createdDesc,
  createdAsc,
  deliveryDesc,
  deliveryAsc,
}

class SortingButton extends StatelessWidget{

  final SortOrder selectedValue;
  final ValueChanged<SortOrder> onChanged;
  final IconData icon;
  final bool isExpanded;

  const SortingButton({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    this.icon = Icons.sort,
    required this.isExpanded,
  });


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortOrder>(
      borderRadius: BorderRadius.circular(24),
      onSelected: (value) {
        onChanged(value);
      },
      itemBuilder: (context) {
        return SortOrder.values.map((value) {
          return PopupMenuItem<SortOrder>(
            value: value,
            child: Row(
              children: [
                Text(value.label),
                if (value == selectedValue) const SizedBox(width: 8),
                if (value == selectedValue) const Icon(Icons.check, size: 18),
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.colorScheme.outlineVariant.withAlpha(60),
          ),
          color: context.colorScheme.surfaceContainerLowest,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: isExpanded
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 4),
                        Text(
                          selectedValue.label,
                          style: context.textStyle.titleSmall?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
