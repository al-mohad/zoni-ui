import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Notification item data model.
class ZoniNotificationItem {
  /// Creates a notification item.
  const ZoniNotificationItem({
    required this.id,
    required this.title,
    required this.timestamp,
    this.message,
    this.type = ZoniNotificationType.info,
    this.isRead = false,
    this.icon,
    this.avatar,
    this.onTap,
    this.onDismiss,
  });

  /// Unique identifier for the notification.
  final String id;

  /// Title of the notification.
  final String title;

  /// Message content of the notification.
  final String? message;

  /// Type of notification.
  final ZoniNotificationType type;

  /// Whether the notification has been read.
  final bool isRead;

  /// Timestamp of the notification.
  final DateTime timestamp;

  /// Icon to display for the notification.
  final IconData? icon;

  /// Avatar to display for the notification.
  final Widget? avatar;

  /// Callback when the notification is tapped.
  final VoidCallback? onTap;

  /// Callback when the notification is dismissed.
  final VoidCallback? onDismiss;
}

/// Types of notifications.
enum ZoniNotificationType {
  /// Information notification.
  info,
  /// Success notification.
  success,
  /// Warning notification.
  warning,
  /// Error notification.
  error,
}

/// A panel component for displaying notifications.
class ZoniNotificationPanel extends StatelessWidget {
  /// Creates a notification panel.
  const ZoniNotificationPanel({
    super.key,
    required this.notifications,
    this.title = 'Notifications',
    this.showMarkAllAsRead = true,
    this.showClearAll = true,
    this.emptyMessage = 'No notifications',
    this.maxHeight,
    this.onMarkAllAsRead,
    this.onClearAll,
    this.onNotificationTap,
    this.onNotificationDismiss,
  });

  /// List of notifications to display.
  final List<ZoniNotificationItem> notifications;

  /// Title of the notification panel.
  final String title;

  /// Whether to show the "Mark all as read" button.
  final bool showMarkAllAsRead;

  /// Whether to show the "Clear all" button.
  final bool showClearAll;

  /// Message to show when there are no notifications.
  final String emptyMessage;

  /// Maximum height of the panel.
  final double? maxHeight;

  /// Callback when "Mark all as read" is tapped.
  final VoidCallback? onMarkAllAsRead;

  /// Callback when "Clear all" is tapped.
  final VoidCallback? onClearAll;

  /// Callback when a notification is tapped.
  final void Function(ZoniNotificationItem notification)? onNotificationTap;

  /// Callback when a notification is dismissed.
  final void Function(ZoniNotificationItem notification)? onNotificationDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unreadCount = notifications.where((n) => !n.isRead).length;

    return Container(
      constraints: maxHeight != null 
          ? BoxConstraints(maxHeight: maxHeight!)
          : null,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.2),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, theme, unreadCount),
          if (notifications.isEmpty)
            _buildEmptyState(context, theme)
          else
            _buildNotificationList(context, theme),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, int unreadCount) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withOpacity(0.2),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: ZoniColors.primary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                unreadCount.toString(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          const Spacer(),
          if (showMarkAllAsRead && unreadCount > 0)
            TextButton(
              onPressed: onMarkAllAsRead,
              child: const Text('Mark all read'),
            ),
          if (showClearAll && notifications.isNotEmpty)
            TextButton(
              onPressed: onClearAll,
              child: const Text('Clear all'),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Icon(
            Icons.notifications_none,
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
    );
  }

  Widget _buildNotificationList(BuildContext context, ThemeData theme) {
    return Flexible(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(
          height: 1.0,
          color: theme.dividerColor.withOpacity(0.2),
        ),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationItem(context, theme, notification);
        },
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    ThemeData theme,
    ZoniNotificationItem notification,
  ) {
    final typeColor = _getTypeColor(notification.type);
    
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        notification.onDismiss?.call();
        onNotificationDismiss?.call(notification);
      },
      background: Container(
        color: ZoniColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: InkWell(
        onTap: () {
          notification.onTap?.call();
          onNotificationTap?.call(notification);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: notification.isRead 
                ? null 
                : ZoniColors.primary.withOpacity(0.05),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notification.avatar != null)
                notification.avatar!
              else
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    notification.icon ?? _getTypeIcon(notification.type),
                    color: typeColor,
                    size: 20.0,
                  ),
                ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: notification.isRead 
                                  ? FontWeight.normal 
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: const BoxDecoration(
                              color: ZoniColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    if (notification.message != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        notification.message!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4.0),
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
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

  Color _getTypeColor(ZoniNotificationType type) {
    switch (type) {
      case ZoniNotificationType.info:
        return ZoniColors.primary;
      case ZoniNotificationType.success:
        return ZoniColors.success;
      case ZoniNotificationType.warning:
        return ZoniColors.warning;
      case ZoniNotificationType.error:
        return ZoniColors.error;
    }
  }

  IconData _getTypeIcon(ZoniNotificationType type) {
    switch (type) {
      case ZoniNotificationType.info:
        return Icons.info_outline;
      case ZoniNotificationType.success:
        return Icons.check_circle_outline;
      case ZoniNotificationType.warning:
        return Icons.warning_amber_outlined;
      case ZoniNotificationType.error:
        return Icons.error_outline;
    }
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
