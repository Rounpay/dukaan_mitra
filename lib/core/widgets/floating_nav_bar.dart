import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

/// @Created by akash on 19-02-2026.
/// Know more about author at https://akash.cloudemy.in

class FloatingNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<IconData> icons;


  const FloatingNavBar({
    super.key,
    this.selectedIndex = 0,
    required this.onTap,
    required this.icons,

  });

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(16),
      height: 60,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ThemeColors.bottomNavigationColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 25,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child:  Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.icons.length, (index) {
        final isSelected = index == widget.selectedIndex;
        return Expanded(
          child: InkWell(
            onTap: () {
              widget.onTap(index);
            },
            borderRadius: BorderRadius.circular(32),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                    child: child,
                  );
                },
                child: isSelected
                    ? Container(
                  key: const ValueKey('filled'),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    _filledIcon(widget.icons[index]),
                    color: colorScheme.surface,
                    size: 20,
                  ),
                )
                    : Icon(
                  widget.icons[index],
                  key: const ValueKey('outlined'),
                  color: colorScheme.surface,
                ),
              ),
            ),
          ),
        );
      }),
    ),
    );
  }

  IconData _filledIcon(IconData icon) {
    switch (icon) {
      case Icons.home_outlined:
        return Icons.home;
      case Icons.shopping_bag:
        return Icons.shopping_bag_outlined;
      case Icons.favorite_border:
        return Icons.favorite_border;
      case Icons.person_outline:
        return Icons.person;
      default:
        return icon;
    }
  }
}
