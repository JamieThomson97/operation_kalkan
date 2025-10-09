import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_section_card.dart';

class TodaysScheduleSection extends StatelessWidget {
  const TodaysScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    const scheduleItems = [
      _ScheduleItem(time: '09:00', detail: 'Guided snorkel adventure'),
      _ScheduleItem(time: '14:30', detail: 'Spa appointment'),
      _ScheduleItem(time: '19:00', detail: 'Dinner at Skyline Lounge'),
    ];

    return HomepageSectionCard(
      title: "Today's Schedule",
      child: Column(
        children: [
          for (var i = 0; i < scheduleItems.length; i++) ...[
            scheduleItems[i],
            if (i != scheduleItems.length - 1)
              const Divider(height: 20, thickness: 0.6),
          ],
        ],
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({
    required this.time,
    required this.detail,
  });

  final String time;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            time,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            detail,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
