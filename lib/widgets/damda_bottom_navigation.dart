import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class DamdaBottomNavigation extends StatelessWidget {
  const DamdaBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  static const _items = [
    (icon: Icons.mail_outline_rounded, label: '보관함'),
    (icon: Icons.edit_rounded, label: '작성'),
    (icon: Icons.task_alt_rounded, label: '한 줄'),
    (icon: Icons.shopping_bag_outlined, label: '가게'),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 0.7),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: [
              _NavigationItem(
                item: _items[0],
                selected: currentIndex == 0,
                onTap: () => onSelected(0),
              ),
              _NavigationItem(
                item: _items[1],
                selected: currentIndex == 1,
                onTap: () => onSelected(1),
              ),
              const SizedBox(width: 64),
              _NavigationItem(
                item: _items[2],
                selected: currentIndex == 2,
                onTap: () => onSelected(2),
              ),
              _NavigationItem(
                item: _items[3],
                selected: currentIndex == 3,
                onTap: () => onSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final ({IconData icon, String label}) item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.textPrimary : AppColors.navigation;

    return Expanded(
      child: InkResponse(
        onTap: onTap,
        radius: 28,
        child: Semantics(
          selected: selected,
          button: true,
          label: item.label,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: color, size: 21),
              const SizedBox(height: 3),
              Text(
                item.label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
