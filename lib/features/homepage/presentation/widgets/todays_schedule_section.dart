import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class TodaysScheduleSection extends StatelessWidget {
  const TodaysScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final shadowColor = colorScheme.shadow.withValues(alpha: 0.08);
    final backgroundColor = colorScheme.surfaceBright;
    final headerColor = colorScheme.onSurface;
    final supportingColor =
        colorScheme.onSurfaceVariant.withValues(alpha: 0.9);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
        child: Column(
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
            const SizedBox(height: 20),
            for (var index = 0; index < _scheduleEntries.length; index++) ...[
              _ScheduleRow(entry: _scheduleEntries[index]),
              if (index != _scheduleEntries.length - 1)
                const SizedBox(height: 16),
            ],
          ],
        ),
      ),
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 62,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              entry.time,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: timeColor,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 18, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ScheduleIcon(entry: entry),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          entry.subtitle,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: 48,
        height: 48,
        child: Icon(
          entry.icon,
          color: entry.iconColor,
          size: 24,
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
