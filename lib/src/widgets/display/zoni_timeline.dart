import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Timeline component for displaying chronological events.
class ZoniTimeline extends StatelessWidget {
  /// Creates a timeline.
  const ZoniTimeline({
    required this.items,
    super.key,
    this.direction = Axis.vertical,
    this.lineColor,
    this.lineWidth = 2.0,
    this.itemSpacing = 16.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// Timeline items.
  final List<ZoniTimelineItem> items;

  /// Direction of the timeline.
  final Axis direction;

  /// Color of the connecting line.
  final Color? lineColor;

  /// Width of the connecting line.
  final double lineWidth;

  /// Spacing between items.
  final double itemSpacing;

  /// Padding around the timeline.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final Color effectiveLineColor =
        lineColor ?? Theme.of(context).dividerColor;

    if (direction == Axis.horizontal) {
      return Padding(
        padding: padding,
        child: Row(
          children: items.asMap().entries.map((entry) {
            final int index = entry.key;
            final ZoniTimelineItem item = entry.value;
            final bool isLast = index == items.length - 1;

            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _TimelineIndicator(
                          item: item,
                          lineColor: effectiveLineColor,
                        ),
                        SizedBox(height: itemSpacing / 2),
                        item.content,
                      ],
                    ),
                  ),
                  if (!isLast)
                    Container(
                      height: lineWidth,
                      width: itemSpacing,
                      color: effectiveLineColor,
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.asMap().entries.map((entry) {
          final int index = entry.key;
          final ZoniTimelineItem item = entry.value;
          final bool isLast = index == items.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _TimelineIndicator(
                      item: item,
                      lineColor: effectiveLineColor,
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: lineWidth,
                          color: effectiveLineColor,
                        ),
                      ),
                  ],
                ),
                SizedBox(width: itemSpacing),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: isLast ? 0 : itemSpacing,
                    ),
                    child: item.content,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Timeline item data class.
class ZoniTimelineItem {
  /// Creates a timeline item.
  const ZoniTimelineItem({
    required this.content,
    this.indicator,
    this.indicatorColor,
    this.indicatorSize = 12.0,
    this.isCompleted = false,
    this.isActive = false,
  });

  /// Content widget for this item.
  final Widget content;

  /// Custom indicator widget.
  final Widget? indicator;

  /// Color of the indicator.
  final Color? indicatorColor;

  /// Size of the indicator.
  final double indicatorSize;

  /// Whether this item is completed.
  final bool isCompleted;

  /// Whether this item is currently active.
  final bool isActive;
}

/// Timeline indicator widget.
class _TimelineIndicator extends StatelessWidget {
  const _TimelineIndicator({
    required this.item,
    required this.lineColor,
  });

  final ZoniTimelineItem item;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    if (item.indicator != null) {
      return item.indicator!;
    }

    Color indicatorColor;
    if (item.indicatorColor != null) {
      indicatorColor = item.indicatorColor!;
    } else if (item.isCompleted) {
      indicatorColor = ZoniColors.success;
    } else if (item.isActive) {
      indicatorColor = ZoniColors.primary;
    } else {
      indicatorColor = lineColor;
    }

    return Container(
      width: item.indicatorSize,
      height: item.indicatorSize,
      decoration: BoxDecoration(
        color: indicatorColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: item.isCompleted
          ? Icon(
              Icons.check,
              size: item.indicatorSize * 0.6,
              color: Colors.white,
            )
          : null,
    );
  }
}
