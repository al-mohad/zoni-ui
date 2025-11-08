import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/zoni_constants.dart';
import '../../utils/zoni_animations.dart';
import '../../utils/zoni_haptics.dart';
import 'zoni_button_loading.dart';

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

  /// Primary button variant
  primary,

  /// Success button variant
  success,

  /// Warning button variant
  warning,

  /// Danger/Error button variant
  danger,
}

/// A customizable button widget following the Zoni design system.
///
/// This widget provides a consistent button implementation with multiple
/// variants, sizes, and states. It follows Material Design 3 guidelines
/// and includes proper accessibility support, haptic feedback, loading states,
/// and smooth animations.
///
/// Features:
/// - Multiple variants (filled, outlined, text, etc.)
/// - Different sizes (small, medium, large)
/// - Loading states with smooth transitions
/// - Haptic feedback for interactions
/// - Press animations with scale and opacity effects
/// - Comprehensive accessibility support
/// - Tooltip and semantic label support
/// - Icon support with proper spacing
///
/// Example usage:
/// ```dart
/// ZoniButton(
///   onPressed: () => print('Button pressed'),
///   child: Text('Click me'),
///   variant: ZoniButtonVariant.filled,
///   size: ZoniButtonSize.large,
///   isLoading: false,
///   isEnabled: true,
///   enableHapticFeedback: true,
///   enablePressAnimation: true,
/// )
/// ```
class ZoniButton extends StatefulWidget {
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
    this.isEnabled = true,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.enableHapticFeedback = true,
    this.enablePressAnimation = true,
    this.hapticType = ZoniHapticType.buttonPress,
    this.loadingType = ZoniButtonLoadingType.circular,
    this.loadingText,
    this.animationDuration,
    this.customPressScale,
    this.customPressOpacity,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
  });

  /// Creates a text button variant.
  const ZoniButton.text({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = ZoniButtonSize.medium,
    this.width,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.semanticLabel,
    this.tooltip,
    this.enableHapticFeedback = true,
    this.enablePressAnimation = true,
    this.hapticType = ZoniHapticType.buttonPress,
    this.loadingType = ZoniButtonLoadingType.circular,
    this.loadingText,
    this.animationDuration,
    this.customPressScale,
    this.customPressOpacity,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
  }) : variant = ZoniButtonVariant.text;

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

  /// Whether the button is enabled.
  ///
  /// When false, the button will be disabled and won't respond to interactions.
  /// This is separate from [onPressed] being null, allowing for more explicit
  /// control over the button's enabled state.
  final bool isEnabled;

  /// Whether to provide haptic feedback on button interactions.
  ///
  /// When true, the button will provide haptic feedback when pressed.
  /// The type of haptic feedback is controlled by [hapticType].
  final bool enableHapticFeedback;

  /// Whether to enable press animation effects.
  ///
  /// When true, the button will animate with scale and opacity changes
  /// when pressed, providing visual feedback for the interaction.
  final bool enablePressAnimation;

  /// The type of haptic feedback to provide.
  ///
  /// This determines the intensity and pattern of haptic feedback
  /// when the button is pressed. Only used when [enableHapticFeedback] is true.
  final ZoniHapticType hapticType;

  /// The type of loading animation to display.
  ///
  /// This controls the visual style of the loading indicator when
  /// [isLoading] is true.
  final ZoniButtonLoadingType loadingType;

  /// Optional text to display with the loading indicator.
  ///
  /// This text will be shown alongside the loading animation when
  /// [isLoading] is true and the loading type supports text display.
  final String? loadingText;

  /// Custom animation duration for button interactions.
  ///
  /// If null, uses the default animation durations from [ZoniAnimations].
  final Duration? animationDuration;

  /// Custom scale factor for press animations.
  ///
  /// If null, uses the default scale from [ZoniAnimations.buttonPressScale].
  /// Only used when [enablePressAnimation] is true.
  final double? customPressScale;

  /// Custom opacity factor for press animations.
  ///
  /// If null, uses the default opacity from [ZoniAnimations.buttonPressOpacity].
  /// Only used when [enablePressAnimation] is true.
  final double? customPressOpacity;

  /// Called when the button is long pressed.
  ///
  /// If null, long press gestures will not be recognized.
  final VoidCallback? onLongPress;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus.
  final bool autofocus;

  @override
  State<ZoniButton> createState() => _ZoniButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed));
    properties.add(EnumProperty<ZoniButtonVariant>('variant', variant));
    properties.add(EnumProperty<ZoniButtonSize>('size', size));
    properties.add(DoubleProperty('width', width));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
    properties.add(StringProperty('semanticLabel', semanticLabel));
    properties.add(StringProperty('tooltip', tooltip));
    properties.add(DiagnosticsProperty<bool>('isEnabled', isEnabled));
    properties.add(
      DiagnosticsProperty<bool>(
        'enableHapticFeedback',
        enableHapticFeedback,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'enablePressAnimation',
        enablePressAnimation,
      ),
    );
    properties.add(EnumProperty<ZoniHapticType>('hapticType', hapticType));
    properties
        .add(EnumProperty<ZoniButtonLoadingType>('loadingType', loadingType));
    properties.add(StringProperty('loadingText', loadingText));
    properties.add(
      DiagnosticsProperty<Duration?>('animationDuration', animationDuration),
    );
    properties.add(DoubleProperty('customPressScale', customPressScale));
    properties.add(DoubleProperty('customPressOpacity', customPressOpacity));
    properties
        .add(ObjectFlagProperty<VoidCallback?>.has('onLongPress', onLongPress));
    properties.add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus));
  }
}

/// State class for [ZoniButton] that handles animations and interactions.
class _ZoniButtonState extends State<ZoniButton>
    with TickerProviderStateMixin, ZoniAnimationMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _pressController = createFastController(
      duration: widget.animationDuration ?? ZoniAnimations.buttonPressDuration,
      reverseDuration: ZoniAnimations.buttonReleaseDuration,
      debugLabel: 'ZoniButtonPress',
    );

    _scaleAnimation = createTween<double>(
      controller: _pressController,
      begin: 1,
      end: widget.customPressScale ?? ZoniAnimations.buttonPressScale,
      curve: ZoniAnimations.emphasized,
    );

    _opacityAnimation = createTween<double>(
      controller: _pressController,
      begin: 1,
      end: widget.customPressOpacity ?? ZoniAnimations.buttonPressOpacity,
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  /// Handles button press with haptic feedback and animations.
  Future<void> _handlePress() async {
    if (!_isEffectivelyEnabled) return;

    // Provide haptic feedback
    if (widget.enableHapticFeedback) {
      await widget.hapticType.trigger();
    }

    // Call the onPressed callback
    widget.onPressed?.call();
  }

  /// Handles long press with haptic feedback.
  Future<void> _handleLongPress() async {
    if (!_isEffectivelyEnabled || widget.onLongPress == null) return;

    // Provide haptic feedback for long press
    if (widget.enableHapticFeedback) {
      await ZoniHaptics.longPress();
    }

    // Call the onLongPress callback
    widget.onLongPress?.call();
  }

  /// Whether the button is effectively enabled.
  bool get _isEffectivelyEnabled =>
      widget.isEnabled && widget.onPressed != null && !widget.isLoading;

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

    // Add press animation if enabled
    if (widget.enablePressAnimation) {
      button = AnimatedBuilder(
        animation: _pressController,
        builder: (BuildContext context, Widget? child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        ),
        child: button,
      );
    }

    // Add gesture detection for press animations
    button = GestureDetector(
      onTapDown: widget.enablePressAnimation ? _handleTapDown : null,
      onTapUp: widget.enablePressAnimation ? _handleTapUp : null,
      onTapCancel: widget.enablePressAnimation ? _handleTapCancel : null,
      child: button,
    );

    // Add tooltip if provided
    if (widget.tooltip != null) {
      button = Tooltip(
        message: widget.tooltip,
        child: button,
      );
    }

    // Add semantic label if provided
    if (widget.semanticLabel != null) {
      button = Semantics(
        label: widget.semanticLabel,
        button: true,
        enabled: _isEffectivelyEnabled,
        child: button,
      );
    }

    // Add focus support
    button = Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      child: button,
    );

    return button;
  }

  /// Handles tap down for press animations.
  void _handleTapDown(TapDownDetails details) {
    if (_isEffectivelyEnabled) {
      setState(() => _isPressed = true);
      _pressController.forward();
    }
  }

  /// Handles tap up for press animations.
  void _handleTapUp(TapUpDetails details) {
    if (_isEffectivelyEnabled) {
      setState(() => _isPressed = false);
      _pressController.reverse();
    }
  }

  /// Handles tap cancel for press animations.
  void _handleTapCancel() {
    if (_isEffectivelyEnabled) {
      setState(() => _isPressed = false);
      _pressController.reverse();
    }
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case ZoniButtonSize.small:
        return 32;
      case ZoniButtonSize.medium:
        return 40;
      case ZoniButtonSize.large:
        return 48;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (widget.size) {
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
    if (widget.isLoading) {
      return ZoniButtonLoadingTransition(
        isLoading: true,
        loadingWidget: ZoniButtonLoading(
          type: widget.loadingType,
          size: _getButtonHeight() * 0.5,
          loadingText: widget.loadingText,
          showText: widget.loadingText != null,
        ),
        child: widget.child,
      );
    }

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.icon!,
          const SizedBox(width: ZoniSpacing.sm),
          widget.child,
        ],
      );
    }

    return widget.child;
  }

  Widget _buildButtonByVariant({
    required BuildContext context,
    required double height,
    required EdgeInsets padding,
    required Widget child,
  }) {
    final VoidCallback? effectiveOnPressed =
        _isEffectivelyEnabled ? _handlePress : null;
    final VoidCallback? effectiveLongPress =
        _isEffectivelyEnabled ? _handleLongPress : null;

    final ButtonStyle style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(Size(widget.width ?? 0, height)),
      padding: WidgetStateProperty.all(padding),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        ),
      ),
    );

    switch (widget.variant) {
      case ZoniButtonVariant.filled:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
      case ZoniButtonVariant.outlined:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
      case ZoniButtonVariant.text:
        return TextButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
      case ZoniButtonVariant.filledTonal:
        return FilledButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
      case ZoniButtonVariant.primary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
      case ZoniButtonVariant.success:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
      case ZoniButtonVariant.warning:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
      case ZoniButtonVariant.danger:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          onLongPress: effectiveLongPress,
          style: style,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          child: child,
        );
    }
  }
}
