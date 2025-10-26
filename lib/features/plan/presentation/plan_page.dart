import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final headerStyle = textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: colorScheme.onSurface,
    );

    return SafeArea(
      top: false,
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: const [
          SizedBox(height: 32),
          _ItineraryCard(),
          SizedBox(height: 24),
          _PlanOverviewCard(),
          SizedBox(height: 24),
          _EssentialsCard(),
          SizedBox(height: 24),
          _LocalTipsCard(),
        ],
      ),
    );
  }
}

class _PlanOverviewCard extends StatelessWidget {
  const _PlanOverviewCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            offset: const Offset(0, 18),
            blurRadius: 28,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        child: Column(
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
                        'Thursday, Apr 18',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Full-day in Bodrum',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sunny,
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '26°C / sunny',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: _PlanMetric(
                    label: 'Meals booked',
                    value: '02',
                    supporting: 'Breakfast & dinner confirmed',
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: _PlanMetric(
                    label: 'Transfers',
                    value: '01',
                    supporting: 'Harbor pickup included',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: _PlanMetric(
                    label: 'Experiences',
                    value: '03',
                    supporting: 'Culture + beach time',
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: _PlanMetric(
                    label: 'Buffer',
                    value: '2h',
                    supporting: 'Free-roam downtown',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanMetric extends StatelessWidget {
  const _PlanMetric({
    required this.label,
    required this.value,
    required this.supporting,
  });

  final String label;
  final String value;
  final String supporting;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              supporting,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItineraryCard extends StatelessWidget {
  const _ItineraryCard();

  static final _items = <_ItineraryEntry>[
    const _ItineraryEntry(
      time: '08:00',
      endTime: '09:00',
      title: 'Sunrise Pilates by the marina',
      detail: 'Mat + towels prepped',
      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
    ),
    const _ItineraryEntry(
      time: '10:30',
      endTime: '12:00',
      title: 'Slow breakfast at Zest',
      detail: 'Chef Selin tasting menu',
      imageUrl: 'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17',
    ),
    const _ItineraryEntry(
      time: '14:00',
      endTime: '17:30',
      title: 'Sail to Black Island coves',
      detail: 'Skipper + mezze onboard',
      imageUrl: 'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
    ),
    const _ItineraryEntry(
      time: '19:30',
      endTime: '22:00',
      title: 'Chef’s table at Theia',
      detail: '7-course coastal harvest',
      imageUrl: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final headerColor = colorScheme.onSurface;
    final supportingColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Itinerary',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: headerColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: supportingColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Edit'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 32,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
            child: Column(
              children: [
                for (var i = 0; i < _items.length; i++) ...[
                  _ItineraryRow(entry: _items[i]),
                  if (i != _items.length - 1) const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ItineraryEntry {
  const _ItineraryEntry({
    required this.time,
    required this.endTime,
    required this.title,
    required this.detail,
    required this.imageUrl,
  });

  final String time;
  final String endTime;
  final String title;
  final String detail;
  final String imageUrl;
}

class _ItineraryRow extends StatelessWidget {
  const _ItineraryRow({required this.entry});

  final _ItineraryEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final timeStyle = textTheme.labelLarge?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    );
    final endTimeStyle = textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.45),
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );
    final titleStyle = textTheme.titleSmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: colorScheme.onSurface,
    );
    final detailStyle = textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontSize: 10,
    );
    final cardColor = colorScheme.surface;
    final borderColor = colorScheme.outlineVariant.withValues(alpha: 0.35);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 62,
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.time, style: timeStyle),
                const SizedBox(height: 2),
                Text(entry.endTime, style: endTimeStyle),
              ],
            ),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ItineraryThumbnail(imageUrl: entry.imageUrl),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title,
                          style: titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.detail,
                          style: detailStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItineraryThumbnail extends StatelessWidget {
  const _ItineraryThumbnail({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 40,
        height: 40,
        child: SafeNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _EssentialsCard extends StatelessWidget {
  const _EssentialsCard();

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

class _LocalTipsCard extends StatelessWidget {
  const _LocalTipsCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withValues(alpha: 0.95),
            colorScheme.primaryContainer.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local intel',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimary,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Catch the harbor golden hour from the Lighthouse promenade—barista Onur keeps cold brew ready for you.',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 18),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onPrimary,
                backgroundColor: colorScheme.onPrimary.withValues(alpha: 0.08),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
              label: const Text('Open in map'),
            ),
          ],
        ),
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
