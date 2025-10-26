import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for badge variants.
enum ZoniBadgeVariant {
  /// Default badge variant.
  primary,
  /// Secondary badge variant.
  secondary,
  /// Success badge variant.
  success,
  /// Warning badge variant.
  warning,
  /// Error badge variant.
  error,
  /// Info badge variant.
  info,
  /// Neutral badge variant.
  neutral,
}

/// Enum for badge sizes.
enum ZoniBadgeSize {
  /// Small badge size.
  small,
  /// Medium badge size.
  medium,
  /// Large badge size.
  large,
}

/// A badge widget that follows Zoni design system principles.
class ZoniBadge extends StatelessWidget {
  /// Creates a ZoniBadge.
  const ZoniBadge({
    required this.label,
    super.key,
    this.variant = ZoniBadgeVariant.primary,
    this.size = ZoniBadgeSize.medium,
    this.icon,
    this.onTap,
    this.onDelete,
  });

  /// Creates a small badge.
  const ZoniBadge.small({
    required this.label,
    super.key,
    this.variant = ZoniBadgeVariant.primary,
    this.icon,
    this.onTap,
    this.onDelete,
  }) : size = ZoniBadgeSize.small;

  /// Creates a large badge.
  const ZoniBadge.large({
    required this.label,
    super.key,
    this.variant = ZoniBadgeVariant.primary,
    this.icon,
    this.onTap,
    this.onDelete,
  }) : size = ZoniBadgeSize.large;

  /// The text to display in the badge.
  final String label;

  /// The badge variant.
  final ZoniBadgeVariant variant;

  /// The badge size.
  final ZoniBadgeSize size;

  /// Optional icon to display.
  final Widget? icon;

  /// Callback when the badge is tapped.
  final VoidCallback? onTap;

  /// Callback when the delete button is pressed.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final textStyle = _getTextStyle();
    final padding = _getPadding();
    final height = _getHeight();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(ZoniBorderRadius.full),
          border: Border.all(
            color: colors.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: colors.foregroundColor,
                  size: _getIconSize(),
                ),
                child: icon!,
              ),
              SizedBox(width: ZoniSpacing.xs),
            ],
            Text(
              label,
              style: textStyle.copyWith(color: colors.foregroundColor),
            ),
            if (onDelete != null) ...[
              SizedBox(width: ZoniSpacing.xs),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: _getIconSize(),
                  color: colors.foregroundColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  _BadgeColors _getColors() {
    switch (variant) {
      case ZoniBadgeVariant.primary:
        return _BadgeColors(
          backgroundColor: ZoniColors.primary,
          foregroundColor: ZoniColors.onPrimary,
          borderColor: ZoniColors.primary,
        );
      case ZoniBadgeVariant.secondary:
        return _BadgeColors(
          backgroundColor: ZoniColors.secondary,
          foregroundColor: ZoniColors.onSecondary,
          borderColor: ZoniColors.secondary,
        );
      case ZoniBadgeVariant.success:
        return _BadgeColors(
          backgroundColor: ZoniColors.success,
          foregroundColor: ZoniColors.onSuccess,
          borderColor: ZoniColors.success,
        );
      case ZoniBadgeVariant.warning:
        return _BadgeColors(
          backgroundColor: ZoniColors.warning,
          foregroundColor: ZoniColors.onWarning,
          borderColor: ZoniColors.warning,
        );
      case ZoniBadgeVariant.error:
        return _BadgeColors(
          backgroundColor: ZoniColors.error,
          foregroundColor: ZoniColors.onError,
          borderColor: ZoniColors.error,
        );
      case ZoniBadgeVariant.info:
        return _BadgeColors(
          backgroundColor: ZoniColors.info,
          foregroundColor: ZoniColors.onInfo,
          borderColor: ZoniColors.info,
        );
      case ZoniBadgeVariant.neutral:
        return _BadgeColors(
          backgroundColor: ZoniColors.surface,
          foregroundColor: ZoniColors.onSurface,
          borderColor: ZoniColors.outline,
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ZoniBadgeSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniBadgeSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniBadgeSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ZoniBadgeSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.xs,
          vertical: 2,
        );
      case ZoniBadgeSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniBadgeSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
    }
  }

  double _getHeight() {
    switch (size) {
      case ZoniBadgeSize.small:
        return 20;
      case ZoniBadgeSize.medium:
        return 24;
      case ZoniBadgeSize.large:
        return 32;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ZoniBadgeSize.small:
        return 12;
      case ZoniBadgeSize.medium:
        return 14;
      case ZoniBadgeSize.large:
        return 16;
    }
  }
}

class _BadgeColors {
  const _BadgeColors({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
}
