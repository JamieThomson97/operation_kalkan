import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/vendor/data/vendor_static_content.dart';

class VendorMenuTabs extends StatelessWidget {
  const VendorMenuTabs({
    required this.visible,
    required this.categories,
    required this.activeIndex,
    required this.onCategorySelected,
    super.key,
  });

  final bool visible;
  final List<VendorMenuCategory> categories;
  final int activeIndex;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shadows = visible
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
        : const <BoxShadow>[];

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: visible ? 1 : 0,
        child: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: shadows,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = index == activeIndex;

                return ChoiceChip(
                  label: Text(category.title),
                  selected: selected,
                  onSelected: (_) => onCategorySelected(index),
                  selectedColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  showCheckmark: false,
                  labelStyle: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                  ),
                  side: BorderSide(
                    color: selected
                        ? theme.colorScheme.primary.withValues(alpha: 0.45)
                        : theme.dividerColor.withValues(alpha: 0.4),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
