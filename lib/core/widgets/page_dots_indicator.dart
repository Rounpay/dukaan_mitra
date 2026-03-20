/// @Created by akash on 18-02-2026.
/// Know more about author at https://akash.cloudemy.in
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class PageDotsIndicator extends StatelessWidget {
  final int count;
  final int selectedIndex;
  final double dotHeight;
  final double dotWidth;
  final double expandedWidth;
  final Duration duration;

  const PageDotsIndicator({
    super.key,
    required this.count,
    required this.selectedIndex,
    this.dotHeight = 8,
    this.dotWidth = 8,
    this.expandedWidth = 24,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colorScheme.primaryContainer;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
            (index) {
          final isSelected = index == selectedIndex;

          return AnimatedContainer(
            duration: duration,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: dotHeight,
            width: isSelected ? expandedWidth : dotWidth,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : context.colorScheme.outline,
              borderRadius: BorderRadius.circular(dotHeight),
            ),
          );
        },
      ),
    );
  }
}
