import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {

  const Homepage({required this.resortName, super.key});
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
            SizedBox(height: 8),
            _SectionTitle(title: 'Restaurants'),
            SizedBox(height: 8),
            _HorizontalCarousel(items: _sampleRestaurants),
            SizedBox(height: 24),
            _SectionTitle(title: 'Activities'),
            SizedBox(height: 8),
            _HorizontalCarousel(items: _sampleActivities),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See all'),
        )
      ],
    );
  }
}

class _HorizontalCarousel extends StatelessWidget {
  final List<_CardItem> items;

  const _HorizontalCarousel({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return _CarouselCard(item: item);
        },
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final _CardItem item;

  const _CarouselCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                child: item.image != null
                    ? Image.network(item.image!, fit: BoxFit.cover)
                    : const Icon(Icons.photo, size: 64, color: Colors.white70),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(item.subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CardItem {
  final String title;
  final String subtitle;
  final String? image;

  _CardItem({required this.title, required this.subtitle, this.image});
}

final List<_CardItem> _sampleRestaurants = [
  _CardItem(title: 'Seaside Grill', subtitle: 'Fresh seafood & sunset views', image: null),
  _CardItem(title: 'Olive Tree', subtitle: 'Traditional local dishes', image: null),
  _CardItem(title: 'Beach Bistro', subtitle: 'Casual dining', image: null),
];

final List<_CardItem> _sampleActivities = [
  _CardItem(title: 'Scuba Diving', subtitle: 'Explore coral reefs', image: null),
  _CardItem(title: 'Boat Trip', subtitle: 'Full-day island hopping', image: null),
  _CardItem(title: 'Hiking Trail', subtitle: 'Scenic mountain walk', image: null),
];
