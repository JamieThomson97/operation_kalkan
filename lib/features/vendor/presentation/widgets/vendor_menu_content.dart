import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/vendor/data/vendor_static_content.dart';

class VendorMenuContent extends StatelessWidget {
  const VendorMenuContent({
    required this.categories,
    required this.menuSectionKey,
    required this.categoryKeys,
    super.key,
  });

  final List<VendorMenuCategory> categories;
  final Key menuSectionKey;
  final List<GlobalKey> categoryKeys;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return KeyedSubtree(
      key: menuSectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menu',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < categories.length; i++) ...[
            KeyedSubtree(
              key: categoryKeys[i],
              child: VendorMenuSection(category: categories[i]),
            ),
            if (i != categories.length - 1) const SizedBox(height: 24),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class VendorMenuSection extends StatelessWidget {
  const VendorMenuSection({
    required this.category,
    super.key,
  });

  final VendorMenuCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < category.items.length; i++) ...[
          VendorMenuItemTile(
            item: category.items[i],
            showDivider: i != category.items.length - 1,
          ),
          if (i != category.items.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class VendorMenuItemTile extends StatelessWidget {
  const VendorMenuItemTile({
    required this.item,
    this.showDivider = false,
    super.key,
  });

  final VendorMenuItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final secondaryColor = theme.colorScheme.onSurface.withValues(alpha: 0.68);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: textTheme.bodySmall?.copyWith(
                      color: secondaryColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        item.price,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.tag != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          item.tag!,
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (item.imageUrl != null) ...[
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl!,
                  width: 76,
                  height: 76,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 12),
          Divider(
            height: 1,
            thickness: 1,
            color: theme.dividerColor.withValues(alpha: 0.15),
          ),
        ],
      ],
    );
  }
}
