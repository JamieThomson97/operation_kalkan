import 'package:flutter/material.dart';

class TodaysScheduleSection extends StatelessWidget {
  const TodaysScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    const scheduleCardColor = Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: scheduleCardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Schedule",
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.detail,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          entry.time,
          style: textTheme.bodyMedium?.copyWith(
            color: textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
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
