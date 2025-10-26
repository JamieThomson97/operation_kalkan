import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class PlanItineraryCard extends StatelessWidget {
  const PlanItineraryCard({super.key});

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
