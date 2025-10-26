import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for slider sizes.
enum ZoniSliderSize {
  /// Small slider size.
  small,

  /// Medium slider size.
  medium,

  /// Large slider size.
  large,
}

/// Enum for slider variants.
enum ZoniSliderVariant {
  /// Continuous slider.
  continuous,

  /// Discrete slider with divisions.
  discrete,

  /// Range slider.
  range,
}

/// A slider widget that follows Zoni design system principles.
class ZoniSlider extends StatelessWidget {
  /// Creates a ZoniSlider.
  const ZoniSlider({
    required this.value,
    required this.onChanged,
    super.key,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
    this.size = ZoniSliderSize.medium,
    this.variant = ZoniSliderVariant.continuous,
    this.showLabel = false,
    this.showValue = false,
    this.prefix,
    this.suffix,
    this.isError = false,
    this.errorText,
    this.helperText,
  })  : rangeValues = null,
        onRangeChanged = null,
        onRangeChangeStart = null,
        onRangeChangeEnd = null;

  /// Creates a discrete slider.
  const ZoniSlider.discrete({
    required this.value,
    required this.onChanged,
    required this.divisions,
    super.key,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
    this.size = ZoniSliderSize.medium,
    this.showLabel = false,
    this.showValue = false,
    this.prefix,
    this.suffix,
    this.isError = false,
    this.errorText,
    this.helperText,
  })  : variant = ZoniSliderVariant.discrete,
        rangeValues = null,
        onRangeChanged = null,
        onRangeChangeStart = null,
        onRangeChangeEnd = null;

  /// Creates a range slider.
  const ZoniSlider.range({
    required this.rangeValues,
    required this.onRangeChanged,
    super.key,
    this.onRangeChangeStart,
    this.onRangeChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
    this.size = ZoniSliderSize.medium,
    this.showLabel = false,
    this.showValue = false,
    this.prefix,
    this.suffix,
    this.isError = false,
    this.errorText,
    this.helperText,
  })  : variant = ZoniSliderVariant.range,
        value = null,
        onChanged = null,
        onChangeStart = null,
        onChangeEnd = null,
        label = null;

  /// The currently selected value for the slider.
  final double? value;

  /// Called during a drag when the user is selecting a new value for the slider.
  final ValueChanged<double>? onChanged;

  /// Called when the user starts selecting a new value for the slider.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value for the slider.
  final ValueChanged<double>? onChangeEnd;

  /// The currently selected range for the range slider.
  final RangeValues? rangeValues;

  /// Called during a drag when the user is selecting new values for the range slider.
  final ValueChanged<RangeValues>? onRangeChanged;

  /// Called when the user starts selecting new values for the range slider.
  final ValueChanged<RangeValues>? onRangeChangeStart;

  /// Called when the user is done selecting new values for the range slider.
  final ValueChanged<RangeValues>? onRangeChangeEnd;

  /// The minimum value the user can select.
  final double min;

  /// The maximum value the user can select.
  final double max;

  /// The number of discrete divisions.
  final int? divisions;

  /// A label to show above the slider when the slider is active.
  final String? label;

  /// The color to use for the portion of the slider track that is active.
  final Color? activeColor;

  /// The color to use for the portion of the slider track that is inactive.
  final Color? inactiveColor;

  /// The color to use for the thumb.
  final Color? thumbColor;

  /// The color to use for the overlay.
  final Color? overlayColor;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// The callback used to create a semantic value from a slider value.
  final SemanticFormatterCallback? semanticFormatterCallback;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  final bool autofocus;

  /// The size of the slider.
  final ZoniSliderSize size;

  /// The variant of the slider.
  final ZoniSliderVariant variant;

  /// Whether to show a label above the slider.
  final bool showLabel;

  /// Whether to show the current value.
  final bool showValue;

  /// Optional prefix widget.
  final Widget? prefix;

  /// Optional suffix widget.
  final Widget? suffix;

  /// Whether the slider is in an error state.
  final bool isError;

  /// Error text to display below the slider.
  final String? errorText;

  /// Helper text to display below the slider.
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final Color effectiveActiveColor =
        activeColor ?? (isError ? ZoniColors.error : ZoniColors.primary);
    final Color effectiveInactiveColor = inactiveColor ?? ZoniColors.outline;
    final Color effectiveThumbColor = thumbColor ?? effectiveActiveColor;

    Widget slider;

    switch (variant) {
      case ZoniSliderVariant.continuous:
      case ZoniSliderVariant.discrete:
        slider = Slider(
          value: value!,
          onChanged: onChanged,
          onChangeStart: onChangeStart,
          onChangeEnd: onChangeEnd,
          min: min,
          max: max,
          divisions: divisions,
          label: label,
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          thumbColor: effectiveThumbColor,
          overlayColor: overlayColor != null
              ? WidgetStateProperty.all(overlayColor)
              : null,
          mouseCursor: mouseCursor,
          semanticFormatterCallback: semanticFormatterCallback,
          focusNode: focusNode,
          autofocus: autofocus,
        );
        break;
      case ZoniSliderVariant.range:
        slider = RangeSlider(
          values: rangeValues!,
          onChanged: onRangeChanged,
          onChangeStart: onRangeChangeStart,
          onChangeEnd: onRangeChangeEnd,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          overlayColor: overlayColor != null
              ? WidgetStateProperty.all(overlayColor)
              : null,
          mouseCursor:
              mouseCursor != null ? WidgetStateProperty.all(mouseCursor) : null,
          semanticFormatterCallback: semanticFormatterCallback,
        );
        break;
    }

    // Wrap with prefix/suffix if provided
    if (prefix != null || suffix != null) {
      slider = Row(
        children: <Widget>[
          if (prefix != null) ...<Widget>[
            prefix!,
            const SizedBox(width: ZoniSpacing.sm),
          ],
          Expanded(child: slider),
          if (suffix != null) ...<Widget>[
            const SizedBox(width: ZoniSpacing.sm),
            suffix!,
          ],
        ],
      );
    }

    // Add value display if requested
    if (showValue) {
      String valueText;
      if (variant == ZoniSliderVariant.range) {
        valueText =
            '${rangeValues!.start.toStringAsFixed(1)} - ${rangeValues!.end.toStringAsFixed(1)}';
      } else {
        valueText = value!.toStringAsFixed(1);
      }

      slider = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (showLabel && label != null)
                Text(
                  label!,
                  style: _getLabelTextStyle().copyWith(
                    color: isError ? ZoniColors.error : ZoniColors.onSurface,
                  ),
                ),
              Text(
                valueText,
                style: _getValueTextStyle().copyWith(
                  color: isError ? ZoniColors.error : ZoniColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: ZoniSpacing.xs),
          slider,
        ],
      );
    } else if (showLabel && label != null) {
      slider = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label!,
            style: _getLabelTextStyle().copyWith(
              color: isError ? ZoniColors.error : ZoniColors.onSurface,
            ),
          ),
          const SizedBox(height: ZoniSpacing.xs),
          slider,
        ],
      );
    }

    // Add helper/error text
    if (errorText != null || helperText != null) {
      slider = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          slider,
          const SizedBox(height: ZoniSpacing.xs),
          Text(
            errorText ?? helperText!,
            style: _getHelperTextStyle().copyWith(
              color: errorText != null
                  ? ZoniColors.error
                  : ZoniColors.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      );
    }

    return slider;
  }

  TextStyle _getLabelTextStyle() {
    switch (size) {
      case ZoniSliderSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniSliderSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniSliderSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  TextStyle _getValueTextStyle() {
    switch (size) {
      case ZoniSliderSize.small:
        return ZoniTextStyles.bodySmall;
      case ZoniSliderSize.medium:
        return ZoniTextStyles.bodyMedium;
      case ZoniSliderSize.large:
        return ZoniTextStyles.bodyLarge;
    }
  }

  TextStyle _getHelperTextStyle() {
    switch (size) {
      case ZoniSliderSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniSliderSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniSliderSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

}
