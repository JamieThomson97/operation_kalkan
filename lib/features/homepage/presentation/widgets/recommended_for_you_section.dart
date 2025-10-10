import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:operation_kalkan/features/homepage/presentation/models/card_item.dart';
import 'package:operation_kalkan/features/vendor/presentation/vendor_page.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class RecommendedForYouSection extends StatelessWidget {
  const RecommendedForYouSection({
    super.key,
    this.onSeeAll,
  });

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final highlightColor = colorScheme.primary;
    void onVendorTap(_RecommendedVendor vendor) {
      unawaited(
        context.pushNamed(
          VendorPage.routeName,
          extra: vendor.card,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recommended for you',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            if (onSeeAll != null)
              TextButton(
                onPressed: onSeeAll,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: highlightColor,
                ),
                child: const Text('See all'),
              )
            else
              Text(
                'See all',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final baseWidth = maxWidth.isFinite ? maxWidth : 280.0;
            final desiredWidth = baseWidth * 0.85;
            final cardWidth = desiredWidth.clamp(250.0, 320.0).toDouble();
            return SizedBox(
              height: 420,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                padding: const EdgeInsets.only(right: 8),
                itemCount: _recommendedVendors.length,
                separatorBuilder: (context, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final vendor = _recommendedVendors[index];
                  return _RecommendedVendorCard(
                    vendor: vendor,
                    highlightColor: highlightColor,
                    width: cardWidth,
                    onTap: () => onVendorTap(vendor),
                  );
                },
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
    required this.card,
    required this.tag,
    required this.tagIcon,
    required this.rating,
    required this.distanceLabel,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    this.isPriority = false,
  });

  final CardItem card;
  final String tag;
  final IconData tagIcon;
  final double rating;
  final String distanceLabel;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final bool isPriority;

  String get title => card.title;
  String get subtitle => card.subtitle;
  String? get imageUrl => card.image;
  String get ratingLabel => rating.toStringAsFixed(1);
}

class _RecommendedVendorCard extends StatelessWidget {
  const _RecommendedVendorCard({
    required this.vendor,
    required this.highlightColor,
    required this.width,
    required this.onTap,
  });

  final _RecommendedVendor vendor;
  final Color highlightColor;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final borderRadius = BorderRadius.circular(24);
    final shadowColor = colorScheme.shadow.withOpacity(0.08);

    return SizedBox(
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: colorScheme.surface,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _VendorImage(
                  imageUrl: vendor.imageUrl,
                  borderRadius: borderRadius,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _VendorTag(
                        label: vendor.tag,
                        icon: vendor.tagIcon,
                        colorScheme: colorScheme,
                        highlightColor: highlightColor,
                        isPriority: vendor.isPriority,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        vendor.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        vendor.subtitle,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _VendorMetadataRow(
                        colorScheme: colorScheme,
                        vendor: vendor,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          FilledButton.icon(
                            onPressed: onTap,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            icon: const Icon(Icons.event_available_outlined),
                            label: Text(vendor.primaryActionLabel),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: onTap,
                            child: Text(
                              vendor.secondaryActionLabel,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VendorImage extends StatelessWidget {
  const _VendorImage({
    required this.imageUrl,
    required this.borderRadius,
  });

  final String? imageUrl;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
      ),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: SafeNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _VendorTag extends StatelessWidget {
  const _VendorTag({
    required this.label,
    required this.icon,
    required this.colorScheme,
    required this.highlightColor,
    required this.isPriority,
  });

  final String label;
  final IconData icon;
  final ColorScheme colorScheme;
  final Color highlightColor;
  final bool isPriority;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isPriority
        ? highlightColor.withValues(alpha: 0.16)
        : colorScheme.surfaceContainerHighest;
    final foregroundColor = isPriority ? highlightColor : colorScheme.onSurface;
    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: foregroundColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorMetadataRow extends StatelessWidget {
  const _VendorMetadataRow({
    required this.colorScheme,
    required this.vendor,
  });

  final ColorScheme colorScheme;
  final _RecommendedVendor vendor;

  @override
  Widget build(BuildContext context) {
    final metadataColor = colorScheme.onSurface.withValues(alpha: 0.7);
    return Row(
      children: [
        Icon(Icons.star_rounded, color: metadataColor, size: 20),
        const SizedBox(width: 4),
        Text(
          vendor.ratingLabel,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: metadataColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.place_outlined, color: metadataColor, size: 18),
        const SizedBox(width: 4),
        Text(
          vendor.distanceLabel,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: metadataColor,
              ),
        ),
      ],
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
    tag: 'Lounge',
    tagIcon: Icons.local_bar_outlined,
    rating: 4.8,
    distanceLabel: '450 m',
    primaryActionLabel: 'Reserve',
    secondaryActionLabel: 'Details',
    isPriority: true,
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'Sunset Terrace',
      subtitle: 'Tapas plates and relaxed terrace beats',
      image:
          'https://images.unsplash.com/photo-1470246973918-29a93221c455?auto=format&fit=crop&w=1200&q=80',
    ),
    tag: 'Restaurant',
    tagIcon: Icons.restaurant_menu_outlined,
    rating: 4.6,
    distanceLabel: '1.2 km',
    primaryActionLabel: 'Book',
    secondaryActionLabel: 'View menu',
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'Canyon Safari Guides',
      subtitle: 'Guided off-road adventures',
      image:
          'https://images.unsplash.com/photo-1521295121783-8a321d551ad2?auto=format&fit=crop&w=1200&q=80',
    ),
    tag: 'Tours',
    tagIcon: Icons.map_outlined,
    rating: 4.9,
    distanceLabel: '8 km',
    primaryActionLabel: 'Join tour',
    secondaryActionLabel: 'Details',
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'The Gin Parlour',
      subtitle: 'Botanical infusions & masterclasses',
      image:
          'https://images.unsplash.com/photo-1544145945-f90425340c7e?auto=format&fit=crop&w=1200&q=80',
    ),
    tag: 'Bar',
    tagIcon: Icons.local_drink_outlined,
    rating: 4.7,
    distanceLabel: '700 m',
    primaryActionLabel: 'Reserve',
    secondaryActionLabel: 'Details',
    isPriority: true,
  ),
  _RecommendedVendor(
    card: CardItem(
      title: 'La Managa Spa',
      subtitle: 'Restful therapies & steam rituals',
      image:
          'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?auto=format&fit=crop&w=1200&q=80',
    ),
    tag: 'Spa',
    tagIcon: Icons.spa_outlined,
    rating: 4.5,
    distanceLabel: '2.4 km',
    primaryActionLabel: 'Book',
    secondaryActionLabel: 'Details',
  ),
];
