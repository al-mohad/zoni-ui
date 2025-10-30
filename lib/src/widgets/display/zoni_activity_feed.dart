import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Activity item data model.
class ZoniActivityItem {
  /// Creates an activity item.
  const ZoniActivityItem({
    required this.id,
    required this.title,
    required this.timestamp,
    this.description,
    this.icon,
    this.avatar,
    this.color,
    this.onTap,
  });

  /// Unique identifier for the activity.
  final String id;

  /// Title of the activity.
  final String title;

  /// Description of the activity.
  final String? description;

  /// Timestamp of the activity.
  final DateTime timestamp;

  /// Icon to display for the activity.
  final IconData? icon;

  /// Avatar to display for the activity.
  final Widget? avatar;

  /// Color for the activity indicator.
  final Color? color;

  /// Callback when the activity is tapped.
  final VoidCallback? onTap;
}

/// A feed component for displaying activity items in chronological order.
class ZoniActivityFeed extends StatelessWidget {
  /// Creates an activity feed.
  const ZoniActivityFeed({
    super.key,
    required this.items,
    this.showTimeline = true,
    this.timelineColor,
    this.itemSpacing = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.emptyMessage = 'No activities yet',
    this.onItemTap,
  });

  /// List of activity items to display.
  final List<ZoniActivityItem> items;

  /// Whether to show the timeline connector.
  final bool showTimeline;

  /// Color of the timeline connector.
  final Color? timelineColor;

  /// Spacing between activity items.
  final double itemSpacing;

  /// Padding around the feed.
  final EdgeInsets padding;

  /// Message to show when there are no items.
  final String emptyMessage;

  /// Callback when an item is tapped.
  final void Function(ZoniActivityItem item)? onItemTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _buildEmptyState(context);
    }

    return Padding(
      padding: padding,
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: itemSpacing),
        itemBuilder: (context, index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          
          return _buildActivityItem(context, item, isLast);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timeline,
              size: 48.0,
              color: theme.disabledColor,
            ),
            const SizedBox(height: 16.0),
            Text(
              emptyMessage,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, ZoniActivityItem item, bool isLast) {
    final theme = Theme.of(context);
    final activityColor = item.color ?? ZoniColors.primary;
    final timelineConnectorColor = timelineColor ?? theme.dividerColor;

    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTimeline) ...[
          Column(
            children: [
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: activityColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2.0,
                  height: 40.0,
                  color: timelineConnectorColor,
                ),
            ],
          ),
          const SizedBox(width: 16.0),
        ],
        if (item.avatar != null) ...[
          item.avatar!,
          const SizedBox(width: 12.0),
        ] else if (item.icon != null) ...[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: activityColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              item.icon,
              color: activityColor,
              size: 20.0,
            ),
          ),
          const SizedBox(width: 12.0),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (item.description != null) ...[
                const SizedBox(height: 4.0),
                Text(
                  item.description!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
              const SizedBox(height: 4.0),
              Text(
                _formatTimestamp(item.timestamp),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (item.onTap != null || onItemTap != null) {
      content = InkWell(
        onTap: () {
          item.onTap?.call();
          onItemTap?.call(item);
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        ),
      );
    }

    return content;
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
