import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';

class TodaysScheduleSection extends StatelessWidget {
  const TodaysScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Schedule",
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _scheduleEntries.length; i++) ...[
            _ScheduleRow(entry: _scheduleEntries[i]),
            if (i != _scheduleEntries.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _ScheduleEntry {
  const _ScheduleEntry({
    required this.time,
    required this.detail,
  });

  final String time;
  final String detail;
}

class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({required this.entry});

  final _ScheduleEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final mutedColor =
        context.colorScheme.onSurface.withValues(alpha: 0.75);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.detail,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          entry.time,
          style: textTheme.bodyMedium?.copyWith(
            color: mutedColor,
          ),
        ),
      ],
    );
  }
}

const _scheduleEntries = [
  _ScheduleEntry(
    time: '09:00',
    detail: 'Guided snorkel adventure',
  ),
  _ScheduleEntry(
    time: '14:30',
    detail: 'Spa appointment',
  ),
  _ScheduleEntry(
    time: '19:00',
    detail: 'Dinner at Skyline Lounge',
  ),
];
