import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class PlanEssentialsCard extends StatelessWidget {
  const PlanEssentialsCard({super.key});

  static final _items = [
    const _EssentialItem(
      icon: Icons.sailing_rounded,
      label: 'Harbor transfer',
      supporting: 'Driver Yusuf · 09:45',
    ),
    const _EssentialItem(
      icon: Icons.spa_rounded,
      label: 'Wellness hold',
      supporting: 'Palmarina Hammam · 13:00',
    ),
    const _EssentialItem(
      icon: Icons.chair_alt_rounded,
      label: 'Dinner confirmation',
      supporting: 'Chef’s table · 19:30',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 8),
        child: Column(
          children: [
            _SectionHeader(
              title: 'Essentials',
              actionLabel: 'Share',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            for (final item in _items) _EssentialRow(item: item),
          ],
        ),
      ),
    );
  }
}

class _EssentialItem {
  const _EssentialItem({
    required this.icon,
    required this.label,
    required this.supporting,
  });

  final IconData icon;
  final String label;
  final String supporting;
}

class _EssentialRow extends StatelessWidget {
  const _EssentialRow({required this.item});

  final _EssentialItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final supportingStyle = textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                item.icon,
                color: colorScheme.primary,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(item.supporting, style: supportingStyle),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: colorScheme.outline,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onPressed,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(actionLabel),
        ),
      ],
    );
  }
}
