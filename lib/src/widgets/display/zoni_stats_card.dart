import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// A statistics card component for displaying key metrics and data.
class ZoniStatsCard extends StatelessWidget {
  /// Creates a statistics card.
  const ZoniStatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.trend,
    this.trendValue,
    this.color,
    this.backgroundColor,
    this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// The title of the statistic.
  final String title;

  /// The main value to display.
  final String value;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional icon to display.
  final IconData? icon;

  /// Trend direction (up, down, neutral).
  final ZoniStatsTrend? trend;

  /// Trend value to display.
  final String? trendValue;

  /// Primary color for the card.
  final Color? color;

  /// Background color for the card.
  final Color? backgroundColor;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Width of the card.
  final double? width;

  /// Height of the card.
  final double? height;

  /// Padding inside the card.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = backgroundColor ?? theme.cardColor;
    final primaryColor = color ?? ZoniColors.primary;

    Widget card = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.2),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 20.0,
                  ),
                ),
                const SizedBox(width: 12.0),
              ],
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.textTheme.headlineMedium?.color,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4.0),
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ],
          if (trend != null && trendValue != null) ...[
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  _getTrendIcon(),
                  size: 16.0,
                  color: _getTrendColor(),
                ),
                const SizedBox(width: 4.0),
                Text(
                  trendValue!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getTrendColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: card,
      );
    }

    return card;
  }

  IconData _getTrendIcon() {
    switch (trend!) {
      case ZoniStatsTrend.up:
        return Icons.trending_up;
      case ZoniStatsTrend.down:
        return Icons.trending_down;
      case ZoniStatsTrend.neutral:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor() {
    switch (trend!) {
      case ZoniStatsTrend.up:
        return ZoniColors.success;
      case ZoniStatsTrend.down:
        return ZoniColors.error;
      case ZoniStatsTrend.neutral:
        return ZoniColors.warning;
    }
  }
}

/// Trend direction for statistics.
enum ZoniStatsTrend {
  /// Upward trend.
  up,
  /// Downward trend.
  down,
  /// Neutral trend.
  neutral,
}
