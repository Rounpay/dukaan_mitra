
import 'package:flutter/material.dart';

import '../utils/extensions.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpacing;

  const DottedDivider({
    super.key,
    this.height = 1,
    this.color = Colors.grey,
    this.dashWidth = 4,
    this.dashSpacing = 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _DashedLinePainter(
          color: color,
          dashWidth: dashWidth,
          dashSpacing: dashSpacing,
        ),
      ),
    );
  }
}
class DottedTextDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpacing;
  final String? text;

  const DottedTextDivider({
    super.key,
    this.height = 1,
    this.color = Colors.grey,
    this.dashWidth = 4,
    this.dashSpacing = 2,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24, // enough space for text
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(double.infinity, height),
            painter: _DashedLinePainter(
              color: color,
              dashWidth: dashWidth,
              dashSpacing: dashSpacing,
            ),
          ),

          if (text != null)
            Container(
              color: context.colorScheme.surfaceContainerLowest,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                text!,
                style:  context.textStyle.labelLarge,
              ),
            ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpacing;

  _DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..style = PaintingStyle.stroke;

    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
