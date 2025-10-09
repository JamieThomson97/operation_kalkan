import 'dart:math';

import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class RecommendedForYouSection extends StatelessWidget {
  const RecommendedForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final highlightColor = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended for you',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            const double priorityMinWidth = 180;
            const double standardMinWidth = 130;
            const double rowSpacing = 12;
            final standardWidth = max(standardMinWidth, availableWidth * 0.34);
            final standardHeight = standardWidth;
            final priorityWidth = max(priorityMinWidth, availableWidth * 0.46);
            final priorityHeight = standardHeight * 2 + rowSpacing;

            final columns = _buildVendorColumns(
              vendors: _recommendedVendors,
              standardWidth: standardWidth,
              standardHeight: standardHeight,
              priorityWidth: priorityWidth,
              priorityHeight: priorityHeight,
              rowSpacing: rowSpacing,
              highlightColor: highlightColor,
            );

            return SizedBox(
              height: priorityHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => columns[index],
                separatorBuilder: (context, _) => const SizedBox(width: 16),
                itemCount: columns.length,
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _buildVendorColumns({
    required List<_RecommendedVendor> vendors,
    required double standardWidth,
    required double standardHeight,
    required double priorityWidth,
    required double priorityHeight,
    required double rowSpacing,
    required Color highlightColor,
  }) {
    final columns = <Widget>[];
    var index = 0;

    while (index < vendors.length) {
      final vendor = vendors[index];
      if (vendor.isPriority) {
        columns.add(
          _RecommendedVendorTile(
            vendor: vendor,
            highlightColor: highlightColor,
            width: priorityWidth,
            height: priorityHeight,
          ),
        );
        index += 1;
        continue;
      }

      _RecommendedVendor? nextVendor;
      if (index + 1 < vendors.length && !vendors[index + 1].isPriority) {
        nextVendor = vendors[index + 1];
        index += 2;
      } else {
        index += 1;
      }

      columns.add(
        SizedBox(
          width: standardWidth,
          height: priorityHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _RecommendedVendorTile(
                vendor: vendor,
                highlightColor: highlightColor,
                width: standardWidth,
                height: standardHeight,
              ),
              SizedBox(height: rowSpacing),
              if (nextVendor != null)
                _RecommendedVendorTile(
                  vendor: nextVendor,
                  highlightColor: highlightColor,
                  width: standardWidth,
                  height: standardHeight,
                )
              else
                SizedBox(
                  height: standardHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.grey[100],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return columns;
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
    required this.height,
  });

  final _RecommendedVendor vendor;
  final Color highlightColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return SizedBox(
      width: width,
      height: height,
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
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Text(
                vendor.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
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
  _RecommendedVendor(
    title: 'La Managa Spa',
    imageUrl:
        'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?auto=format&fit=crop&w=1200&q=80',
  ),
];
