import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/features/vendor/presentation/vendor_page.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class RecommendedForYouSection extends StatelessWidget {
  const RecommendedForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final highlightColor = theme.colorScheme.primary;
    void onVendorTap(_RecommendedVendor vendor) {
      unawaited(
        context.pushNamed(
          VendorPage.routeName,
          extra: vendor.card,
        ),
      );
    }

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
              onVendorTap: onVendorTap,
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
    required ValueChanged<_RecommendedVendor> onVendorTap,
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
            onTap: () => onVendorTap(vendor),
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

      final partnerVendor = nextVendor;
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
                onTap: () => onVendorTap(vendor),
              ),
              SizedBox(height: rowSpacing),
              if (partnerVendor != null)
                _RecommendedVendorTile(
                  vendor: partnerVendor,
                  highlightColor: highlightColor,
                  width: standardWidth,
                  height: standardHeight,
                  onTap: () => onVendorTap(partnerVendor),
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
    required this.card,
    this.isPriority = false,
  });

  final CardItem card;
  final bool isPriority;

  String get title => card.title;
  String? get imageUrl => card.image;
}

class _RecommendedVendorTile extends StatelessWidget {
  const _RecommendedVendorTile({
    required this.vendor,
    required this.highlightColor,
    required this.width,
    required this.height,
    required this.onTap,
  });

  final _RecommendedVendor vendor;
  final Color highlightColor;
  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
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
      ),
    );
  }
}

const _recommendedVendors = [
  _RecommendedVendor(
    card: CardItem(
      title: 'Skyline Lounge',
      subtitle: 'Craft cocktails with panoramic views',
      image:
          'https://images.unsplash.com/photo-1481833761820-0509d3217039?auto=format&fit=crop&w=1200&q=80',
    ),
    isPriority: true,
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'Sunset Terrace',
      subtitle: 'Tapas plates and relaxed terrace beats',
      image:
          'https://images.unsplash.com/photo-1470246973918-29a93221c455?auto=format&fit=crop&w=1200&q=80',
    ),
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'Canyon Safari Guides',
      subtitle: 'Guided off-road adventures',
      image:
          'https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=1200&q=80',
    ),
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'The Gin Parlour',
      subtitle: 'Botanical infusions & masterclasses',
      image:
          'https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=1200&q=80',
    ),
    isPriority: true,
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'La Managa Spa',
      subtitle: 'Restful therapies & steam rituals',
      image:
          'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?auto=format&fit=crop&w=1200&q=80',
    ),
  ),
];
