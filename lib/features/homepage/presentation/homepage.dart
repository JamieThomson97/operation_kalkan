import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_header.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/recommended_for_you_section.dart';
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

    final glassSurface = colorScheme.surface;
    final glassHighlight = colorScheme.primary.withOpacity(0.08);

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF8FBFD),
      bottomNavigationBar: SafeArea(
        // this is meh
        minimum: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        top: false,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    glassSurface.withOpacity(0.82),
                    glassSurface.withOpacity(0.64),
                    glassHighlight,
                  ],
                ),
                border: Border.all(color: Colors.white.withOpacity(0.18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 32,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: NavigationBar(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                indicatorColor: colorScheme.primary.withOpacity(0.12),
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
      ),
      body: Stack(
        children: [
          SafeArea(
            top: false,
            bottom: false,
            child: ListView(
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
        ],
      ),
    );
  }
}
