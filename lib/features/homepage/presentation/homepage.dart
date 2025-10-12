import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_header.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/recommended_for_you_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/todays_offers_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/todays_schedule_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/upcoming_events_section.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
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
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              indicatorColor: colorScheme.primary.withOpacity(0.12),
              height: 64,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.travel_explore_outlined),
                  selectedIcon: Icon(Icons.travel_explore),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: Icon(Icons.event_note_outlined),
                  selectedIcon: Icon(Icons.event_note),
                  label: 'Plan',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
