import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/homepage_header.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/recommended_for_you_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/todays_schedule_section.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/upcoming_events_section.dart';
import 'package:operation_kalkan/features/plan/presentation/plan_page.dart';

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

  void _goToPlan() => _onDestinationSelected(2);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final glassSurface = colorScheme.surface;
    final glassHighlight = colorScheme.primary.withOpacity(0.08);

    final pages = [
      _HomeTab(onViewPlan: _goToPlan),
      const _PlaceholderPage(label: 'Explore'),
      const PlanPage(),
      const _PlaceholderPage(label: 'Profile'),
    ];

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
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.onViewPlan});

  final VoidCallback onViewPlan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              const HomepageHeader(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: RecommendedForYouSection(),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TodaysScheduleSection(onViewFullDay: onViewPlan),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: UpcomingEventsSection(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspaces_outline, size: 48, color: colorScheme.outline),
          const SizedBox(height: 12),
          Text(
            '$label coming soon',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
