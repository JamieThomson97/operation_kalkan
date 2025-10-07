import 'package:flutter/material.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    required this.item,
    this.onTap,
    super.key,
  });

  final CardItem item;
  final ValueChanged<CardItem>? onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(12));
    final subtleTextColor = Colors.grey[600];

    return SizedBox(
      width: 200,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap == null ? null : () => onTap!(item),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: item.image != null
                      ? Image.network(
                          item.image!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.photo,
                            size: 64,
                            color: Colors.white70,
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: subtleTextColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
