import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/plan/presentation/widgets/plan_itinerary_card.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: const [
          SizedBox(height: 32),
          PlanItineraryCard(),
        ],
      ),
    );
  }
}
