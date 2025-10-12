import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class TodaysScheduleSection extends StatelessWidget {
  const TodaysScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final headerColor = colorScheme.onSurface;
    final supportingColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Today's schedule",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: headerColor,
                ),
              ),
            ),
            Text(
              'Full day',
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: supportingColor,
              ),
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
                for (
                  var index = 0;
                  index < _scheduleEntries.length;
                  index++
                ) ...[
                  _ScheduleRow(entry: _scheduleEntries[index]),
                  if (index != _scheduleEntries.length - 1)
                    const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ScheduleEntry {
  const _ScheduleEntry({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  final String time;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
}

class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.entry});

  final _ScheduleEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final timeColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.7);
    final cardColor = colorScheme.surface;
    final borderColor = colorScheme.outlineVariant.withValues(alpha: 0.35);
    final timeStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: timeColor,
      letterSpacing: 0.2,
    );
    final titleStyle = textTheme.titleSmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: colorScheme.onSurface,
    );
    final subtitleStyle = textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontSize: 10,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 62,
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              entry.time,
              style: timeStyle,
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
                  _ScheduleIcon(entry: entry),
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
                          entry.subtitle,
                          style: subtitleStyle,
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

class _ScheduleIcon extends StatelessWidget {
  const _ScheduleIcon({required this.entry});

  final _ScheduleEntry entry;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: entry.iconBackgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          entry.icon,
          color: entry.iconColor,
          size: 20,
        ),
      ),
    );
  }
}

const _scheduleEntries = [
  _ScheduleEntry(
    time: '09:00',
    title: 'Breakfast at Harbor Cafe',
    subtitle: 'Table for 2 • Confirmed',
    icon: Icons.free_breakfast_outlined,
    iconColor: Color(0xFF2563EB),
    iconBackgroundColor: Color(0xFFE8F1FF),
  ),
  _ScheduleEntry(
    time: '13:30',
    title: 'Cliffside Hike',
    subtitle: 'Meet at North Gate • 2 hrs',
    icon: Icons.landscape_outlined,
    iconColor: Color(0xFF0F766E),
    iconBackgroundColor: Color(0xFFE6F5F3),
  ),
  _ScheduleEntry(
    time: '18:30',
    title: 'Spa Appointment',
    subtitle: 'Serenity Spa • 60 min',
    icon: Icons.spa_outlined,
    iconColor: Color(0xFF9333EA),
    iconBackgroundColor: Color(0xFFF2E8FF),
  ),
  _ScheduleEntry(
    time: '20:00',
    title: 'Dinner at Azure Terrace',
    subtitle: "Chef's Tasting • 8 pm",
    icon: Icons.restaurant_menu_outlined,
    iconColor: Color(0xFFB45309),
    iconBackgroundColor: Color(0xFFFDF3E7),
  ),
];
