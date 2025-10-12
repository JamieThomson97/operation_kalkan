import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class UpcomingEventsSection extends StatelessWidget {
  const UpcomingEventsSection({
    super.key,
    this.onSeeAll,
  });

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final highlightColor = colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Upcoming events',
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
                  minimumSize: Size.zero,
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
            const crossAxisCount = 2;
            const spacing = 16.0;
            final availableWidth = maxWidth.isFinite ? maxWidth : 320.0;
            final cardWidth =
                (availableWidth - spacing * (crossAxisCount - 1)) /
                crossAxisCount;
            final cardHeight = cardWidth * 1.3;
            final childAspectRatio = cardWidth / cardHeight;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: _upcomingEvents.length,
              itemBuilder: (context, index) {
                final event = _upcomingEvents[index];
                return _UpcomingEventCard(
                  event: event,
                  highlightColor: highlightColor,
                  width: cardWidth,
                  height: cardHeight,
                  onTap: () {},
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _UpcomingEvent {
  const _UpcomingEvent({
    required this.title,
    required this.subtitle,
    required this.scheduleLabel,
    required this.locationLabel,
    required this.tag,
    required this.tagIcon,
    required this.imageUrl,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    this.isFeatured = false,
  });

  final String title;
  final String subtitle;
  final String scheduleLabel;
  final String locationLabel;
  final String tag;
  final IconData tagIcon;
  final String imageUrl;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final bool isFeatured;
}

class _UpcomingEventCard extends StatelessWidget {
  const _UpcomingEventCard({
    required this.event,
    required this.highlightColor,
    required this.width,
    required this.height,
    required this.onTap,
  });

  final _UpcomingEvent event;
  final Color highlightColor;
  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final borderRadius = BorderRadius.circular(14);
    final shadowColor = colorScheme.shadow.withValues(alpha: 0.08);
    final imageHeight = height * 0.4;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 14,
              offset: const Offset(0, 8),
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
                _EventImage(
                  imageUrl: event.imageUrl,
                  borderRadius: borderRadius,
                  height: imageHeight,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _EventTag(
                          label: event.tag,
                          icon: event.tagIcon,
                          colorScheme: colorScheme,
                          highlightColor: highlightColor,
                          isFeatured: event.isFeatured,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          event.title,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                            letterSpacing: -0.1,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.subtitle,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        _EventMetadataRow(
                          colorScheme: colorScheme,
                          event: event,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: onTap,
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(0, 32),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                                icon: const Icon(
                                  Icons.event_available_outlined,
                                  size: 16,
                                ),
                                label: Text(
                                  event.primaryActionLabel,
                                  style: textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: onTap,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                minimumSize: const Size(0, 32),
                                visualDensity: VisualDensity.compact,
                              ),
                              child: Text(
                                event.secondaryActionLabel,
                                style: textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class _EventImage extends StatelessWidget {
  const _EventImage({
    required this.imageUrl,
    required this.borderRadius,
    required this.height,
  });

  final String imageUrl;
  final BorderRadius borderRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: SafeNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _EventTag extends StatelessWidget {
  const _EventTag({
    required this.label,
    required this.icon,
    required this.colorScheme,
    required this.highlightColor,
    required this.isFeatured,
  });

  final String label;
  final IconData icon;
  final ColorScheme colorScheme;
  final Color highlightColor;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isFeatured
        ? highlightColor.withValues(alpha: 0.16)
        : colorScheme.surfaceContainerHighest;
    final foregroundColor = isFeatured ? highlightColor : colorScheme.onSurface;

    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: foregroundColor),
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

class _EventMetadataRow extends StatelessWidget {
  const _EventMetadataRow({
    required this.colorScheme,
    required this.event,
  });

  final ColorScheme colorScheme;
  final _UpcomingEvent event;

  @override
  Widget build(BuildContext context) {
    final metadataColor = colorScheme.onSurface.withValues(alpha: 0.75);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.schedule_outlined, color: metadataColor, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                event.scheduleLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: metadataColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.place_outlined, color: metadataColor, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                event.locationLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: metadataColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

const _upcomingEvents = [
  _UpcomingEvent(
    title: 'Sunset Terrace live set',
    subtitle: 'Acoustic performances from resident artists',
    scheduleLabel: 'Tomorrow · 8:00 PM',
    locationLabel: 'Skyline Lounge roof deck',
    tag: 'Music',
    tagIcon: Icons.music_note_outlined,
    imageUrl:
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=80',
    primaryActionLabel: 'Reserve',
    secondaryActionLabel: 'Details',
    isFeatured: true,
  ),
  _UpcomingEvent(
    title: "Winemaker's dinner",
    subtitle: 'Five-course pairing menu with guest vintner',
    scheduleLabel: 'Friday · 7:00 PM',
    locationLabel: 'Marina Bistro private dining room',
    tag: 'Dining',
    tagIcon: Icons.restaurant_menu_outlined,
    imageUrl:
        'https://images.unsplash.com/photo-1527169402691-feff5539e52c?auto=format&fit=crop&w=1200&q=80',
    primaryActionLabel: 'Book table',
    secondaryActionLabel: 'View menu',
  ),
  _UpcomingEvent(
    title: 'Sunrise beach yoga',
    subtitle: 'Mindful flow session to welcome the day',
    scheduleLabel: 'Saturday · 6:00 AM',
    locationLabel: 'South Beach boardwalk',
    tag: 'Wellness',
    tagIcon: Icons.self_improvement_outlined,
    imageUrl:
        'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=1200&q=80',
    primaryActionLabel: 'Join class',
    secondaryActionLabel: 'Learn more',
  ),
  _UpcomingEvent(
    title: 'Stargazing campfire',
    subtitle: 'Guided constellation tour & storytelling',
    scheduleLabel: 'Saturday · 9:30 PM',
    locationLabel: 'Canyon Overlook trailhead',
    tag: 'Outdoors',
    tagIcon: Icons.nightlight_round,
    imageUrl:
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=80',
    primaryActionLabel: 'RSVP',
    secondaryActionLabel: 'Details',
    isFeatured: true,
  ),
];
