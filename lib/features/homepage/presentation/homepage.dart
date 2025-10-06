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
    final subtleTextColor = Colors.grey[600];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Your Trip'),
            Text(
              resortName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: subtleTextColor,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            Text(
              'Discover experiences tailored for you.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: subtleTextColor,
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Restaurants'),
            const SizedBox(height: 12),
            HorizontalCarousel(
              items: _sampleRestaurants,
              onItemTap: (item) => context.pushNamed(
                VendorPage.routeName,
                extra: item,
              ),
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Activities'),
            const SizedBox(height: 12),
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
    image:
        'https://images.unsplash.com/photo-1528605248644-14dd04022da1'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'Olive Tree',
    subtitle: 'Traditional local dishes',
    image:
        'https://images.unsplash.com/photo-1521017432531-fbd92d768814'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'Beach Bistro',
    subtitle: 'Casual dining on the sand',
    image:
        'https://images.unsplash.com/photo-1498654896293-37aacf113fd9'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
];

final List<CardItem> _sampleActivities = [
  const CardItem(
    title: 'Scuba Diving',
    subtitle: 'Explore coral reefs with a guide',
    image:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'Boat Trip',
    subtitle: 'Full-day island hopping escape',
    image:
        'https://images.unsplash.com/photo-1516054719048-d4c1ab27c26c'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'Hiking Trail',
    subtitle: 'Scenic mountain walk at sunrise',
    image:
        'https://images.unsplash.com/photo-1469474968028-56623f02e42e'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
];
