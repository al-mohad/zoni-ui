import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Trend direction for metrics.
enum ZoniMetricTrend {
  /// Upward trend (positive).
  up,
  /// Downward trend (negative).
  down,
  /// No change (neutral).
  neutral,
}

/// Metric card component for displaying key performance indicators.
class ZoniMetricCard extends StatelessWidget {
  /// Creates a metric card.
  const ZoniMetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.trend,
    this.trendValue,
    this.icon,
    this.color,
    this.onTap,
    this.padding = const EdgeInsets.all(20.0),
    this.borderRadius = 12.0,
    this.elevation = 2.0,
  });

  /// Title of the metric.
  final String title;

  /// Main value to display.
  final String value;

  /// Optional subtitle.
  final String? subtitle;

  /// Trend direction.
  final ZoniMetricTrend? trend;

  /// Trend value (e.g., "+12%").
  final String? trendValue;

  /// Optional icon.
  final IconData? icon;

  /// Optional accent color.
  final Color? color;

  /// Callback when tapped.
  final VoidCallback? onTap;

  /// Padding inside the card.
  final EdgeInsets padding;

  /// Border radius of the card.
  final double borderRadius;

  /// Elevation of the card.
  final double elevation;

  Color get _trendColor {
    switch (trend) {
      case ZoniMetricTrend.up:
        return ZoniColors.success;
      case ZoniMetricTrend.down:
        return ZoniColors.error;
      case ZoniMetricTrend.neutral:
      case null:
        return ZoniColors.neutralGray;
    }
  }

  IconData get _trendIcon {
    switch (trend) {
      case ZoniMetricTrend.up:
        return Icons.trending_up;
      case ZoniMetricTrend.down:
        return Icons.trending_down;
      case ZoniMetricTrend.neutral:
      case null:
        return Icons.trending_flat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = color ?? ZoniColors.primary;

    return Material(
      color: theme.cardColor,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                            ?.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  if (icon != null)
                    Icon(
                      icon,
                      color: accentColor,
                      size: 20.0,
                    ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                value,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                ),
              ),
              if (subtitle != null || (trend != null && trendValue != null)) ...[
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    if (subtitle != null) ...[
                      Expanded(
                        child: Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color
                                ?.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ],
                    if (trend != null && trendValue != null) ...[
                      Icon(
                        _trendIcon,
                        color: _trendColor,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        trendValue!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _trendColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Grid of metric cards.
class ZoniMetricGrid extends StatelessWidget {
  /// Creates a metric grid.
  const ZoniMetricGrid({
    super.key,
    required this.metrics,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.childAspectRatio = 1.5,
    this.physics,
    this.shrinkWrap = false,
  });

  /// List of metric cards to display.
  final List<ZoniMetricCard> metrics;

  /// Number of columns.
  final int crossAxisCount;

  /// Horizontal spacing between cards.
  final double crossAxisSpacing;

  /// Vertical spacing between cards.
  final double mainAxisSpacing;

  /// Aspect ratio of each card.
  final double childAspectRatio;

  /// Scroll physics.
  final ScrollPhysics? physics;

  /// Whether to shrink wrap the grid.
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) => metrics[index],
    );
  }
}

/// Simple metric display without card styling.
class ZoniMetric extends StatelessWidget {
  /// Creates a simple metric.
  const ZoniMetric({
    super.key,
    required this.label,
    required this.value,
    this.color,
    this.alignment = CrossAxisAlignment.start,
  });

  /// Label for the metric.
  final String label;

  /// Value to display.
  final String value;

  /// Optional color.
  final Color? color;

  /// Alignment of the content.
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = color ?? ZoniColors.primary;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: accentColor,
          ),
        ),
      ],
    );
  }
}

/// Row of simple metrics.
class ZoniMetricRow extends StatelessWidget {
  /// Creates a metric row.
  const ZoniMetricRow({
    super.key,
    required this.metrics,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// List of metrics to display.
  final List<ZoniMetric> metrics;

  /// Main axis alignment.
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment.
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: metrics
          .map((metric) => Expanded(child: metric))
          .toList(),
    );
  }
}
