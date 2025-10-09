import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: const [
            HomepageHeader(),
            SizedBox(height: 24),
            RecommendedForYouSection(),
            SizedBox(height: 24),
            TodaysScheduleSection(),
            SizedBox(height: 24),
            TodaysOffersSection(),
            SizedBox(height: 24),
            UpcomingEventsSection(),
          ],
        ),
      ),
    );
  }
}

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Here is a quick snapshot of your trip',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withAlpha(180),
          ),
        ),
      ],
    );
  }
}

class RecommendedForYouSection extends StatelessWidget {
  const RecommendedForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _HomepageCard(
      title: 'Recommended for you',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check out the new rooftop lounge with sunset tasting menu.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text('View recommendations'),
          ),
        ],
      ),
    );
  }
}

class TodaysScheduleSection extends StatelessWidget {
  const TodaysScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    const scheduleItems = [
      _ScheduleItem(time: '09:00', detail: 'Guided snorkel adventure'),
      _ScheduleItem(time: '14:30', detail: 'Spa appointment'),
      _ScheduleItem(time: '19:00', detail: 'Dinner at Skyline Lounge'),
    ];

    return _HomepageCard(
      title: "Today's Schedule",
      child: Column(
        children: [
          for (final item in scheduleItems) ...[
            item,
            if (item != scheduleItems.last)
              const Divider(height: 20, thickness: 0.6),
          ],
        ],
      ),
    );
  }
}

class TodaysOffersSection extends StatelessWidget {
  const TodaysOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomepageCard(
      title: "Today's Offers",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _BulletText('20% off paddleboard rentals before noon'),
          const SizedBox(height: 8),
          const _BulletText('Complimentary dessert with dinner reservations'),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.local_offer_outlined),
            label: const Text('Browse offers'),
          ),
        ],
      ),
    );
  }
}

class UpcomingEventsSection extends StatelessWidget {
  const UpcomingEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomepageCard(
      title: 'Upcoming events',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BulletText('Live music at Sunset Terrace · Tomorrow 8 PM'),
          SizedBox(height: 8),
          _BulletText("Winemaker's dinner · Friday 7 PM"),
          SizedBox(height: 8),
          _BulletText('Sunrise yoga on the beach · Saturday 6 AM'),
        ],
      ),
    );
  }
}

class _HomepageCard extends StatelessWidget {
  const _HomepageCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• '),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
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
