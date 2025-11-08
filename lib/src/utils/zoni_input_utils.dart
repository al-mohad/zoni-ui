import 'package:flutter/material.dart';

import '../constants/zoni_constants.dart';
import '../theme/zoni_colors.dart';
import '../theme/zoni_text_styles.dart';

/// Enum for input field variants across the design system.
enum ZoniInputVariant {
  /// Standard input with underline border.
  standard,

  /// Outlined input with border around the field.
  outlined,

  /// Filled input with background color.
  filled,
}

/// Enum for input field sizes across the design system.
enum ZoniInputSize {
  /// Small input field.
  small,

  /// Medium input field - default.
  medium,

  /// Large input field.
  large,
}

/// Enum for input field states.
enum ZoniInputState {
  /// Normal state.
  normal,

  /// Focused state.
  focused,

  /// Error state.
  error,

  /// Disabled state.
  disabled,

  /// Loading state.
  loading,
}

/// Comprehensive input decoration configuration for Zoni input fields.
class ZoniInputDecoration {
  /// Creates a Zoni input decoration configuration.
  const ZoniInputDecoration({
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.hintText,
    this.hintStyle,
    this.hintTextDirection,
    this.hintMaxLines,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.floatingLabelBehavior,
    this.floatingLabelAlignment,
    this.isCollapsed = false,
    this.isDense,
    this.contentPadding,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.prefix,
    this.prefixText,
    this.prefixStyle,
    this.suffixIcon,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
    this.suffixIconConstraints,
    this.counter,
    this.counterText,
    this.counterStyle,
    this.filled,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.border,
    this.enabled = true,
    this.semanticCounterText,
    this.alignLabelWithHint,
    this.constraints,
  });

  /// Text that describes the input field.
  final String? labelText;

  /// The style to use for the labelText.
  final TextStyle? labelStyle;

  /// The style to use for the labelText when the label is floating.
  final TextStyle? floatingLabelStyle;

  /// Text that provides context about the input field's value.
  final String? helperText;

  /// The style to use for the helperText.
  final TextStyle? helperStyle;

  /// The maximum number of lines the helperText can occupy.
  final int? helperMaxLines;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// The style to use for the hintText.
  final TextStyle? hintStyle;

  /// The text direction to use for the hintText.
  final TextDirection? hintTextDirection;

  /// The maximum number of lines the hintText can occupy.
  final int? hintMaxLines;

  /// Text that appears below the input field and displays validation errors.
  final String? errorText;

  /// The style to use for the errorText.
  final TextStyle? errorStyle;

  /// The maximum number of lines the errorText can occupy.
  final int? errorMaxLines;

  /// Defines how the floating label should behave.
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Defines where the floating label should be displayed.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// Whether the decoration is the same size as the input field.
  final bool isCollapsed;

  /// Whether the input field is part of a dense form.
  final bool? isDense;

  /// The padding for the input decoration's container.
  final EdgeInsetsGeometry? contentPadding;

  /// An icon that appears before the editable part of the text field.
  final Widget? prefixIcon;

  /// The constraints for the prefix icon.
  final BoxConstraints? prefixIconConstraints;

  /// Optional widget to place on the line before the input.
  final Widget? prefix;

  /// Optional text prefix to place on the line before the input.
  final String? prefixText;

  /// The style to use for the prefixText.
  final TextStyle? prefixStyle;

  /// An icon that appears after the editable part of the text field.
  final Widget? suffixIcon;

  /// Optional widget to place on the line after the input.
  final Widget? suffix;

  /// Optional text suffix to place on the line after the input.
  final String? suffixText;

  /// The style to use for the suffixText.
  final TextStyle? suffixStyle;

  /// The constraints for the suffix icon.
  final BoxConstraints? suffixIconConstraints;

  /// Optional custom counter widget to go in the place otherwise occupied by counterText.
  final Widget? counter;

  /// Optional text to place below the line as a character count.
  final String? counterText;

  /// The style to use for the counterText.
  final TextStyle? counterStyle;

  /// If true the decoration's container is filled with fillColor.
  final bool? filled;

  /// The base fill color of the decoration.
  final Color? fillColor;

  /// The color to paint the decoration's container when it has input focus.
  final Color? focusColor;

  /// The color to paint the decoration's container when the mouse is hovering over it.
  final Color? hoverColor;

  /// The border to display when the InputDecorator has an error and does not have input focus.
  final InputBorder? errorBorder;

  /// The border to display when the InputDecorator has input focus and has an error.
  final InputBorder? focusedErrorBorder;

  /// The border to display when the InputDecorator has input focus.
  final InputBorder? focusedBorder;

  /// The border to display when the InputDecorator is disabled.
  final InputBorder? disabledBorder;

  /// The border to display when the InputDecorator is enabled and does not have input focus.
  final InputBorder? enabledBorder;

  /// The shape of the border to draw around the decoration's container.
  final InputBorder? border;

  /// If false helperText, errorText, and counterText are not displayed.
  final bool enabled;

  /// A semantic label for the counterText.
  final String? semanticCounterText;

  /// Whether to align the label with the hint or not.
  final bool? alignLabelWithHint;

  /// Defines minimum and maximum sizes for the InputDecorator.
  final BoxConstraints? constraints;

  /// Converts this configuration to Flutter's InputDecoration.
  InputDecoration toInputDecoration() => InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        floatingLabelStyle: floatingLabelStyle,
        helperText: helperText,
        helperStyle: helperStyle,
        helperMaxLines: helperMaxLines,
        hintText: hintText,
        hintStyle: hintStyle,
        hintTextDirection: hintTextDirection,
        hintMaxLines: hintMaxLines,
        errorText: errorText,
        errorStyle: errorStyle,
        errorMaxLines: errorMaxLines,
        floatingLabelBehavior: floatingLabelBehavior,
        floatingLabelAlignment: floatingLabelAlignment,
        isCollapsed: isCollapsed,
        isDense: isDense,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        prefix: prefix,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        suffixIcon: suffixIcon,
        suffix: suffix,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        suffixIconConstraints: suffixIconConstraints,
        counter: counter,
        counterText: counterText,
        counterStyle: counterStyle,
        filled: filled,
        fillColor: fillColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        errorBorder: errorBorder,
        focusedBorder: focusedBorder,
        focusedErrorBorder: focusedErrorBorder,
        disabledBorder: disabledBorder,
        enabledBorder: enabledBorder,
        border: border,
        enabled: enabled,
        semanticCounterText: semanticCounterText,
        alignLabelWithHint: alignLabelWithHint,
        constraints: constraints,
      );

  /// Creates a copy of this decoration with the given fields replaced.
  ZoniInputDecoration copyWith({
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    TextStyle? hintStyle,
    TextDirection? hintTextDirection,
    int? hintMaxLines,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    FloatingLabelBehavior? floatingLabelBehavior,
    FloatingLabelAlignment? floatingLabelAlignment,
    bool? isCollapsed,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    Widget? prefix,
    String? prefixText,
    TextStyle? prefixStyle,
    Widget? suffixIcon,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    BoxConstraints? suffixIconConstraints,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    bool? filled,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    InputBorder? border,
    bool? enabled,
    String? semanticCounterText,
    bool? alignLabelWithHint,
    BoxConstraints? constraints,
  }) =>
      ZoniInputDecoration(
        labelText: labelText ?? this.labelText,
        labelStyle: labelStyle ?? this.labelStyle,
        floatingLabelStyle: floatingLabelStyle ?? this.floatingLabelStyle,
        helperText: helperText ?? this.helperText,
        helperStyle: helperStyle ?? this.helperStyle,
        helperMaxLines: helperMaxLines ?? this.helperMaxLines,
        hintText: hintText ?? this.hintText,
        hintStyle: hintStyle ?? this.hintStyle,
        hintTextDirection: hintTextDirection ?? this.hintTextDirection,
        hintMaxLines: hintMaxLines ?? this.hintMaxLines,
        errorText: errorText ?? this.errorText,
        errorStyle: errorStyle ?? this.errorStyle,
        errorMaxLines: errorMaxLines ?? this.errorMaxLines,
        floatingLabelBehavior:
            floatingLabelBehavior ?? this.floatingLabelBehavior,
        floatingLabelAlignment:
            floatingLabelAlignment ?? this.floatingLabelAlignment,
        isCollapsed: isCollapsed ?? this.isCollapsed,
        isDense: isDense ?? this.isDense,
        contentPadding: contentPadding ?? this.contentPadding,
        prefixIcon: prefixIcon ?? this.prefixIcon,
        prefixIconConstraints:
            prefixIconConstraints ?? this.prefixIconConstraints,
        prefix: prefix ?? this.prefix,
        prefixText: prefixText ?? this.prefixText,
        prefixStyle: prefixStyle ?? this.prefixStyle,
        suffixIcon: suffixIcon ?? this.suffixIcon,
        suffix: suffix ?? this.suffix,
        suffixText: suffixText ?? this.suffixText,
        suffixStyle: suffixStyle ?? this.suffixStyle,
        suffixIconConstraints:
            suffixIconConstraints ?? this.suffixIconConstraints,
        counter: counter ?? this.counter,
        counterText: counterText ?? this.counterText,
        counterStyle: counterStyle ?? this.counterStyle,
        filled: filled ?? this.filled,
        fillColor: fillColor ?? this.fillColor,
        focusColor: focusColor ?? this.focusColor,
        hoverColor: hoverColor ?? this.hoverColor,
        errorBorder: errorBorder ?? this.errorBorder,
        focusedBorder: focusedBorder ?? this.focusedBorder,
        focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
        disabledBorder: disabledBorder ?? this.disabledBorder,
        enabledBorder: enabledBorder ?? this.enabledBorder,
        border: border ?? this.border,
        enabled: enabled ?? this.enabled,
        semanticCounterText: semanticCounterText ?? this.semanticCounterText,
        alignLabelWithHint: alignLabelWithHint ?? this.alignLabelWithHint,
        constraints: constraints ?? this.constraints,
      );
}

/// Utility class for input field styling and behavior.
class ZoniInputUtils {
  ZoniInputUtils._();

  /// Gets the default content padding for the given size.
  static EdgeInsetsGeometry getContentPadding(ZoniInputSize size) {
    switch (size) {
      case ZoniInputSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniInputSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniInputSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
    }
  }

  /// Gets the default text style for the given size.
  static TextStyle getTextStyle(ZoniInputSize size) {
    switch (size) {
      case ZoniInputSize.small:
        return ZoniTextStyles.bodySmall;
      case ZoniInputSize.medium:
        return ZoniTextStyles.bodyMedium;
      case ZoniInputSize.large:
        return ZoniTextStyles.bodyLarge;
    }
  }

  /// Gets the default label style for the given size.
  static TextStyle getLabelStyle(ZoniInputSize size) {
    switch (size) {
      case ZoniInputSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniInputSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniInputSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  /// Gets the default hint style for the given size.
  static TextStyle getHintStyle(ZoniInputSize size) =>
      getTextStyle(size).copyWith(
        color: ZoniColors.onSurface.withValues(alpha: 0.6),
      );

  /// Gets the default helper style for the given size.
  static TextStyle getHelperStyle(ZoniInputSize size) =>
      getLabelStyle(size).copyWith(
        color: ZoniColors.onSurface.withValues(alpha: 0.7),
      );

  /// Gets the default error style for the given size.
  static TextStyle getErrorStyle(ZoniInputSize size) =>
      getLabelStyle(size).copyWith(
        color: ZoniColors.error,
      );

  /// Gets the default border for the given variant.
  static InputBorder getBorder(ZoniInputVariant variant) {
    switch (variant) {
      case ZoniInputVariant.standard:
        return const UnderlineInputBorder();
      case ZoniInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.outline),
        );
      case ZoniInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: BorderSide.none,
        );
    }
  }

  /// Gets the enabled border for the given variant.
  static InputBorder getEnabledBorder(ZoniInputVariant variant) {
    switch (variant) {
      case ZoniInputVariant.standard:
        return const UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.outline),
        );
      case ZoniInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.outline),
        );
      case ZoniInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: BorderSide.none,
        );
    }
  }

  /// Gets the focused border for the given variant.
  static InputBorder getFocusedBorder(ZoniInputVariant variant) {
    switch (variant) {
      case ZoniInputVariant.standard:
        return const UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.primary, width: 2),
        );
      case ZoniInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.primary, width: 2),
        );
      case ZoniInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.primary, width: 2),
        );
    }
  }

  /// Gets the error border for the given variant.
  static InputBorder getErrorBorder(ZoniInputVariant variant) {
    switch (variant) {
      case ZoniInputVariant.standard:
        return const UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.error),
        );
      case ZoniInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.error),
        );
      case ZoniInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.error),
        );
    }
  }

  /// Gets the focused error border for the given variant.
  static InputBorder getFocusedErrorBorder(ZoniInputVariant variant) {
    switch (variant) {
      case ZoniInputVariant.standard:
        return const UnderlineInputBorder(
          borderSide: BorderSide(color: ZoniColors.error, width: 2),
        );
      case ZoniInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.error, width: 2),
        );
      case ZoniInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: const BorderSide(color: ZoniColors.error, width: 2),
        );
    }
  }

  /// Gets the disabled border for the given variant.
  static InputBorder getDisabledBorder(ZoniInputVariant variant) {
    switch (variant) {
      case ZoniInputVariant.standard:
        return UnderlineInputBorder(
          borderSide:
              BorderSide(color: ZoniColors.outline.withValues(alpha: 0.3)),
        );
      case ZoniInputVariant.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide:
              BorderSide(color: ZoniColors.outline.withValues(alpha: 0.3)),
        );
      case ZoniInputVariant.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          borderSide: BorderSide.none,
        );
    }
  }

  /// Gets the default fill color for the given variant.
  static Color? getFillColor(ZoniInputVariant variant) {
    switch (variant) {
      case ZoniInputVariant.standard:
        return null;
      case ZoniInputVariant.outlined:
        return null;
      case ZoniInputVariant.filled:
        return ZoniColors.surface;
    }
  }

  /// Creates a default decoration for the given variant and size.
  static ZoniInputDecoration createDefaultDecoration({
    required ZoniInputVariant variant,
    required ZoniInputSize size,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
  }) =>
      ZoniInputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabled: enabled,
        filled: variant == ZoniInputVariant.filled,
        fillColor: getFillColor(variant),
        contentPadding: getContentPadding(size),
        labelStyle: getLabelStyle(size),
        hintStyle: getHintStyle(size),
        helperStyle: getHelperStyle(size),
        errorStyle: getErrorStyle(size),
        border: getBorder(variant),
        enabledBorder: getEnabledBorder(variant),
        focusedBorder: getFocusedBorder(variant),
        errorBorder: getErrorBorder(variant),
        focusedErrorBorder: getFocusedErrorBorder(variant),
        disabledBorder: getDisabledBorder(variant),
      );
}
