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
          children: const [
            HomepageHeader(),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RecommendedForYouSection(),
                  SizedBox(height: 24),
                  TodaysScheduleSection(),
                  SizedBox(height: 24),
                  UpcomingEventsSection(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
