import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// Enum for alert variants
enum ZoniAlertVariant {
  info,
  success,
  warning,
  error,
}

/// Enum for alert sizes
enum ZoniAlertSize {
  small,
  medium,
  large,
}

/// A customizable alert component following Zoni design system.
///
/// The [ZoniAlert] widget provides an alert with consistent styling
/// and behavior across the application. It supports different variants,
/// sizes, and can be dismissible.
///
/// Example usage:
/// ```dart
/// ZoniAlert(
///   variant: ZoniAlertVariant.success,
///   title: 'Success!',
///   message: 'Your action was completed successfully.',
///   onDismiss: () => print('Alert dismissed'),
/// )
/// ```
class ZoniAlert extends StatelessWidget {
  /// Creates a Zoni alert.
  const ZoniAlert({
    super.key,
    required this.variant,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.size = ZoniAlertSize.medium,
    this.showIcon = true,
    this.isDismissible = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation = 0,
  });

  /// Creates an info alert.
  const ZoniAlert.info({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.size = ZoniAlertSize.medium,
    this.showIcon = true,
    this.isDismissible = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation = 0,
  }) : variant = ZoniAlertVariant.info;

  /// Creates a success alert.
  const ZoniAlert.success({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.size = ZoniAlertSize.medium,
    this.showIcon = true,
    this.isDismissible = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation = 0,
  }) : variant = ZoniAlertVariant.success;

  /// Creates a warning alert.
  const ZoniAlert.warning({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.size = ZoniAlertSize.medium,
    this.showIcon = true,
    this.isDismissible = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation = 0,
  }) : variant = ZoniAlertVariant.warning;

  /// Creates an error alert.
  const ZoniAlert.error({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actions,
    this.onDismiss,
    this.size = ZoniAlertSize.medium,
    this.showIcon = true,
    this.isDismissible = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation = 0,
  }) : variant = ZoniAlertVariant.error;

  /// The visual variant of the alert.
  final ZoniAlertVariant variant;

  /// The title of the alert.
  final String? title;

  /// The message content of the alert.
  final String? message;

  /// Custom icon for the alert.
  final Widget? icon;

  /// Action buttons for the alert.
  final List<Widget>? actions;

  /// Called when the alert is dismissed.
  final VoidCallback? onDismiss;

  /// The size of the alert.
  final ZoniAlertSize size;

  /// Whether to show the default icon.
  final bool showIcon;

  /// Whether the alert can be dismissed.
  final bool isDismissible;

  /// The background color of the alert.
  final Color? backgroundColor;

  /// The border color of the alert.
  final Color? borderColor;

  /// The text color of the alert.
  final Color? textColor;

  /// The icon color of the alert.
  final Color? iconColor;

  /// The padding inside the alert.
  final EdgeInsetsGeometry? padding;

  /// The margin around the alert.
  final EdgeInsetsGeometry? margin;

  /// The border radius of the alert.
  final BorderRadius? borderRadius;

  /// The elevation of the alert.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? _getBackgroundColor();
    final effectiveBorderColor = borderColor ?? _getBorderColor();
    final effectiveTextColor = textColor ?? _getTextColor();
    final effectiveIconColor = iconColor ?? _getIconColor();
    final effectivePadding = padding ?? _getPadding();
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(ZoniBorderRadius.md);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border.all(color: effectiveBorderColor),
        borderRadius: effectiveBorderRadius,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: elevation,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: effectivePadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showIcon || icon != null) ...[
              _buildIcon(effectiveIconColor),
              SizedBox(width: _getIconSpacing()),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: _getTitleStyle(effectiveTextColor),
                    ),
                    if (message != null) SizedBox(height: _getContentSpacing()),
                  ],
                  if (message != null)
                    Text(
                      message!,
                      style: _getMessageStyle(effectiveTextColor),
                    ),
                  if (actions != null && actions!.isNotEmpty) ...[
                    SizedBox(height: _getActionsSpacing()),
                    Wrap(
                      spacing: ZoniSpacing.sm,
                      children: actions!,
                    ),
                  ],
                ],
              ),
            ),
            if (isDismissible && onDismiss != null) ...[
              SizedBox(width: _getIconSpacing()),
              GestureDetector(
                onTap: onDismiss,
                child: Icon(
                  Icons.close,
                  size: _getCloseIconSize(),
                  color: effectiveIconColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color iconColor) {
    if (icon != null) {
      return IconTheme(
        data: IconThemeData(
          color: iconColor,
          size: _getIconSize(),
        ),
        child: icon!,
      );
    }

    return Icon(
      _getDefaultIcon(),
      color: iconColor,
      size: _getIconSize(),
    );
  }

  IconData _getDefaultIcon() {
    switch (variant) {
      case ZoniAlertVariant.info:
        return Icons.info_outline;
      case ZoniAlertVariant.success:
        return Icons.check_circle_outline;
      case ZoniAlertVariant.warning:
        return Icons.warning_amber_outlined;
      case ZoniAlertVariant.error:
        return Icons.error_outline;
    }
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case ZoniAlertVariant.info:
        return ZoniColors.info.withOpacity(0.1);
      case ZoniAlertVariant.success:
        return ZoniColors.success.withOpacity(0.1);
      case ZoniAlertVariant.warning:
        return ZoniColors.warning.withOpacity(0.1);
      case ZoniAlertVariant.error:
        return ZoniColors.error.withOpacity(0.1);
    }
  }

  Color _getBorderColor() {
    switch (variant) {
      case ZoniAlertVariant.info:
        return ZoniColors.info.withOpacity(0.3);
      case ZoniAlertVariant.success:
        return ZoniColors.success.withOpacity(0.3);
      case ZoniAlertVariant.warning:
        return ZoniColors.warning.withOpacity(0.3);
      case ZoniAlertVariant.error:
        return ZoniColors.error.withOpacity(0.3);
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case ZoniAlertVariant.info:
        return ZoniColors.infoDark;
      case ZoniAlertVariant.success:
        return ZoniColors.successDark;
      case ZoniAlertVariant.warning:
        return ZoniColors.warningDark;
      case ZoniAlertVariant.error:
        return ZoniColors.errorDark;
    }
  }

  Color _getIconColor() {
    switch (variant) {
      case ZoniAlertVariant.info:
        return ZoniColors.info;
      case ZoniAlertVariant.success:
        return ZoniColors.success;
      case ZoniAlertVariant.warning:
        return ZoniColors.warning;
      case ZoniAlertVariant.error:
        return ZoniColors.error;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ZoniAlertSize.small:
        return const EdgeInsets.all(ZoniSpacing.sm);
      case ZoniAlertSize.medium:
        return const EdgeInsets.all(ZoniSpacing.md);
      case ZoniAlertSize.large:
        return const EdgeInsets.all(ZoniSpacing.lg);
    }
  }

  double _getIconSize() {
    switch (size) {
      case ZoniAlertSize.small:
        return 16;
      case ZoniAlertSize.medium:
        return 20;
      case ZoniAlertSize.large:
        return 24;
    }
  }

  double _getCloseIconSize() {
    switch (size) {
      case ZoniAlertSize.small:
        return 14;
      case ZoniAlertSize.medium:
        return 18;
      case ZoniAlertSize.large:
        return 22;
    }
  }

  double _getIconSpacing() {
    switch (size) {
      case ZoniAlertSize.small:
        return ZoniSpacing.xs;
      case ZoniAlertSize.medium:
        return ZoniSpacing.sm;
      case ZoniAlertSize.large:
        return ZoniSpacing.md;
    }
  }

  double _getContentSpacing() {
    switch (size) {
      case ZoniAlertSize.small:
        return 2;
      case ZoniAlertSize.medium:
        return 4;
      case ZoniAlertSize.large:
        return 6;
    }
  }

  double _getActionsSpacing() {
    switch (size) {
      case ZoniAlertSize.small:
        return ZoniSpacing.sm;
      case ZoniAlertSize.medium:
        return ZoniSpacing.md;
      case ZoniAlertSize.large:
        return ZoniSpacing.lg;
    }
  }

  TextStyle _getTitleStyle(Color color) {
    switch (size) {
      case ZoniAlertSize.small:
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case ZoniAlertSize.medium:
        return TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case ZoniAlertSize.large:
        return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color,
        );
    }
  }

  TextStyle _getMessageStyle(Color color) {
    switch (size) {
      case ZoniAlertSize.small:
        return TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: color,
        );
      case ZoniAlertSize.medium:
        return TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: color,
        );
      case ZoniAlertSize.large:
        return TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: color,
        );
    }
  }
}
