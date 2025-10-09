import 'dart:math';

import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class RecommendedForYouSection extends StatelessWidget {
  const RecommendedForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    final highlightColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended for you',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            const double priorityMinWidth = 150;
            const double standardMinWidth = 130;
            final priorityWidth = max(priorityMinWidth, availableWidth * 0.48);
            final standardWidth = max(standardMinWidth, availableWidth * 0.38);

            return SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final vendor = _recommendedVendors[index];
                  final tileWidth = vendor.isPriority
                      ? priorityWidth
                      : standardWidth;
                  return _RecommendedVendorTile(
                    vendor: vendor,
                    highlightColor: highlightColor,
                    width: tileWidth,
                  );
                },
                separatorBuilder: (context, _) => const SizedBox(width: 16),
                itemCount: _recommendedVendors.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RecommendedVendor {
  const _RecommendedVendor({
    required this.title,
    required this.imageUrl,
    this.isPriority = false,
  });

  final String title;
  final String imageUrl;
  final bool isPriority;
}

class _RecommendedVendorTile extends StatelessWidget {
  const _RecommendedVendorTile({
    required this.vendor,
    required this.highlightColor,
    required this.width,
  });

  final _RecommendedVendor vendor;
  final Color highlightColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: SafeNetworkImage(
                  imageUrl: vendor.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (vendor.isPriority)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: highlightColor.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: highlightColor.withValues(alpha: 0.3),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Featured',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  if (vendor.isPriority) const SizedBox(height: 8),
                  Text(
                    vendor.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: vendor.isPriority
                        ? highlightColor.withValues(alpha: 0.35)
                        : Colors.transparent,
                    width: vendor.isPriority ? 2 : 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _recommendedVendors = [
  _RecommendedVendor(
    title: 'Skyline Lounge',
    imageUrl:
        'https://images.unsplash.com/photo-1481833761820-0509d3217039?auto=format&fit=crop&w=1200&q=80',
    isPriority: true,
  ),
  _RecommendedVendor(
    title: 'Sunset Terrace',
    imageUrl:
        'https://images.unsplash.com/photo-1470246973918-29a93221c455?auto=format&fit=crop&w=1200&q=80',
  ),
  _RecommendedVendor(
    title: 'Canyon Safari Guides',
    imageUrl:
        'https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=1200&q=80',
  ),
  _RecommendedVendor(
    title: 'The Gin Parlour',
    imageUrl:
        'https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=1200&q=80',
    isPriority: true,
  ),
];
