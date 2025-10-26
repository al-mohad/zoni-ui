import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for tooltip variants.
enum ZoniTooltipVariant {
  /// Default tooltip variant.
  primary,

  /// Secondary tooltip variant.
  secondary,

  /// Success tooltip variant.
  success,

  /// Warning tooltip variant.
  warning,

  /// Error tooltip variant.
  error,

  /// Info tooltip variant.
  info,
}

/// Enum for tooltip sizes.
enum ZoniTooltipSize {
  /// Small tooltip size.
  small,

  /// Medium tooltip size.
  medium,

  /// Large tooltip size.
  large,
}

/// A customizable tooltip widget that follows Zoni design system principles.
class ZoniTooltip extends StatelessWidget {
  /// Creates a ZoniTooltip.
  const ZoniTooltip({
    required this.message,
    required this.child,
    super.key,
    this.variant = ZoniTooltipVariant.primary,
    this.size = ZoniTooltipSize.medium,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  });

  /// Creates a primary tooltip.
  const ZoniTooltip.primary({
    required this.message,
    required this.child,
    super.key,
    this.size = ZoniTooltipSize.medium,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  }) : variant = ZoniTooltipVariant.primary;

  /// Creates a success tooltip.
  const ZoniTooltip.success({
    required this.message,
    required this.child,
    super.key,
    this.size = ZoniTooltipSize.medium,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  }) : variant = ZoniTooltipVariant.success;

  /// Creates a warning tooltip.
  const ZoniTooltip.warning({
    required this.message,
    required this.child,
    super.key,
    this.size = ZoniTooltipSize.medium,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  }) : variant = ZoniTooltipVariant.warning;

  /// Creates an error tooltip.
  const ZoniTooltip.error({
    required this.message,
    required this.child,
    super.key,
    this.size = ZoniTooltipSize.medium,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  }) : variant = ZoniTooltipVariant.error;

  /// Creates an info tooltip.
  const ZoniTooltip.info({
    required this.message,
    required this.child,
    super.key,
    this.size = ZoniTooltipSize.medium,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  }) : variant = ZoniTooltipVariant.info;

  /// Creates a small tooltip.
  const ZoniTooltip.small({
    required this.message,
    required this.child,
    super.key,
    this.variant = ZoniTooltipVariant.primary,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  }) : size = ZoniTooltipSize.small;

  /// Creates a large tooltip.
  const ZoniTooltip.large({
    required this.message,
    required this.child,
    super.key,
    this.variant = ZoniTooltipVariant.primary,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.exitDuration,
    this.enableFeedback,
    this.onTriggered,
    this.triggerMode,
    this.enableTapToDismiss,
    this.richMessage,
  }) : size = ZoniTooltipSize.large;

  /// The text to display in the tooltip.
  final String message;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The tooltip variant.
  final ZoniTooltipVariant variant;

  /// The tooltip size.
  final ZoniTooltipSize size;

  /// The height of the tooltip.
  final double? height;

  /// The amount of space by which to inset the tooltip.
  final EdgeInsetsGeometry? padding;

  /// The empty space that surrounds the tooltip.
  final EdgeInsetsGeometry? margin;

  /// The vertical gap between the widget and the displayed tooltip.
  final double? verticalOffset;

  /// Whether the tooltip defaults to being displayed below the widget.
  final bool? preferBelow;

  /// Whether the tooltip's [message] should be excluded from the semantics tree.
  final bool? excludeFromSemantics;

  /// Provides a custom decoration for the tooltip.
  final Decoration? decoration;

  /// The style to use for the message of the tooltip.
  final TextStyle? textStyle;

  /// How the message of the tooltip is aligned horizontally.
  final TextAlign? textAlign;

  /// The length of time that a pointer must hover over a tooltip's widget before the tooltip will be shown.
  final Duration? waitDuration;

  /// The length of time that the tooltip will be shown after a long press is released.
  final Duration? showDuration;

  /// The length of time that a pointer must hover over a tooltip's widget before the tooltip will be hidden.
  final Duration? exitDuration;

  /// Whether the tooltip should provide acoustic and/or haptic feedback.
  final bool? enableFeedback;

  /// Called when the tooltip is triggered.
  final VoidCallback? onTriggered;

  /// The trigger mode for the tooltip.
  final TooltipTriggerMode? triggerMode;

  /// Whether the tooltip can be dismissed by tapping.
  final bool? enableTapToDismiss;

  /// A rich text message for the tooltip.
  final InlineSpan? richMessage;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      richMessage: richMessage,
      height: height ?? _getDefaultHeight(),
      padding: padding ?? _getDefaultPadding(),
      margin: margin ?? _getDefaultMargin(),
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: decoration ?? _getDefaultDecoration(),
      textStyle: textStyle ?? _getDefaultTextStyle(),
      textAlign: textAlign,
      waitDuration: waitDuration,
      showDuration: showDuration,
      exitDuration: exitDuration,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      triggerMode: triggerMode,
      enableTapToDismiss: enableTapToDismiss ?? false,
      child: child,
    );
  }

  double _getDefaultHeight() {
    switch (size) {
      case ZoniTooltipSize.small:
        return 24;
      case ZoniTooltipSize.medium:
        return 32;
      case ZoniTooltipSize.large:
        return 40;
    }
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    switch (size) {
      case ZoniTooltipSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.xs,
          vertical: ZoniSpacing.xs / 2,
        );
      case ZoniTooltipSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniTooltipSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
    }
  }

  EdgeInsetsGeometry _getDefaultMargin() {
    return const EdgeInsets.all(0);
  }

  Decoration _getDefaultDecoration() {
    Color backgroundColor;

    switch (variant) {
      case ZoniTooltipVariant.primary:
        backgroundColor = ZoniColors.primary;
        break;
      case ZoniTooltipVariant.secondary:
        backgroundColor = ZoniColors.secondary;
        break;
      case ZoniTooltipVariant.success:
        backgroundColor = ZoniColors.success;
        break;
      case ZoniTooltipVariant.warning:
        backgroundColor = ZoniColors.warning;
        break;
      case ZoniTooltipVariant.error:
        backgroundColor = ZoniColors.error;
        break;
      case ZoniTooltipVariant.info:
        backgroundColor = ZoniColors.info;
        break;
    }

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  TextStyle _getDefaultTextStyle() {
    Color textColor;

    switch (variant) {
      case ZoniTooltipVariant.primary:
        textColor = ZoniColors.onPrimary;
        break;
      case ZoniTooltipVariant.secondary:
        textColor = ZoniColors.onSecondary;
        break;
      case ZoniTooltipVariant.success:
        textColor = ZoniColors.onSuccess;
        break;
      case ZoniTooltipVariant.warning:
        textColor = ZoniColors.onWarning;
        break;
      case ZoniTooltipVariant.error:
        textColor = ZoniColors.onError;
        break;
      case ZoniTooltipVariant.info:
        textColor = ZoniColors.onInfo;
        break;
    }

    TextStyle baseStyle;
    switch (size) {
      case ZoniTooltipSize.small:
        baseStyle = ZoniTextStyles.labelSmall;
        break;
      case ZoniTooltipSize.medium:
        baseStyle = ZoniTextStyles.labelMedium;
        break;
      case ZoniTooltipSize.large:
        baseStyle = ZoniTextStyles.labelLarge;
        break;
    }

    return baseStyle.copyWith(color: textColor);
  }
}
