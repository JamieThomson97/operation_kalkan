import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class VendorInfoSection extends StatelessWidget {
  const VendorInfoSection({
    required this.onInfoTap,
    super.key,
  });

  final VoidCallback onInfoTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final dividerColor = theme.dividerColor.withValues(alpha: 0.25);
    final cardFill = colorScheme.surfaceContainerHighest;
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurface.withValues(alpha: 0.64),
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    final valueStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w700,
    );
    final secondaryValueStyle = theme.textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurface.withValues(alpha: 0.55),
      fontWeight: FontWeight.w300,
      height: 1.2,
    );

    Widget buildCell({
      required Widget child,
      bool showDivider = true,
      VoidCallback? onTap,
    }) {
      final cell = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            right: showDivider
                ? BorderSide(color: dividerColor, width: 0.8)
                : BorderSide.none,
          ),
        ),
        child: child,
      );

      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: cell,
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardFill,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            buildCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rating', style: labelStyle),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: colorScheme.secondary,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text('4.8', style: valueStyle),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('500+ reviews', style: secondaryValueStyle),
                ],
              ),
            ),
            buildCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: labelStyle?.color,
                  ),
                  const SizedBox(height: 6),
                  Text('Info & Contact', style: labelStyle),
                ],
              ),
              onTap: onInfoTap,
            ),
            buildCell(
              showDivider: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Distance', style: labelStyle),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.directions_walk,
                        size: 18,
                        color: labelStyle?.color,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '0.5 mi',
                          style: valueStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
