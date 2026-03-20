import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

/// @Created by akash on 06-01-2026.
/// Know more about author at https://akash.cloudemy.in

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.icon, this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(label,overflow: TextOverflow.ellipsis,maxLines: 1,),
      icon: Icon(icon),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          (color??ThemeColors.colorIndigo).withAlpha(50),
        ),
        foregroundColor: WidgetStatePropertyAll(color??ThemeColors.colorIndigo),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
      ),
    );
  }
}
