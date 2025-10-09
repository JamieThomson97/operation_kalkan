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
            const SizedBox(height: 32),
            const SectionTitle(title: 'Bars'),
            const SizedBox(height: 12),
            HorizontalCarousel(
              items: _sampleBars,
              onItemTap: (item) => context.pushNamed(
                VendorPage.routeName,
                extra: item,
              ),
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Excursions'),
            const SizedBox(height: 12),
            HorizontalCarousel(
              items: _sampleExcursions,
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
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
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

final List<CardItem> _sampleBars = [
  const CardItem(
    title: 'Skyline Lounge',
    subtitle: 'Craft cocktails with panoramic views',
    image:
        'https://images.unsplash.com/photo-1481833761820-0509d3217039'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'Sunset Terrace',
    subtitle: 'Chill beats, tapas, and golden hour vibes',
    image:
        'https://images.unsplash.com/photo-1470246973918-29a93221c455'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'The Gin Parlour',
    subtitle: 'Botanical infusions & mixology workshops',
    image:
        'https://images.unsplash.com/photo-1544145945-f90425340c7e'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
];

final List<CardItem> _sampleExcursions = [
  const CardItem(
    title: 'Canyon Safari',
    subtitle: 'Off-road adventure through hidden valleys',
    image:
        'https://images.unsplash.com/photo-1521295121783-8a321d551ad2'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'Historical Walking Tour',
    subtitle: 'Guided stroll through ancient ruins',
    image:
        'https://images.unsplash.com/photo-1470337458703-46ad1756a187'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
  const CardItem(
    title: 'Sunrise Hot Air Balloon',
    subtitle: 'Soar above the coastline at dawn',
    image:
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470'
        '?auto=format&fit=crop&w=1200&q=80',
  ),
];
