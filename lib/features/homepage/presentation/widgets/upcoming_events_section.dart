import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_bullet_text.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_section_card.dart';

class UpcomingEventsSection extends StatelessWidget {
  const UpcomingEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomepageSectionCard(
      title: 'Upcoming events',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomepageBulletText('Live music at Sunset Terrace · Tomorrow 8 PM'),
          SizedBox(height: 8),
          HomepageBulletText("Winemaker's dinner · Friday 7 PM"),
          SizedBox(height: 8),
          HomepageBulletText('Sunrise yoga on the beach · Saturday 6 AM'),
        ],
      ),
    );
  }
}
