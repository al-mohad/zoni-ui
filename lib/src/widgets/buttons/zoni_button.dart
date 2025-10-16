import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';

/// Button size variants for the Zoni design system.
enum ZoniButtonSize {
  /// Small button (32px height)
  small,

  /// Medium button (40px height) - default
  medium,

  /// Large button (48px height)
  large,
}

/// Button style variants for the Zoni design system.
enum ZoniButtonVariant {
  /// Filled button with solid background
  filled,

  /// Outlined button with border
  outlined,

  /// Text button with no background or border
  text,

  /// Filled tonal button with tinted background
  filledTonal,
}

/// A customizable button widget following the Zoni design system.
///
/// This widget provides a consistent button implementation with multiple
/// variants, sizes, and states. It follows Material Design 3 guidelines
/// and includes proper accessibility support.
///
/// Example usage:
/// ```dart
/// ZoniButton(
///   onPressed: () => print('Button pressed'),
///   child: Text('Click me'),
///   variant: ZoniButtonVariant.filled,
///   size: ZoniButtonSize.large,
/// )
/// ```
class ZoniButton extends StatelessWidget {
  /// Creates a Zoni button.
  ///
  /// The [onPressed] and [child] parameters are required.
  /// The [variant] parameter defaults to [ZoniButtonVariant.filled].
  /// The [size] parameter defaults to [ZoniButtonSize.medium].
  const ZoniButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.variant = ZoniButtonVariant.filled,
    this.size = ZoniButtonSize.medium,
    this.width,
    this.isLoading = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
  });

  /// Called when the button is tapped.
  ///
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The widget to display inside the button.
  final Widget child;

  /// The visual style variant of the button.
  final ZoniButtonVariant variant;

  /// The size of the button.
  final ZoniButtonSize size;

  /// The minimum width of the button.
  ///
  /// If null, the button will size itself to its content.
  final double? width;

  /// Whether the button is in a loading state.
  ///
  /// When true, shows a loading indicator and disables interaction.
  final bool isLoading;

  /// Optional icon to display before the child.
  final Widget? icon;

  /// Semantic label for accessibility.
  ///
  /// If null, uses the button's text content.
  final String? semanticLabel;

  /// Tooltip text to display on long press.
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = _getButtonHeight();
    final EdgeInsets padding = _getButtonPadding();
    final Widget buttonChild = _buildButtonChild();

    Widget button = _buildButtonByVariant(
      context: context,
      height: buttonHeight,
      padding: padding,
      child: buttonChild,
    );

    // Add tooltip if provided
    if (tooltip != null) {
      button = Tooltip(
        message: tooltip,
        child: button,
      );
    }

    // Add semantic label if provided
    if (semanticLabel != null) {
      button = Semantics(
        label: semanticLabel,
        button: true,
        enabled: onPressed != null && !isLoading,
        child: button,
      );
    }

    return button;
  }

  double _getButtonHeight() {
    switch (size) {
      case ZoniButtonSize.small:
        return 32;
      case ZoniButtonSize.medium:
        return 40;
      case ZoniButtonSize.large:
        return 48;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (size) {
      case ZoniButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
    }
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: _getButtonHeight() * 0.5,
        width: _getButtonHeight() * 0.5,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon!,
          const SizedBox(width: ZoniSpacing.sm),
          child,
        ],
      );
    }

    return child;
  }

  Widget _buildButtonByVariant({
    required BuildContext context,
    required double height,
    required EdgeInsets padding,
    required Widget child,
  }) {
    final VoidCallback? effectiveOnPressed =
        (onPressed != null && !isLoading) ? onPressed : null;

    final ButtonStyle style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(Size(width ?? 0, height)),
      padding: WidgetStateProperty.all(padding),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        ),
      ),
    );

    switch (variant) {
      case ZoniButtonVariant.filled:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: style,
          child: child,
        );
      case ZoniButtonVariant.outlined:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: style,
          child: child,
        );
      case ZoniButtonVariant.text:
        return TextButton(
          onPressed: effectiveOnPressed,
          style: style,
          child: child,
        );
      case ZoniButtonVariant.filledTonal:
        return FilledButton(
          onPressed: effectiveOnPressed,
          style: style,
          child: child,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(EnumProperty<ZoniButtonVariant>('variant', variant))
      ..add(EnumProperty<ZoniButtonSize>('size', size))
      ..add(DoubleProperty('width', width, defaultValue: null))
      ..add(FlagProperty('isLoading', value: isLoading, ifTrue: 'loading'))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(StringProperty('tooltip', tooltip));
  }
}
