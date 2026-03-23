import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/widgets/rounded_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String primaryBtnText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback? onCancelPressed;

  const CustomDialog({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.primaryBtnText,
    required this.onPrimaryPressed,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 36),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(24, 52, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.textStyle.titleMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacing.h24,
                onCancelPressed != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: onCancelPressed,
                            child: Text(
                              'Cancel',
                              style: context.textStyle.bodyMedium?.copyWith(
                                color: context.colorScheme.outline,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ),
                          Spacing.w16,
                          _primaryButton(),
                        ],
                      )
                    : Center(child: _primaryButton()),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(child: Icon(icon, color: iconColor, size: 36)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton() {
    return RoundedButton(
      text: primaryBtnText,
      onPressed: onPrimaryPressed,
      backgroundColor: iconColor,
      foregroundColor: Colors.white,
      radius: 12,
    );
  }
}
