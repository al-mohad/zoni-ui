import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// Enum for checkbox sizes
enum ZoniCheckboxSize {
  small,
  medium,
  large,
}

/// Enum for checkbox variants
enum ZoniCheckboxVariant {
  primary,
  secondary,
  success,
  warning,
  error,
}

/// A checkbox that follows Zoni design system principles.
class ZoniCheckbox extends StatelessWidget {
  /// Creates a ZoniCheckbox.
  const ZoniCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = ZoniCheckboxSize.medium,
    this.variant = ZoniCheckboxVariant.primary,
    this.tristate = false,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.semanticLabel,
  });

  /// Whether this checkbox is checked.
  final bool? value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool?>? onChanged;

  /// The size of the checkbox.
  final ZoniCheckboxSize size;

  /// The variant of the checkbox.
  final ZoniCheckboxVariant variant;

  /// If true, the checkbox's value can be true, false, or null.
  final bool tristate;

  /// The color to use when this checkbox is checked.
  final Color? activeColor;

  /// The color to use for the check icon when this checkbox is checked.
  final Color? checkColor;

  /// The color for the checkbox's focus indicator.
  final Color? focusColor;

  /// The color for the checkbox's hover indicator.
  final Color? hoverColor;

  /// The color for the checkbox's overlay.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The splash radius of the checkbox.
  final double? splashRadius;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Defines how compact the checkbox's layout will be.
  final VisualDensity? visualDensity;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  final bool autofocus;

  /// The shape of the checkbox.
  final OutlinedBorder? shape;

  /// The color and width of the checkbox's border.
  final BorderSide? side;

  /// True if this checkbox wants to show an error state.
  final bool isError;

  /// Semantic label for the checkbox.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _getScale(),
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        tristate: tristate,
        activeColor: activeColor ?? _getActiveColor(),
        checkColor: checkColor ?? _getCheckColor(),
        focusColor: focusColor,
        hoverColor: hoverColor,
        overlayColor: overlayColor,
        splashRadius: splashRadius,
        materialTapTargetSize: materialTapTargetSize,
        visualDensity: visualDensity,
        focusNode: focusNode,
        autofocus: autofocus,
        shape: shape,
        side: side,
        semanticLabel: semanticLabel,
      ),
    );
  }

  double _getScale() {
    switch (size) {
      case ZoniCheckboxSize.small:
        return 0.8;
      case ZoniCheckboxSize.medium:
        return 1.0;
      case ZoniCheckboxSize.large:
        return 1.2;
    }
  }

  Color _getActiveColor() {
    switch (variant) {
      case ZoniCheckboxVariant.primary:
        return ZoniColors.primary;
      case ZoniCheckboxVariant.secondary:
        return ZoniColors.secondary;
      case ZoniCheckboxVariant.success:
        return ZoniColors.success;
      case ZoniCheckboxVariant.warning:
        return ZoniColors.warning;
      case ZoniCheckboxVariant.error:
        return ZoniColors.error;
    }
  }

  Color _getCheckColor() {
    return ZoniColors.onPrimary;
  }
}
