import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// The state of a step in the stepper.
enum ZoniStepState {
  /// The step is inactive.
  inactive,
  /// The step is active.
  active,
  /// The step is completed.
  completed,
  /// The step has an error.
  error,
  /// The step is disabled.
  disabled,
}

/// The orientation of the stepper.
enum ZoniStepperOrientation {
  /// Horizontal orientation.
  horizontal,
  /// Vertical orientation.
  vertical,
}

/// The size of the stepper.
enum ZoniStepperSize {
  /// Small size.
  small,
  /// Medium size.
  medium,
  /// Large size.
  large,
}

/// A single step in the stepper.
class ZoniStep {
  /// Creates a step.
  const ZoniStep({
    required this.title,
    this.subtitle,
    this.content,
    this.icon,
    this.state = ZoniStepState.inactive,
    this.isOptional = false,
    this.onTap,
  });

  /// The title of the step.
  final Widget title;
  /// The subtitle of the step.
  final Widget? subtitle;
  /// The content of the step.
  final Widget? content;
  /// The icon of the step.
  final Widget? icon;
  /// The state of the step.
  final ZoniStepState state;
  /// Whether the step is optional.
  final bool isOptional;
  /// Callback when the step is tapped.
  final VoidCallback? onTap;
}

/// A stepper widget that displays a sequence of steps.
class ZoniStepper extends StatefulWidget {
  /// Creates a stepper.
  const ZoniStepper({
    required this.steps,
    super.key,
    this.currentStep = 0,
    this.orientation = ZoniStepperOrientation.vertical,
    this.size = ZoniStepperSize.medium,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.physics,
    this.margin,
    this.connectorColor,
    this.connectorThickness,
    this.stepIconSize,
    this.stepNumberStyle,
    this.stepTitleStyle,
    this.stepSubtitleStyle,
    this.activeColor,
    this.inactiveColor,
    this.completedColor,
    this.errorColor,
    this.disabledColor,
  });

  /// The steps to display.
  final List<ZoniStep> steps;
  /// The current step index.
  final int currentStep;
  /// The orientation of the stepper.
  final ZoniStepperOrientation orientation;
  /// The size of the stepper.
  final ZoniStepperSize size;
  /// Callback when a step is tapped.
  final void Function(int step)? onStepTapped;
  /// Callback for the continue button.
  final VoidCallback? onStepContinue;
  /// Callback for the cancel button.
  final VoidCallback? onStepCancel;
  /// Builder for custom controls.
  final Widget Function(BuildContext context, ControlsDetails details)? controlsBuilder;
  /// The scroll physics for the stepper.
  final ScrollPhysics? physics;
  /// The margin around the stepper.
  final EdgeInsets? margin;
  /// The color of the connectors.
  final Color? connectorColor;
  /// The thickness of the connectors.
  final double? connectorThickness;
  /// The size of the step icons.
  final double? stepIconSize;
  /// The text style for step numbers.
  final TextStyle? stepNumberStyle;
  /// The text style for step titles.
  final TextStyle? stepTitleStyle;
  /// The text style for step subtitles.
  final TextStyle? stepSubtitleStyle;
  /// The color for active steps.
  final Color? activeColor;
  /// The color for inactive steps.
  final Color? inactiveColor;
  /// The color for completed steps.
  final Color? completedColor;
  /// The color for error steps.
  final Color? errorColor;
  /// The color for disabled steps.
  final Color? disabledColor;

  @override
  State<ZoniStepper> createState() => _ZoniStepperState();
}

class _ZoniStepperState extends State<ZoniStepper> {
  double get _stepIconSize {
    switch (widget.size) {
      case ZoniStepperSize.small:
        return widget.stepIconSize ?? 32;
      case ZoniStepperSize.medium:
        return widget.stepIconSize ?? 40;
      case ZoniStepperSize.large:
        return widget.stepIconSize ?? 48;
    }
  }

  double get _connectorThickness {
    switch (widget.size) {
      case ZoniStepperSize.small:
        return widget.connectorThickness ?? 1;
      case ZoniStepperSize.medium:
        return widget.connectorThickness ?? 2;
      case ZoniStepperSize.large:
        return widget.connectorThickness ?? 3;
    }
  }

  EdgeInsets get _stepMargin {
    switch (widget.size) {
      case ZoniStepperSize.small:
        return const EdgeInsets.symmetric(vertical: 4);
      case ZoniStepperSize.medium:
        return const EdgeInsets.symmetric(vertical: 8);
      case ZoniStepperSize.large:
        return const EdgeInsets.symmetric(vertical: 12);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: widget.orientation == ZoniStepperOrientation.horizontal
          ? _buildHorizontalStepper()
          : _buildVerticalStepper(),
    );
  }

  Widget _buildHorizontalStepper() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: widget.physics,
      child: Row(
        children: [
          for (int i = 0; i < widget.steps.length; i++) ...[
            Column(
              children: [
                _buildStepIcon(widget.steps[i], i),
                const SizedBox(height: 8),
                _buildStepContent(widget.steps[i], i, context),
              ],
            ),
            if (i < widget.steps.length - 1) _buildHorizontalConnector(),
          ],
        ],
      ),
    );
  }

  Widget _buildVerticalStepper() {
    return SingleChildScrollView(
      physics: widget.physics,
      child: Column(
        children: [
          for (int i = 0; i < widget.steps.length; i++)
            Container(
              margin: _stepMargin,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      _buildStepIcon(widget.steps[i], i),
                      _buildConnector(i == widget.steps.length - 1),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStepContent(widget.steps[i], i, context),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepContent(ZoniStep step, int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: widget.stepTitleStyle ?? ZoniTextStyles.titleMedium,
          child: step.title,
        ),
        if (step.subtitle != null) ...[
          const SizedBox(height: 4),
          DefaultTextStyle(
            style: widget.stepSubtitleStyle ?? ZoniTextStyles.bodyMedium.copyWith(
              color: ZoniColors.onSurfaceVariant,
            ),
            child: step.subtitle!,
          ),
        ],
        if (step.content != null && step.state == ZoniStepState.active) ...[
          const SizedBox(height: 12),
          step.content!,
          if (widget.controlsBuilder != null) ...[
            const SizedBox(height: 12),
            widget.controlsBuilder!(
              context,
              ControlsDetails(
                stepIndex: index,
                onStepContinue: widget.onStepContinue,
                onStepCancel: widget.onStepCancel,
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildStepIcon(ZoniStep step, int index) {
    final Color stepColor = _getStepColor(step);
    final Widget iconContent = step.icon ??
        (step.state == ZoniStepState.completed
            ? Icon(
                Icons.check,
                size: _stepIconSize * 0.6,
                color: ZoniColors.onPrimary,
              )
            : step.state == ZoniStepState.error
                ? Icon(
                    Icons.close,
                    size: _stepIconSize * 0.6,
                    color: ZoniColors.onError,
                  )
                : Text(
                    '${index + 1}',
                    style: widget.stepNumberStyle ??
                        ZoniTextStyles.labelLarge.copyWith(
                          color: step.state == ZoniStepState.active ||
                                  step.state == ZoniStepState.completed
                              ? ZoniColors.onPrimary
                              : stepColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ));

    return Container(
      width: _stepIconSize,
      height: _stepIconSize,
      decoration: BoxDecoration(
        color: step.state == ZoniStepState.active ||
                step.state == ZoniStepState.completed
            ? stepColor
            : Colors.transparent,
        shape: BoxShape.circle,
        border: step.state == ZoniStepState.inactive
            ? Border.all(color: stepColor, width: 2)
            : null,
      ),
      child: Center(child: iconContent),
    );
  }

  Widget _buildConnector(bool isLast) {
    if (isLast) return const SizedBox.shrink();

    final Color color = widget.connectorColor ?? ZoniColors.outline;
    final double thickness = _connectorThickness;

    return Container(
      width: thickness,
      height: 40,
      color: color,
    );
  }

  Widget _buildHorizontalConnector() {
    final Color color = widget.connectorColor ?? ZoniColors.outline;
    final double thickness = _connectorThickness;

    return Container(
      width: 40,
      height: thickness,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: color,
    );
  }

  Color _getStepColor(ZoniStep step) {
    switch (step.state) {
      case ZoniStepState.active:
        return widget.activeColor ?? ZoniColors.primary;
      case ZoniStepState.completed:
        return widget.completedColor ?? ZoniColors.primary;
      case ZoniStepState.error:
        return widget.errorColor ?? ZoniColors.error;
      case ZoniStepState.disabled:
        return widget.disabledColor ?? ZoniColors.onSurfaceVariant;
      case ZoniStepState.inactive:
        return widget.inactiveColor ?? ZoniColors.outline;
    }
  }
}

/// Details for the controls builder.
class ControlsDetails {
  /// Creates controls details.
  const ControlsDetails({
    required this.stepIndex,
    this.onStepContinue,
    this.onStepCancel,
  });

  /// Index of the current step.
  final int stepIndex;
  /// Callback for the continue button.
  final VoidCallback? onStepContinue;
  /// Callback for the cancel button.
  final VoidCallback? onStepCancel;
}
