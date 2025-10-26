import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for progress indicator variants.
enum ZoniProgressVariant {
  /// Linear progress indicator.
  linear,
  /// Circular progress indicator.
  circular,
  /// Ring progress indicator.
  ring,
}

/// Enum for progress indicator sizes.
enum ZoniProgressSize {
  /// Small progress indicator.
  small,
  /// Medium progress indicator.
  medium,
  /// Large progress indicator.
  large,
}

/// A progress indicator widget that follows Zoni design system principles.
class ZoniProgress extends StatelessWidget {
  /// Creates a ZoniProgress.
  const ZoniProgress({
    super.key,
    this.value,
    this.variant = ZoniProgressVariant.linear,
    this.size = ZoniProgressSize.medium,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.semanticsLabel,
    this.semanticsValue,
    this.showLabel = false,
    this.label,
    this.minHeight,
  });

  /// Creates a linear progress indicator.
  const ZoniProgress.linear({
    super.key,
    this.value,
    this.size = ZoniProgressSize.medium,
    this.color,
    this.backgroundColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.showLabel = false,
    this.label,
    this.minHeight,
  }) : variant = ZoniProgressVariant.linear,
       strokeWidth = null;

  /// Creates a circular progress indicator.
  const ZoniProgress.circular({
    super.key,
    this.value,
    this.size = ZoniProgressSize.medium,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.semanticsLabel,
    this.semanticsValue,
    this.showLabel = false,
    this.label,
  }) : variant = ZoniProgressVariant.circular,
       minHeight = null;

  /// Creates a ring progress indicator.
  const ZoniProgress.ring({
    super.key,
    this.value,
    this.size = ZoniProgressSize.medium,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.semanticsLabel,
    this.semanticsValue,
    this.showLabel = false,
    this.label,
  }) : variant = ZoniProgressVariant.ring,
       minHeight = null;

  /// Creates a small progress indicator.
  const ZoniProgress.small({
    super.key,
    this.value,
    this.variant = ZoniProgressVariant.linear,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.semanticsLabel,
    this.semanticsValue,
    this.showLabel = false,
    this.label,
    this.minHeight,
  }) : size = ZoniProgressSize.small;

  /// Creates a large progress indicator.
  const ZoniProgress.large({
    super.key,
    this.value,
    this.variant = ZoniProgressVariant.linear,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.semanticsLabel,
    this.semanticsValue,
    this.showLabel = false,
    this.label,
    this.minHeight,
  }) : size = ZoniProgressSize.large;

  /// The progress value between 0.0 and 1.0. If null, shows indeterminate progress.
  final double? value;

  /// The progress indicator variant.
  final ZoniProgressVariant variant;

  /// The progress indicator size.
  final ZoniProgressSize size;

  /// The progress indicator color.
  final Color? color;

  /// The background color.
  final Color? backgroundColor;

  /// The stroke width for circular indicators.
  final double? strokeWidth;

  /// Semantic label for accessibility.
  final String? semanticsLabel;

  /// Semantic value for accessibility.
  final String? semanticsValue;

  /// Whether to show a label with the progress value.
  final bool showLabel;

  /// Custom label text. If null and showLabel is true, shows percentage.
  final String? label;

  /// Minimum height for linear progress indicators.
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? ZoniColors.primary;
    final effectiveBackgroundColor = backgroundColor ?? ZoniColors.surface;

    Widget progressWidget;

    switch (variant) {
      case ZoniProgressVariant.linear:
        progressWidget = LinearProgressIndicator(
          value: value,
          color: effectiveColor,
          backgroundColor: effectiveBackgroundColor,
          minHeight: minHeight ?? _getLinearHeight(),
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );
        break;
      case ZoniProgressVariant.circular:
        progressWidget = SizedBox(
          width: _getCircularSize(),
          height: _getCircularSize(),
          child: CircularProgressIndicator(
            value: value,
            color: effectiveColor,
            backgroundColor: effectiveBackgroundColor,
            strokeWidth: strokeWidth ?? _getStrokeWidth(),
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
          ),
        );
        break;
      case ZoniProgressVariant.ring:
        progressWidget = SizedBox(
          width: _getCircularSize(),
          height: _getCircularSize(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: 1.0,
                color: effectiveBackgroundColor,
                strokeWidth: strokeWidth ?? _getStrokeWidth(),
              ),
              CircularProgressIndicator(
                value: value,
                color: effectiveColor,
                backgroundColor: Colors.transparent,
                strokeWidth: strokeWidth ?? _getStrokeWidth(),
                semanticsLabel: semanticsLabel,
                semanticsValue: semanticsValue,
              ),
              if (showLabel && value != null)
                Text(
                  _getDisplayLabel(),
                  style: _getLabelStyle(),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        );
        break;
    }

    if (showLabel && variant == ZoniProgressVariant.linear) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Padding(
              padding: const EdgeInsets.only(bottom: ZoniSpacing.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: _getLabelStyle(),
                    ),
                  Text(
                    _getDisplayLabel(),
                    style: _getLabelStyle(),
                  ),
                ],
              ),
            ),
          progressWidget,
        ],
      );
    }

    return progressWidget;
  }

  double _getLinearHeight() {
    switch (size) {
      case ZoniProgressSize.small:
        return 2;
      case ZoniProgressSize.medium:
        return 4;
      case ZoniProgressSize.large:
        return 8;
    }
  }

  double _getCircularSize() {
    switch (size) {
      case ZoniProgressSize.small:
        return 16;
      case ZoniProgressSize.medium:
        return 24;
      case ZoniProgressSize.large:
        return 48;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case ZoniProgressSize.small:
        return 2;
      case ZoniProgressSize.medium:
        return 3;
      case ZoniProgressSize.large:
        return 4;
    }
  }

  TextStyle _getLabelStyle() {
    switch (size) {
      case ZoniProgressSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniProgressSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniProgressSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  String _getDisplayLabel() {
    if (label != null) return label!;
    if (value != null) {
      return '${(value! * 100).round()}%';
    }
    return '';
  }
}

/// A step progress indicator widget.
class ZoniStepProgress extends StatelessWidget {
  /// Creates a ZoniStepProgress.
  const ZoniStepProgress({
    required this.steps,
    required this.currentStep,
    super.key,
    this.size = ZoniProgressSize.medium,
    this.activeColor,
    this.inactiveColor,
    this.completedColor,
    this.showLabels = true,
    this.direction = Axis.horizontal,
  });

  /// The list of step labels.
  final List<String> steps;

  /// The current active step (0-based index).
  final int currentStep;

  /// The size of the step indicators.
  final ZoniProgressSize size;

  /// Color for the active step.
  final Color? activeColor;

  /// Color for inactive steps.
  final Color? inactiveColor;

  /// Color for completed steps.
  final Color? completedColor;

  /// Whether to show step labels.
  final bool showLabels;

  /// The direction of the step progress.
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? ZoniColors.primary;
    final effectiveInactiveColor = inactiveColor ?? ZoniColors.outline;
    final effectiveCompletedColor = completedColor ?? ZoniColors.success;

    if (direction == Axis.horizontal) {
      return Row(
        children: _buildSteps(
          effectiveActiveColor,
          effectiveInactiveColor,
          effectiveCompletedColor,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildSteps(
          effectiveActiveColor,
          effectiveInactiveColor,
          effectiveCompletedColor,
        ),
      );
    }
  }

  List<Widget> _buildSteps(
    Color activeColor,
    Color inactiveColor,
    Color completedColor,
  ) {
    final widgets = <Widget>[];

    for (int i = 0; i < steps.length; i++) {
      final isActive = i == currentStep;
      final isCompleted = i < currentStep;
      final isLast = i == steps.length - 1;

      Color stepColor;
      if (isCompleted) {
        stepColor = completedColor;
      } else if (isActive) {
        stepColor = activeColor;
      } else {
        stepColor = inactiveColor;
      }

      widgets.add(_buildStep(i, stepColor, isActive, isCompleted));

      if (!isLast) {
        widgets.add(_buildConnector(isCompleted ? completedColor : inactiveColor));
      }
    }

    return widgets;
  }

  Widget _buildStep(int index, Color color, bool isActive, bool isCompleted) {
    final stepSize = _getStepSize();
    
    Widget stepIndicator = Container(
      width: stepSize,
      height: stepSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isActive ? Border.all(color: color, width: 2) : null,
      ),
      child: Center(
        child: isCompleted
            ? Icon(
                Icons.check,
                size: stepSize * 0.6,
                color: ZoniColors.onSuccess,
              )
            : Text(
                '${index + 1}',
                style: _getStepTextStyle().copyWith(
                  color: isActive || isCompleted ? Colors.white : ZoniColors.onSurface,
                ),
              ),
      ),
    );

    if (!showLabels) return stepIndicator;

    if (direction == Axis.horizontal) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          stepIndicator,
          SizedBox(height: ZoniSpacing.xs),
          Text(
            steps[index],
            style: _getLabelTextStyle(),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          stepIndicator,
          SizedBox(width: ZoniSpacing.sm),
          Text(
            steps[index],
            style: _getLabelTextStyle(),
          ),
        ],
      );
    }
  }

  Widget _buildConnector(Color color) {
    if (direction == Axis.horizontal) {
      return Expanded(
        child: Container(
          height: 2,
          color: color,
          margin: const EdgeInsets.symmetric(horizontal: ZoniSpacing.xs),
        ),
      );
    } else {
      return Container(
        width: 2,
        height: ZoniSpacing.lg,
        color: color,
        margin: EdgeInsets.only(left: _getStepSize() / 2 - 1),
      );
    }
  }

  double _getStepSize() {
    switch (size) {
      case ZoniProgressSize.small:
        return 24;
      case ZoniProgressSize.medium:
        return 32;
      case ZoniProgressSize.large:
        return 40;
    }
  }

  TextStyle _getStepTextStyle() {
    switch (size) {
      case ZoniProgressSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniProgressSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniProgressSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  TextStyle _getLabelTextStyle() {
    switch (size) {
      case ZoniProgressSize.small:
        return ZoniTextStyles.bodySmall;
      case ZoniProgressSize.medium:
        return ZoniTextStyles.bodyMedium;
      case ZoniProgressSize.large:
        return ZoniTextStyles.bodyLarge;
    }
  }
}
