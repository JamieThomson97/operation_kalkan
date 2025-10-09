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
