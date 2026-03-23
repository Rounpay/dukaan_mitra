import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

/// @Created by akash on 19-02-2026.
/// Know more about author at https://akash.cloudemy.in

class FloatingNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    this.selectedIndex = 0,
    required this.onTap,
  });

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  final icons = const [
    Icons.home_outlined,
    Icons.shopping_bag_outlined,
   // Icons.favorite_border,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(16),
      height: 68,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ThemeColors.bottomNavigationColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(icons.length, (index) {
          final isSelected = index == widget.selectedIndex;
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 16.0),
            child: InkWell(
              onTap: () {
                widget.onTap(index);
              },
              borderRadius: BorderRadius.circular(32),
              child: SizedBox(
                width: 55,
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
                            _filledIcon(icons[index]),
                            color: colorScheme.surface,
                            size: 28,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            icons[index],
                            key: const ValueKey('outlined'),
                            color: colorScheme.onSurfaceVariant,
                          ),
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
