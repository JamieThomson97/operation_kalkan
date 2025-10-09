import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_bullet_text.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_section_card.dart';

class TodaysOffersSection extends StatelessWidget {
  const TodaysOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return HomepageSectionCard(
      title: "Today's Offers",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomepageBulletText('20% off paddleboard rentals before noon'),
          const SizedBox(height: 8),
          const HomepageBulletText(
            'Complimentary dessert with dinner reservations',
          ),
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
