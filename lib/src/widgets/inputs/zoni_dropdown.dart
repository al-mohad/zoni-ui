import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for dropdown sizes.
enum ZoniDropdownSize {
  /// Small dropdown size.
  small,
  /// Medium dropdown size.
  medium,
  /// Large dropdown size.
  large,
}

/// Enum for dropdown variants.
enum ZoniDropdownVariant {
  /// Standard dropdown variant.
  standard,
  /// Outlined dropdown variant.
  outlined,
  /// Filled dropdown variant.
  filled,
}

/// A dropdown widget that follows Zoni design system principles.
class ZoniDropdown<T> extends StatelessWidget {
  /// Creates a ZoniDropdown.
  const ZoniDropdown({
    required this.items,
    required this.onChanged,
    super.key,
    this.value,
    this.hint,
    this.disabledHint,
    this.elevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.padding,
    this.size = ZoniDropdownSize.medium,
    this.variant = ZoniDropdownVariant.outlined,
    this.label,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.filled = false,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.fillColor,
    this.hoverColor,
  });

  /// Creates an outlined dropdown.
  const ZoniDropdown.outlined({
    required this.items,
    required this.onChanged,
    super.key,
    this.value,
    this.hint,
    this.disabledHint,
    this.elevation = 8,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.padding,
    this.size = ZoniDropdownSize.medium,
    this.label,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.fillColor,
    this.hoverColor,
  }) : variant = ZoniDropdownVariant.outlined,
       underline = const SizedBox(),
       filled = false;

  /// Creates a filled dropdown.
  const ZoniDropdown.filled({
    required this.items,
    required this.onChanged,
    super.key,
    this.value,
    this.hint,
    this.disabledHint,
    this.elevation = 8,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.padding,
    this.size = ZoniDropdownSize.medium,
    this.label,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.fillColor,
    this.hoverColor,
  }) : variant = ZoniDropdownVariant.filled,
       underline = const SizedBox(),
       filled = true;

  /// The list of items the user can select.
  final List<DropdownMenuItem<T>>? items;

  /// Called when the user selects an item.
  final ValueChanged<T?>? onChanged;

  /// The value of the currently selected item.
  final T? value;

  /// A placeholder widget that is displayed by the dropdown button.
  final Widget? hint;

  /// A message to show when the dropdown is disabled.
  final Widget? disabledHint;

  /// The z-coordinate at which to place the menu when open.
  final int elevation;

  /// The text style to use for text in the dropdown button and the dropdown menu.
  final TextStyle? style;

  /// The widget to use for drawing the drop-down button's underline.
  final Widget? underline;

  /// The widget to use for the drop-down button's icon.
  final Widget? icon;

  /// The color of any Icon descendant of icon if this button is disabled.
  final Color? iconDisabledColor;

  /// The color of any Icon descendant of icon if this button is enabled.
  final Color? iconEnabledColor;

  /// The size to use for the drop-down button's down arrow icon button.
  final double iconSize;

  /// Reduce the button's height.
  final bool isDense;

  /// Set the dropdown's inner contents to horizontally fill its parent.
  final bool isExpanded;

  /// If null, then the menu item heights will vary according to each menu item's intrinsic height.
  final double? itemHeight;

  /// The color for the button's Material when it has the input focus.
  final Color? focusColor;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  final bool autofocus;

  /// The background color of the dropdown.
  final Color? dropdownColor;

  /// The maximum height of the menu.
  final double? menuMaxHeight;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  final bool? enableFeedback;

  /// How to align the hint or the selected item when the button is collapsed.
  final AlignmentGeometry alignment;

  /// The border radius of the dropdown button.
  final BorderRadius? borderRadius;

  /// The padding of the dropdown button.
  final EdgeInsetsGeometry? padding;

  /// The size of the dropdown.
  final ZoniDropdownSize size;

  /// The variant of the dropdown.
  final ZoniDropdownVariant variant;

  /// The label text for the dropdown.
  final String? label;

  /// Helper text to display below the dropdown.
  final String? helperText;

  /// Error text to display below the dropdown.
  final String? errorText;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  /// An icon that appears after the editable part of the text field.
  final Widget? suffixIcon;

  /// Whether the dropdown is enabled.
  final bool enabled;

  /// Whether the dropdown should be filled.
  final bool filled;

  /// The padding for the input decoration's container.
  final EdgeInsetsGeometry? contentPadding;

  /// The border to display when the dropdown is enabled and not focused.
  final InputBorder? border;

  /// The border to display when the dropdown is enabled and not focused.
  final InputBorder? enabledBorder;

  /// The border to display when the dropdown is focused.
  final InputBorder? focusedBorder;

  /// The border to display when the dropdown has an error.
  final InputBorder? errorBorder;

  /// The border to display when the dropdown is focused and has an error.
  final InputBorder? focusedErrorBorder;

  /// The border to display when the dropdown is disabled.
  final InputBorder? disabledBorder;

  /// The base fill color of the decoration.
  final Color? fillColor;

  /// The color to use when the dropdown is hovered.
  final Color? hoverColor;

  @override
  Widget build(BuildContext context) {
    final isError = errorText != null;
    final effectiveStyle = style ?? _getDefaultTextStyle();
    final effectiveContentPadding = contentPadding ?? _getDefaultContentPadding();

    Widget dropdown = DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      hint: hint,
      disabledHint: disabledHint,
      elevation: elevation,
      style: effectiveStyle,
      icon: icon ?? _getDefaultIcon(),
      iconDisabledColor: iconDisabledColor ?? ZoniColors.onSurface.withOpacity(0.3),
      iconEnabledColor: iconEnabledColor ?? ZoniColors.onSurface,
      iconSize: iconSize,
      isDense: isDense,
      isExpanded: isExpanded,
      itemHeight: itemHeight,
      focusColor: focusColor,
      focusNode: focusNode,
      autofocus: autofocus,
      dropdownColor: dropdownColor ?? ZoniColors.surface,
      menuMaxHeight: menuMaxHeight,
      enableFeedback: enableFeedback,
      alignment: alignment,
      borderRadius: borderRadius ?? BorderRadius.circular(ZoniBorderRadius.sm),
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabled: enabled,
        filled: filled || variant == ZoniDropdownVariant.filled,
        fillColor: fillColor ?? _getDefaultFillColor(),
        hoverColor: hoverColor,
        contentPadding: effectiveContentPadding,
        border: border ?? _getDefaultBorder(),
        enabledBorder: enabledBorder ?? _getDefaultEnabledBorder(),
        focusedBorder: focusedBorder ?? _getDefaultFocusedBorder(),
        errorBorder: errorBorder ?? _getDefaultErrorBorder(),
        focusedErrorBorder: focusedErrorBorder ?? _getDefaultFocusedErrorBorder(),
        disabledBorder: disabledBorder ?? _getDefaultDisabledBorder(),
        labelStyle: _getDefaultLabelStyle(),
        helperStyle: _getDefaultHelperStyle(),
        errorStyle: _getDefaultErrorStyle(),
      ),
    );

    return dropdown;
  }

  Widget _getDefaultIcon() {
    return Icon(
      Icons.arrow_drop_down,
      size: iconSize,
    );
  }

  TextStyle _getDefaultTextStyle() {
    switch (size) {
      case ZoniDropdownSize.small:
        return ZoniTextStyles.bodySmall;
      case ZoniDropdownSize.medium:
        return ZoniTextStyles.bodyMedium;
      case ZoniDropdownSize.large:
        return ZoniTextStyles.bodyLarge;
    }
  }

  TextStyle _getDefaultLabelStyle() {
    switch (size) {
      case ZoniDropdownSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniDropdownSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniDropdownSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  TextStyle _getDefaultHelperStyle() {
    switch (size) {
      case ZoniDropdownSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniDropdownSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniDropdownSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  TextStyle _getDefaultErrorStyle() {
    return _getDefaultHelperStyle().copyWith(color: ZoniColors.error);
  }

  EdgeInsetsGeometry _getDefaultContentPadding() {
    switch (size) {
      case ZoniDropdownSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniDropdownSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniDropdownSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
    }
  }

  Color _getDefaultFillColor() {
    switch (variant) {
      case ZoniDropdownVariant.standard:
        return Colors.transparent;
      case ZoniDropdownVariant.outlined:
        return Colors.transparent;
      case ZoniDropdownVariant.filled:
        return ZoniColors.surface;
    }
  }

  InputBorder _getDefaultBorder() {
    switch (variant) {
      case ZoniDropdownVariant.standard:
        return const UnderlineInputBorder();
      case ZoniDropdownVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.outline),
        );
      case ZoniDropdownVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide.none,
        );
    }
  }

  InputBorder _getDefaultEnabledBorder() {
    switch (variant) {
      case ZoniDropdownVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.outline),
        );
      case ZoniDropdownVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.outline),
        );
      case ZoniDropdownVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide.none,
        );
    }
  }

  InputBorder _getDefaultFocusedBorder() {
    switch (variant) {
      case ZoniDropdownVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.primary, width: 2),
        );
      case ZoniDropdownVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.primary, width: 2),
        );
      case ZoniDropdownVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.primary, width: 2),
        );
    }
  }

  InputBorder _getDefaultErrorBorder() {
    switch (variant) {
      case ZoniDropdownVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.error),
        );
      case ZoniDropdownVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.error),
        );
      case ZoniDropdownVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.error),
        );
    }
  }

  InputBorder _getDefaultFocusedErrorBorder() {
    switch (variant) {
      case ZoniDropdownVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.error, width: 2),
        );
      case ZoniDropdownVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.error, width: 2),
        );
      case ZoniDropdownVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.error, width: 2),
        );
    }
  }

  InputBorder _getDefaultDisabledBorder() {
    switch (variant) {
      case ZoniDropdownVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.outline.withOpacity(0.3)),
        );
      case ZoniDropdownVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide(color: ZoniColors.outline.withOpacity(0.3)),
        );
      case ZoniDropdownVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          borderSide: BorderSide.none,
        );
    }
  }
}
