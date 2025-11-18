import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/features/homepage/presentation/widgets/carousel_card.dart';

class HorizontalCarousel extends StatelessWidget {
  const HorizontalCarousel({
    required this.items,
    this.onItemTap,
    super.key,
  });

  final List<CardItem> items;
  final ValueChanged<CardItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.only(right: 20),
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return CarouselCard(
            item: item,
            onTap: onItemTap,
          );
        },
      ),
    );
  }
}
