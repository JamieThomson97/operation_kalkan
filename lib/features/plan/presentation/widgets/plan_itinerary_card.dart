import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:operation_kalkan/shared/theme/context_theme_extensions.dart';
import 'package:operation_kalkan/shared/widgets/safe_network_image.dart';

class PlanItineraryCard extends StatelessWidget {
  const PlanItineraryCard({super.key});

  static final _items = <_ItineraryEntry>[
    const _ItineraryEntry(
      start: TimeOfDay(hour: 8, minute: 0),
      end: TimeOfDay(hour: 9, minute: 0),
      title: 'Sunrise Pilates by the marina',
      detail: 'Mat + towels prepped',
      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
      status: _BookingStatus.confirmed,
    ),
    const _ItineraryEntry(
      start: TimeOfDay(hour: 10, minute: 30),
      end: TimeOfDay(hour: 12, minute: 0),
      title: 'Slow breakfast at Zest',
      detail: 'Chef Selin tasting menu',
      imageUrl: 'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17',
      status: _BookingStatus.pending,
    ),
    const _ItineraryEntry(
      start: TimeOfDay(hour: 14, minute: 0),
      end: TimeOfDay(hour: 17, minute: 30),
      title: 'Sail to Black Island coves',
      detail: 'Skipper + mezze onboard',
      imageUrl: 'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
      status: _BookingStatus.confirmed,
    ),
    const _ItineraryEntry(
      start: TimeOfDay(hour: 19, minute: 30),
      end: TimeOfDay(hour: 22, minute: 0),
      title: 'Chef’s table at Theia',
      detail: '7-course coastal harvest',
      imageUrl: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371',
      status: _BookingStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final headerColor = colorScheme.onSurface;
    final supportingColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: supportingColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
              child: const Text('Edit'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surfaceBright,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 32,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
              child: _DiaryTimeline(entries: _items),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItineraryEntry {
  const _ItineraryEntry({
    required this.start,
    required this.end,
    required this.title,
    required this.detail,
    required this.imageUrl,
    this.status = _BookingStatus.confirmed,
    this.isSuggestion = false,
  });

  final TimeOfDay start;
  final TimeOfDay end;
  final String title;
  final String detail;
  final String imageUrl;
  final _BookingStatus status;
  final bool isSuggestion;

  int get startMinutes => start.hour * 60 + start.minute;
  int get endMinutes => end.hour * 60 + end.minute;
  int get durationMinutes => endMinutes - startMinutes;
}

enum _BookingStatus { confirmed, pending, suggested }

class _SuggestionTemplate {
  const _SuggestionTemplate({
    required this.title,
    required this.detail,
    required this.imageUrl,
    required this.durationMinutes,
  });

  final String title;
  final String detail;
  final String imageUrl;
  final int durationMinutes;
}

const _suggestionPool = <_SuggestionTemplate>[
  _SuggestionTemplate(
    title: 'Lagoon swim + mocktails',
    detail: 'Crew on standby if you want to drop anchor at Kaputas.',
    imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    durationMinutes: 75,
  ),
  _SuggestionTemplate(
    title: 'Olive grove picnic',
    detail: 'Chef Selin can prep a hamper in under an hour.',
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
    durationMinutes: 60,
  ),
];

const _mockNow = TimeOfDay(hour: 10, minute: 08);
const _pendingStatusColor = Color(0xFFF7C948);
const double _suggestionActionSpacing = 6;
const double _suggestionActionHeight = 32;
const double _suggestionActionTotalExtent =
    _suggestionActionSpacing + _suggestionActionHeight;

class _DiaryTimeline extends StatelessWidget {
  const _DiaryTimeline({required this.entries});

  final List<_ItineraryEntry> entries;
  static const double _hourSlotHeight = 96;
  static const double _minMeetingExtent = 118;

  @override
  Widget build(BuildContext context) {
    final orderedEntries = [...entries]
      ..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
    final timelineEntries = _mergeSuggestions(orderedEntries);
    if (timelineEntries.isEmpty) {
      return const SizedBox.shrink();
    }
    final earliestStart = timelineEntries.first.startMinutes;
    final latestEnd = timelineEntries
        .map((entry) => entry.endMinutes)
        .reduce((value, element) => element > value ? element : value);
    final timelineStartHour = earliestStart ~/ 60;
    final desiredEndHour = (latestEnd / 60).ceil();
    final timelineEndHour = desiredEndHour <= timelineStartHour
        ? timelineStartHour + 1
        : (desiredEndHour > 24 ? 24 : desiredEndHour);
    final hourCount = timelineEndHour - timelineStartHour;
    final timelineStartMinutes = timelineStartHour * 60;
    final totalHeight = hourCount <= 0
        ? _hourSlotHeight
        : hourCount * _hourSlotHeight;

    double canvasHeight = totalHeight.toDouble();
    for (final entry in timelineEntries) {
      final topMinutes = entry.startMinutes - timelineStartMinutes;
      final top = (topMinutes / 60) * _hourSlotHeight;
      final eventExtent = math.max(
        entry.durationMinutes / 60 * _hourSlotHeight,
        _hourSlotHeight * 0.5,
      );
      final desiredExtent = math.max(eventExtent, _minMeetingExtent);
      final suggestionAllowance = entry.isSuggestion
          ? _suggestionActionTotalExtent
          : 0;
      canvasHeight = math.max(
        canvasHeight,
        top + desiredExtent + suggestionAllowance,
      );
    }

    final nowMinutes = _mockNow.hour * 60 + _mockNow.minute;
    final indicatorMinutes = nowMinutes - timelineStartMinutes;
    final indicatorTop = (indicatorMinutes / 60) * _hourSlotHeight;
    final indicatorWithinTimeline =
        indicatorTop >= 0 && indicatorTop <= canvasHeight;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
        physics: const ClampingScrollPhysics(),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: canvasHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TimelineGutter(
                startHour: timelineStartHour,
                hourCount: hourCount,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: _TimelineGrid(hourCount: hourCount),
                    ),
                    if (indicatorWithinTimeline)
                      Positioned(
                        top: indicatorTop,
                        left: 0,
                        right: 0,
                        child: const _NowIndicator(),
                      ),
                    for (final entry in timelineEntries)
                      _MeetingPositioned(
                        entry: entry,
                        timelineStartMinutes: timelineStartMinutes,
                        hourSlotHeight: _hourSlotHeight,
                        canvasHeight: canvasHeight,
                        minExtent: _minMeetingExtent,
                        isPast: entry.endMinutes <= nowMinutes,
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

class _TimelineGutter extends StatelessWidget {
  const _TimelineGutter({
    required this.startHour,
    required this.hourCount,
  });

  final int startHour;
  final int hourCount;

  @override
  Widget build(BuildContext context) {
    final labelColor = context.colorScheme.onSurfaceVariant.withValues(
      alpha: 0.35,
    );
    final labelsCount = hourCount + 1;

    return SizedBox(
      width: 56,
      child: Stack(
        children: [
          for (var i = 0; i < labelsCount; i++)
            Positioned(
              top: math.max(
                0.0,
                i * _DiaryTimeline._hourSlotHeight - 6,
              ),
              left: 0,
              right: 0,
              child: Text(
                _formatHourLabel(startHour + i),
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TimelineGrid extends StatelessWidget {
  const _TimelineGrid({required this.hourCount});

  final int hourCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final slots = hourCount <= 0 ? 1 : hourCount;

    return Column(
      children: [
        for (var i = 0; i < slots; i++)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: i.isEven
                    ? colorScheme.surface
                    : colorScheme.surfaceVariant.withValues(alpha: 0.12),
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                    width: i == 0 ? 0.8 : 0.4,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _NowIndicator extends StatelessWidget {
  const _NowIndicator();

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.primary;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class _MeetingPositioned extends StatelessWidget {
  const _MeetingPositioned({
    required this.entry,
    required this.timelineStartMinutes,
    required this.hourSlotHeight,
    required this.canvasHeight,
    required this.minExtent,
    required this.isPast,
  });

  final _ItineraryEntry entry;
  final int timelineStartMinutes;
  final double hourSlotHeight;
  final double canvasHeight;
  final double minExtent;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final topMinutes = entry.startMinutes - timelineStartMinutes;
    final top = (topMinutes / 60) * hourSlotHeight;
    final height = (entry.durationMinutes / 60) * hourSlotHeight;
    final safeguardedHeight = height <= 0 ? hourSlotHeight * 0.5 : height;
    final targetedHeight = math.max(safeguardedHeight, minExtent);
    final maxAvailable = canvasHeight - top;
    final extraActionExtent = entry.isSuggestion
        ? _suggestionActionTotalExtent
        : 0;
    final availableForCard = math.max(0.0, maxAvailable - extraActionExtent);
    final paintHeight = targetedHeight > availableForCard
        ? availableForCard
        : targetedHeight;
    final totalHeight = paintHeight + extraActionExtent;

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: SizedBox(
        height: totalHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: paintHeight,
              child: _MeetingBlock(
                entry: entry,
                isPast: isPast,
              ),
            ),
            if (entry.isSuggestion) ...[
              const SizedBox(height: _suggestionActionSpacing),
              const _SuggestionActionRow(),
            ],
          ],
        ),
      ),
    );
  }
}

class _MeetingBlock extends StatelessWidget {
  const _MeetingBlock({
    required this.entry,
    required this.isPast,
  });

  final _ItineraryEntry entry;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final isConfirmed = entry.status == _BookingStatus.confirmed;
    final isPending = entry.status == _BookingStatus.pending;
    final isSuggested = entry.status == _BookingStatus.suggested;
    final statusColor = isConfirmed
        ? colorScheme.primary
        : isPending
        ? _pendingStatusColor
        : colorScheme.secondary;
    final accentColor = isPast
        ? statusColor.withValues(alpha: 0.35)
        : statusColor.withValues(alpha: 0.85);
    final backgroundColor = isSuggested
        ? colorScheme.surfaceVariant.withValues(alpha: 0.35)
        : colorScheme.surface;
    final borderColor = isSuggested
        ? accentColor.withValues(alpha: 0.45)
        : statusColor.withValues(alpha: 0.18);
    final boxShadow = isSuggested
        ? [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]
        : [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ];

    return Opacity(
      opacity: isPast ? 0.75 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: backgroundColor,
          border: Border.all(color: borderColor),
          boxShadow: boxShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatusPill(
                color: accentColor,
                dotted: isSuggested,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.detail,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _ItineraryThumbnail(imageUrl: entry.imageUrl),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionActionRow extends StatelessWidget {
  const _SuggestionActionRow();

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.onSurfaceVariant.withValues(alpha: 0.85);

    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, _suggestionActionHeight),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        visualDensity: VisualDensity.compact,
        textStyle: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      child: Text(
        'See more for this time ⟶',
        style: TextStyle(color: color),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.color, this.dotted = false});

  final Color color;
  final bool dotted;

  @override
  Widget build(BuildContext context) {
    if (!dotted) {
      return Container(
        width: 6,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}

class _ItineraryThumbnail extends StatelessWidget {
  const _ItineraryThumbnail({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 54,
        height: 54,
        child: SafeNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

String _formatHourLabel(int hour) {
  final normalized = hour % 24;
  final period = normalized >= 12 ? 'PM' : 'AM';
  final displayHour = normalized == 0
      ? 12
      : normalized > 12
      ? normalized - 12
      : normalized;
  return '$displayHour $period';
}

List<_ItineraryEntry> _mergeSuggestions(List<_ItineraryEntry> entries) {
  if (entries.isEmpty) return entries;
  final augmented = <_ItineraryEntry>[];
  var suggestionIndex = 0;

  for (var i = 0; i < entries.length; i++) {
    augmented.add(entries[i]);
    if (i == entries.length - 1) continue;

    final gapMinutes = entries[i + 1].startMinutes - entries[i].endMinutes;
    if (gapMinutes < 120 || suggestionIndex >= _suggestionPool.length) {
      continue;
    }

    final template = _suggestionPool[suggestionIndex++];
    final proposedStart = entries[i].endMinutes + 30;
    final proposedEnd = math.min(
      proposedStart + template.durationMinutes,
      entries[i + 1].startMinutes - 15,
    );

    if (proposedEnd - proposedStart < 30) {
      continue;
    }

    augmented.add(
      _ItineraryEntry(
        start: _minutesToTimeOfDay(proposedStart),
        end: _minutesToTimeOfDay(proposedEnd),
        title: template.title,
        detail: template.detail,
        imageUrl: template.imageUrl,
        status: _BookingStatus.suggested,
        isSuggestion: true,
      ),
    );
  }

  augmented.sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
  return augmented;
}

TimeOfDay _minutesToTimeOfDay(int minutes) {
  final normalized = minutes.clamp(0, 24 * 60 - 1);
  final hour = normalized ~/ 60;
  final minute = normalized % 60;
  return TimeOfDay(hour: hour, minute: minute);
}
