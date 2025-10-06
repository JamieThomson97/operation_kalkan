import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/horizontal_carousel.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/section_title.dart';
import 'package:operation_kalkan/features/vendor/presentation/vendor_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key, this.resortName = defaultResortName});

  static const defaultResortName = 'La Managa';

  final String resortName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Trip: $resortName'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 8),
            const SectionTitle(title: 'Restaurants'),
            const SizedBox(height: 8),
            HorizontalCarousel(
              items: _sampleRestaurants,
              onItemTap: (item) => context.pushNamed(
                VendorPage.routeName,
                extra: item,
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Activities'),
            const SizedBox(height: 8),
            HorizontalCarousel(
              items: _sampleActivities,
              onItemTap: (item) => context.pushNamed(
                VendorPage.routeName,
                extra: item,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<CardItem> _sampleRestaurants = [
  const CardItem(
    title: 'Seaside Grill',
    subtitle: 'Fresh seafood & sunset views',
  ),
  const CardItem(
    title: 'Olive Tree',
    subtitle: 'Traditional local dishes',
  ),
  const CardItem(title: 'Beach Bistro', subtitle: 'Casual dining'),
];

final List<CardItem> _sampleActivities = [
  const CardItem(
    title: 'Scuba Diving',
    subtitle: 'Explore coral reefs',
  ),
  const CardItem(
    title: 'Boat Trip',
    subtitle: 'Full-day island hopping',
  ),
  const CardItem(
    title: 'Hiking Trail',
    subtitle: 'Scenic mountain walk',
  ),
];
