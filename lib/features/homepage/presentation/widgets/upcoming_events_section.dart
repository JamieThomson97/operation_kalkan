import 'package:flutter/material.dart';

class UpcomingEventsSection extends StatelessWidget {
  const UpcomingEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Events',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _upcomingEvents.length; i++) ...[
            _UpcomingEventRow(event: _upcomingEvents[i]),
            if (i != _upcomingEvents.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _UpcomingEvent {
  const _UpcomingEvent({
    required this.title,
    required this.detail,
  });

  final String title;
  final String detail;
}

class _UpcomingEventRow extends StatelessWidget {
  const _UpcomingEventRow({required this.event});

  final _UpcomingEvent event;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          event.detail,
          style: textTheme.bodyMedium?.copyWith(
            color: textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}

const _upcomingEvents = [
  _UpcomingEvent(
    title: 'Live music at Sunset Terrace',
    detail: 'Tomorrow · 8:00 PM',
  ),
  _UpcomingEvent(
    title: "Winemaker's dinner",
    detail: 'Friday · 7:00 PM',
  ),
  _UpcomingEvent(
    title: 'Sunrise yoga on the beach',
    detail: 'Saturday · 6:00 AM',
  ),
];
