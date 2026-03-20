import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Color color;
  final double dashWidth;
  final double dashSpacing;
  final BorderRadius borderRadius;

  const DottedBorderContainer({
    super.key,
    required this.child,
    this.strokeWidth = 1,
    this.color = Colors.grey,
    this.dashWidth = 4,
    this.dashSpacing = 4,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpacing: dashSpacing,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpacing;
  final BorderRadius borderRadius;

  _DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpacing,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = borderRadius.toRRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    final path = Path()..addRRect(rrect);
    final dashedPath = _createDashedPath(path);

    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        dest.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpacing;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}