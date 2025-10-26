import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// Enum for radio button sizes
enum ZoniRadioSize {
  small,
  medium,
  large,
}

/// Enum for radio button variants
enum ZoniRadioVariant {
  primary,
  secondary,
  success,
  warning,
  error,
}

/// A customizable radio button component following Zoni design system.
///
/// The [ZoniRadio] widget provides a radio button with consistent styling
/// and behavior across the application. It supports different sizes,
/// variants, and states.
///
/// Example usage:
/// ```dart
/// ZoniRadio<String>(
///   value: 'option1',
///   groupValue: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   title: Text('Option 1'),
/// )
/// ```
class ZoniRadio<T> extends StatelessWidget {
  /// Creates a Zoni radio button.
  const ZoniRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.size = ZoniRadioSize.medium,
    this.variant = ZoniRadioVariant.primary,
    this.isEnabled = true,
    this.autofocus = false,
    this.focusNode,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.mouseCursor,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for the group of radio buttons.
  final T? groupValue;

  /// Called when the user selects this radio button.
  final ValueChanged<T?>? onChanged;

  /// The primary content of the radio button.
  final Widget? title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// The size of the radio button.
  final ZoniRadioSize size;

  /// The visual variant of the radio button.
  final ZoniRadioVariant variant;

  /// Whether the radio button is enabled.
  final bool isEnabled;

  /// Whether this radio button should focus itself if nothing else is already focused.
  final bool autofocus;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// Set to true if this radio button is allowed to be returned to an indeterminate state.
  final bool toggleable;

  /// The color to use when this radio button is selected.
  final Color? activeColor;

  /// The color that fills the radio button.
  final WidgetStateProperty<Color?>? fillColor;

  /// The color for the radio button's hover state.
  final Color? hoverColor;

  /// The color for the radio button's overlay.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The splash radius of the circular Material ink response.
  final double? splashRadius;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Defines how compact the radio button's layout will be.
  final VisualDensity? visualDensity;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// Whether this radio button is selected.
  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? _getActiveColor();
    final effectiveFillColor = fillColor ?? _getFillColor();
    final effectiveOverlayColor = overlayColor ?? _getOverlayColor();

    final radio = Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: isEnabled ? onChanged : null,
      autofocus: autofocus,
      focusNode: focusNode,
      toggleable: toggleable,
      activeColor: effectiveActiveColor,
      fillColor: effectiveFillColor,
      hoverColor: hoverColor,
      overlayColor: effectiveOverlayColor,
      splashRadius: splashRadius ?? _getSplashRadius(),
      materialTapTargetSize: materialTapTargetSize,
      visualDensity: visualDensity ?? _getVisualDensity(),
      mouseCursor: mouseCursor,
    );

    if (title == null && subtitle == null) {
      return radio;
    }

    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      onChanged: isEnabled ? onChanged : null,
      title: title,
      subtitle: subtitle,
      autofocus: autofocus,
      focusNode: focusNode,
      toggleable: toggleable,
      activeColor: effectiveActiveColor,
      hoverColor: hoverColor,
      overlayColor: effectiveOverlayColor,
      splashRadius: splashRadius ?? _getSplashRadius(),
      materialTapTargetSize: materialTapTargetSize,
      visualDensity: visualDensity ?? _getVisualDensity(),
      mouseCursor: mouseCursor,
      dense: size == ZoniRadioSize.small,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Color _getActiveColor() {
    switch (variant) {
      case ZoniRadioVariant.primary:
        return ZoniColors.primary;
      case ZoniRadioVariant.secondary:
        return ZoniColors.secondary;
      case ZoniRadioVariant.success:
        return ZoniColors.success;
      case ZoniRadioVariant.warning:
        return ZoniColors.warning;
      case ZoniRadioVariant.error:
        return ZoniColors.error;
    }
  }

  WidgetStateProperty<Color?> _getFillColor() {
    final activeColor = _getActiveColor();
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return ZoniColors.onSurface.withOpacity(0.38);
      }
      if (states.contains(WidgetState.selected)) {
        return activeColor;
      }
      return ZoniColors.onSurface.withOpacity(0.54);
    });
  }

  WidgetStateProperty<Color?> _getOverlayColor() {
    final activeColor = _getActiveColor();
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return activeColor.withOpacity(0.12);
      }
      if (states.contains(WidgetState.hovered)) {
        return activeColor.withOpacity(0.08);
      }
      if (states.contains(WidgetState.focused)) {
        return activeColor.withOpacity(0.12);
      }
      return null;
    });
  }

  double _getSplashRadius() {
    switch (size) {
      case ZoniRadioSize.small:
        return 16;
      case ZoniRadioSize.medium:
        return 20;
      case ZoniRadioSize.large:
        return 24;
    }
  }

  VisualDensity _getVisualDensity() {
    switch (size) {
      case ZoniRadioSize.small:
        return VisualDensity.compact;
      case ZoniRadioSize.medium:
        return VisualDensity.standard;
      case ZoniRadioSize.large:
        return VisualDensity.comfortable;
    }
  }
}

/// A group of radio buttons with consistent styling.
class ZoniRadioGroup<T> extends StatelessWidget {
  /// Creates a group of radio buttons.
  const ZoniRadioGroup({
    super.key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    this.size = ZoniRadioSize.medium,
    this.variant = ZoniRadioVariant.primary,
    this.isEnabled = true,
    this.direction = Axis.vertical,
    this.spacing = ZoniSpacing.sm,
    this.runSpacing = ZoniSpacing.sm,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.center,
  });

  /// The list of radio button options.
  final List<ZoniRadioOption<T>> options;

  /// The currently selected value.
  final T? groupValue;

  /// Called when the user selects a radio button.
  final ValueChanged<T?> onChanged;

  /// The size of all radio buttons in the group.
  final ZoniRadioSize size;

  /// The variant of all radio buttons in the group.
  final ZoniRadioVariant variant;

  /// Whether all radio buttons in the group are enabled.
  final bool isEnabled;

  /// The direction to lay out the radio buttons.
  final Axis direction;

  /// The spacing between radio buttons.
  final double spacing;

  /// The spacing between runs when wrapping.
  final double runSpacing;

  /// How the radio buttons should be aligned.
  final WrapAlignment alignment;

  /// How the radio buttons should be aligned cross-axis.
  final WrapCrossAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final children = options.map((option) {
      return ZoniRadio<T>(
        value: option.value,
        groupValue: groupValue,
        onChanged: isEnabled && option.isEnabled ? onChanged : null,
        title: option.title,
        subtitle: option.subtitle,
        size: size,
        variant: variant,
      );
    }).toList();

    if (direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
            .expand((child) => [child, SizedBox(height: spacing)])
            .take(children.length * 2 - 1)
            .toList(),
      );
    }

    return Wrap(
      direction: direction,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}

/// Represents an option in a radio group.
class ZoniRadioOption<T> {
  /// Creates a radio option.
  const ZoniRadioOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.isEnabled = true,
  });

  /// The value of this option.
  final T value;

  /// The title widget for this option.
  final Widget title;

  /// The subtitle widget for this option.
  final Widget? subtitle;

  /// Whether this option is enabled.
  final bool isEnabled;
}
