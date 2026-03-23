import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter/material.dart';

/// @Created by akash on 24-12-2025.
/// Know more about author at https://akash.cloudemy.in

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.width,
    this.isLoading = false,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.radius,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final double? width;
  final double? radius;
  final bool isLoading;
  final bool enabled;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? colors.primaryContainer,
          ),
          foregroundColor: WidgetStatePropertyAll(
            foregroundColor ?? colors.onPrimaryContainer,
          ),
          shape: radius == null
              ? null
              : WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!),
            ),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(
          color: foregroundColor ?? colors.onPrimaryContainer,
          constraints: const BoxConstraints(minHeight: 22, minWidth: 22),
        )
            : child ??
            Text(
              text ?? '',
              style: context.textStyle.labelLarge?.copyWith(
                color: foregroundColor ??
                    colors.onPrimaryContainer,
              ),
            ),
      ),
    );
  }
}