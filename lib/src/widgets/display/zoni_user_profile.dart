import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';

/// User profile data model.
class ZoniUserProfileData {
  /// Creates a user profile data.
  const ZoniUserProfileData({
    required this.name,
    this.email,
    this.avatar,
    this.role,
    this.department,
    this.status,
    this.lastSeen,
    this.badges = const <ZoniUserBadge>[],
    this.stats = const <String, String>{},
  });

  /// User's display name.
  final String name;

  /// User's email address.
  final String? email;

  /// User's avatar widget or image.
  final Widget? avatar;

  /// User's role or title.
  final String? role;

  /// User's department.
  final String? department;

  /// User's current status.
  final ZoniUserStatus? status;

  /// When the user was last seen.
  final DateTime? lastSeen;

  /// User's badges or achievements.
  final List<ZoniUserBadge> badges;

  /// User's statistics.
  final Map<String, String> stats;
}

/// User status enum.
enum ZoniUserStatus {
  /// User is online.
  online,

  /// User is away.
  away,

  /// User is busy.
  busy,

  /// User is offline.
  offline,
}

/// User badge data model.
class ZoniUserBadge {
  /// Creates a user badge.
  const ZoniUserBadge({
    required this.label,
    this.icon,
    this.color,
  });

  /// Badge label.
  final String label;

  /// Badge icon.
  final IconData? icon;

  /// Badge color.
  final Color? color;
}

/// A user profile component for displaying user information.
class ZoniUserProfile extends StatelessWidget {
  /// Creates a user profile widget.
  const ZoniUserProfile({
    required this.profile,
    super.key,
    this.variant = ZoniUserProfileVariant.card,
    this.showStats = true,
    this.showBadges = true,
    this.showStatus = true,
    this.onTap,
    this.onEdit,
    this.actions = const <Widget>[],
  });

  /// User profile data.
  final ZoniUserProfileData profile;

  /// Profile display variant.
  final ZoniUserProfileVariant variant;

  /// Whether to show user statistics.
  final bool showStats;

  /// Whether to show user badges.
  final bool showBadges;

  /// Whether to show user status.
  final bool showStatus;

  /// Callback when the profile is tapped.
  final VoidCallback? onTap;

  /// Callback when edit is tapped.
  final VoidCallback? onEdit;

  /// Additional action buttons.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ZoniUserProfileVariant.card:
        return _buildCardVariant(context);
      case ZoniUserProfileVariant.compact:
        return _buildCompactVariant(context);
      case ZoniUserProfileVariant.detailed:
        return _buildDetailedVariant(context);
    }
  }

  Widget _buildCardVariant(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              _buildAvatarSection(context, theme),
              const SizedBox(height: 16),
              _buildInfoSection(context, theme),
              if (showBadges && profile.badges.isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                _buildBadgesSection(context, theme),
              ],
              if (showStats && profile.stats.isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                _buildStatsSection(context, theme),
              ],
              if (actions.isNotEmpty) ...<Widget>[
                const SizedBox(height: 16),
                _buildActionsSection(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactVariant(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            _buildAvatar(context, theme, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    profile.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (profile.role != null)
                    Text(
                      profile.role!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                ],
              ),
            ),
            if (showStatus && profile.status != null)
              _buildStatusIndicator(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedVariant(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildAvatarSection(context, theme),
                    const SizedBox(height: 16),
                    _buildInfoSection(context, theme),
                  ],
                ),
              ),
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                ),
            ],
          ),
          if (showBadges && profile.badges.isNotEmpty) ...<Widget>[
            const SizedBox(height: 20),
            Text(
              'Badges',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildBadgesSection(context, theme),
          ],
          if (showStats && profile.stats.isNotEmpty) ...<Widget>[
            const SizedBox(height: 20),
            Text(
              'Statistics',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildStatsSection(context, theme),
          ],
          if (actions.isNotEmpty) ...<Widget>[
            const SizedBox(height: 20),
            _buildActionsSection(context),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context, ThemeData theme) => Stack(
        children: <Widget>[
          _buildAvatar(context, theme),
          if (showStatus && profile.status != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildStatusIndicator(context, theme),
            ),
        ],
      );

  Widget _buildAvatar(
    BuildContext context,
    ThemeData theme, {
    double size = 80.0,
  }) {
    if (profile.avatar != null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: profile.avatar,
        ),
      );
    }

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: ZoniColors.primary.withOpacity(0.1),
      child: Text(
        profile.name.isNotEmpty ? profile.name[0].toUpperCase() : '?',
        style: theme.textTheme.headlineMedium?.copyWith(
          color: ZoniColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context, ThemeData theme) {
    final Color statusColor = _getStatusColor(profile.status!);

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: statusColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.cardColor,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            profile.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (profile.role != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              profile.role!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: ZoniColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (profile.email != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              profile.email!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
          ],
          if (profile.department != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              profile.department!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
          ],
          if (profile.lastSeen != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              'Last seen ${_formatLastSeen(profile.lastSeen!)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ],
      );

  Widget _buildBadgesSection(BuildContext context, ThemeData theme) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: profile.badges
            .map(
              (ZoniUserBadge badge) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: (badge.color ?? ZoniColors.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (badge.icon != null) ...<Widget>[
                      Icon(
                        badge.icon,
                        size: 14,
                        color: badge.color ?? ZoniColors.primary,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      badge.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: badge.color ?? ZoniColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      );

  Widget _buildStatsSection(BuildContext context, ThemeData theme) => Wrap(
        spacing: 16,
        runSpacing: 8,
        children: profile.stats.entries
            .map(
              (MapEntry<String, String> entry) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    entry.value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    entry.key,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      );

  Widget _buildActionsSection(BuildContext context) => Row(
        children:
            actions.map((Widget action) => Expanded(child: action)).toList(),
      );

  Color _getStatusColor(ZoniUserStatus status) {
    switch (status) {
      case ZoniUserStatus.online:
        return ZoniColors.success;
      case ZoniUserStatus.away:
        return ZoniColors.warning;
      case ZoniUserStatus.busy:
        return ZoniColors.error;
      case ZoniUserStatus.offline:
        return Colors.grey;
    }
  }

  String _formatLastSeen(DateTime lastSeen) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${lastSeen.day}/${lastSeen.month}/${lastSeen.year}';
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<ZoniUserProfileData>('profile', profile));
    properties.add(EnumProperty<ZoniUserProfileVariant>('variant', variant));
    properties.add(DiagnosticsProperty<bool>('showStats', showStats));
    properties.add(DiagnosticsProperty<bool>('showBadges', showBadges));
    properties.add(DiagnosticsProperty<bool>('showStatus', showStatus));
    properties.add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
    properties.add(ObjectFlagProperty<VoidCallback?>.has('onEdit', onEdit));
  }
}

/// User profile display variants.
enum ZoniUserProfileVariant {
  /// Card variant with full information.
  card,

  /// Compact variant for lists.
  compact,

  /// Detailed variant with all information.
  detailed,
}
