import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/zoni_constants.dart';

/// Input field size variants for the Zoni design system.
enum ZoniTextFieldSize {
  /// Small input field
  small,

  /// Medium input field - default
  medium,

  /// Large input field
  large,
}

/// A customizable text input field following the Zoni design system.
///
/// This widget provides a consistent text field implementation with
/// multiple sizes and styling options. It follows Material Design 3
/// guidelines for input components.
///
/// Example usage:
/// ```dart
/// ZoniTextField(
///   label: 'Email',
///   hintText: 'Enter your email',
///   onChanged: (value) => print(value),
/// )
/// ```
class ZoniTextField extends StatelessWidget {
  /// Creates a Zoni text field.
  const ZoniTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = ZoniTextFieldSize.medium,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.semanticLabel,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The label text to display above the field.
  final String? label;

  /// The hint text to display when the field is empty.
  final String? hintText;

  /// Helper text to display below the field.
  final String? helperText;

  /// Error text to display below the field.
  final String? errorText;

  /// Widget to display before the input text.
  final Widget? prefixIcon;

  /// Widget to display after the input text.
  final Widget? suffixIcon;

  /// The size of the text field.
  final ZoniTextFieldSize size;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  /// The maximum number of characters allowed.
  final int? maxLength;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field should be focused initially.
  final bool autofocus;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// The action to take when the user presses the action button.
  final TextInputAction? textInputAction;

  /// Input formatters to apply to the text.
  final List<TextInputFormatter>? inputFormatters;

  /// Validator function for form validation.
  final String? Function(String?)? validator;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the text.
  final ValueChanged<String>? onSubmitted;

  /// Called when the text field is tapped.
  final VoidCallback? onTap;

  /// Focus node for the text field.
  final FocusNode? focusNode;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets contentPadding = _getContentPadding();

    Widget textField = TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        ),
      ),
    );

    if (semanticLabel != null) {
      textField = Semantics(
        label: semanticLabel,
        textField: true,
        child: textField,
      );
    }

    return textField;
  }

  EdgeInsets _getContentPadding() {
    switch (size) {
      case ZoniTextFieldSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniTextFieldSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniTextFieldSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('helperText', helperText))
      ..add(StringProperty('errorText', errorText))
      ..add(EnumProperty<ZoniTextFieldSize>('size', size))
      ..add(IntProperty('maxLines', maxLines))
      ..add(IntProperty('maxLength', maxLength))
      ..add(FlagProperty('obscureText', value: obscureText, ifTrue: 'obscured'))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty<TextInputType>('keyboardType', keyboardType))
      ..add(EnumProperty<TextInputAction>('textInputAction', textInputAction))
      ..add(
        DiagnosticsProperty<TextEditingController>('controller', controller),
      )
      ..add(
        DiagnosticsProperty<List<TextInputFormatter>>(
          'inputFormatters',
          inputFormatters,
        ),
      )
      ..add(
        DiagnosticsProperty<String? Function(String?)>(
          'validator',
          validator,
        ),
      )
      ..add(DiagnosticsProperty<ValueChanged<String>>('onChanged', onChanged))
      ..add(
        DiagnosticsProperty<ValueChanged<String>>('onSubmitted', onSubmitted),
      )
      ..add(DiagnosticsProperty<VoidCallback>('onTap', onTap))
      ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
