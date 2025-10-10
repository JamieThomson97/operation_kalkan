import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_header.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/recommended_for_you_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/todays_offers_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/todays_schedule_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/upcoming_events_section.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFD),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const HomepageHeader(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  RecommendedForYouSection(),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: TodaysScheduleSection()),
                      SizedBox(width: 16),
                      Expanded(child: UpcomingEventsSection()),
                    ],
                  ),
                  SizedBox(height: 24),
                  TodaysOffersSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
