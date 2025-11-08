import 'package:flutter/material.dart';

import '../constants/zoni_constants.dart';

/// Animation utilities and constants for the Zoni design system.
///
/// This class provides reusable animation configurations, curves, and
/// helper methods for consistent motion design across all components.
class ZoniAnimations {
  const ZoniAnimations._();

  // Animation Curves
  /// Standard easing curve for most UI animations
  static const Curve standard = Curves.easeInOut;

  /// Emphasized easing curve for important state changes
  static const Curve emphasized = Curves.easeOutCubic;

  /// Decelerated easing curve for entering elements
  static const Curve decelerated = Curves.easeOut;

  /// Accelerated easing curve for exiting elements
  static const Curve accelerated = Curves.easeIn;

  /// Bounce curve for playful interactions
  static const Curve bounce = Curves.elasticOut;

  // Button-specific animation configurations
  /// Scale animation for button press feedback
  static const double buttonPressScale = 0.95;

  /// Opacity animation for button press feedback
  static const double buttonPressOpacity = 0.8;

  /// Duration for button press animations
  static const Duration buttonPressDuration = Duration(milliseconds: 100);

  /// Duration for button release animations
  static const Duration buttonReleaseDuration = Duration(milliseconds: 150);

  /// Duration for loading state transitions
  static const Duration loadingTransitionDuration = Duration(milliseconds: 200);

  /// Duration for enabled/disabled state transitions
  static const Duration stateTransitionDuration = Duration(milliseconds: 250);

  // Loading animation configurations
  /// Rotation duration for circular loading indicators
  static const Duration loadingRotationDuration = Duration(milliseconds: 1000);

  /// Pulse duration for loading indicators
  static const Duration loadingPulseDuration = Duration(milliseconds: 800);

  /// Fade duration for loading state changes
  static const Duration loadingFadeDuration = Duration(milliseconds: 300);

  // Hover and focus animations
  /// Duration for hover state transitions
  static const Duration hoverDuration = Duration(milliseconds: 200);

  /// Duration for focus state transitions
  static const Duration focusDuration = Duration(milliseconds: 150);

  /// Scale factor for hover effects
  static const double hoverScale = 1.02;

  /// Elevation increase for hover effects
  static const double hoverElevationIncrease = 2.0;
}

/// Animation controller mixin for consistent animation management.
///
/// This mixin provides common animation controller patterns used
/// across Zoni UI components.
mixin ZoniAnimationMixin<T extends StatefulWidget> on State<T>, TickerProviderStateMixin<T> {
  /// Creates a standard animation controller with Zoni duration
  AnimationController createStandardController({
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
  }) {
    return AnimationController(
      duration: duration ?? ZoniDuration.normal,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel,
      vsync: this,
    );
  }

  /// Creates a fast animation controller for quick interactions
  AnimationController createFastController({
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
  }) {
    return AnimationController(
      duration: duration ?? ZoniDuration.fast,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel,
      vsync: this,
    );
  }

  /// Creates a slow animation controller for complex transitions
  AnimationController createSlowController({
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
  }) {
    return AnimationController(
      duration: duration ?? ZoniDuration.slow,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel,
      vsync: this,
    );
  }

  /// Creates a tween animation with standard curve
  Animation<T> createTween<T>({
    required AnimationController controller,
    required T begin,
    required T end,
    Curve curve = ZoniAnimations.standard,
  }) {
    return Tween<T>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  /// Creates a scale animation for press effects
  Animation<double> createPressAnimation(AnimationController controller) {
    return createTween<double>(
      controller: controller,
      begin: 1.0,
      end: ZoniAnimations.buttonPressScale,
      curve: ZoniAnimations.emphasized,
    );
  }

  /// Creates an opacity animation for press effects
  Animation<double> createOpacityAnimation(AnimationController controller) {
    return createTween<double>(
      controller: controller,
      begin: 1.0,
      end: ZoniAnimations.buttonPressOpacity,
      curve: ZoniAnimations.standard,
    );
  }
}

/// Animated wrapper widget for button press effects.
///
/// This widget provides consistent press animation effects that can be
/// applied to any button or interactive widget.
class ZoniPressAnimation extends StatefulWidget {
  /// Creates a press animation wrapper.
  const ZoniPressAnimation({
    required this.child,
    super.key,
    this.onPressed,
    this.enabled = true,
    this.scaleAnimation = true,
    this.opacityAnimation = true,
    this.customScale,
    this.customOpacity,
    this.duration,
  });

  /// The child widget to animate
  final Widget child;

  /// Callback when the widget is pressed
  final VoidCallback? onPressed;

  /// Whether the animation is enabled
  final bool enabled;

  /// Whether to apply scale animation
  final bool scaleAnimation;

  /// Whether to apply opacity animation
  final bool opacityAnimation;

  /// Custom scale factor (overrides default)
  final double? customScale;

  /// Custom opacity factor (overrides default)
  final double? customOpacity;

  /// Custom animation duration
  final Duration? duration;

  @override
  State<ZoniPressAnimation> createState() => _ZoniPressAnimationState();
}

class _ZoniPressAnimationState extends State<ZoniPressAnimation>
    with TickerProviderStateMixin, ZoniAnimationMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = createFastController(
      duration: widget.duration ?? ZoniAnimations.buttonPressDuration,
      reverseDuration: ZoniAnimations.buttonReleaseDuration,
      debugLabel: 'ZoniPressAnimation',
    );

    _scaleAnimation = createTween<double>(
      controller: _controller,
      begin: 1.0,
      end: widget.customScale ?? ZoniAnimations.buttonPressScale,
      curve: ZoniAnimations.emphasized,
    );

    _opacityAnimation = createTween<double>(
      controller: _controller,
      begin: 1.0,
      end: widget.customOpacity ?? ZoniAnimations.buttonPressOpacity,
      curve: ZoniAnimations.standard,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && widget.onPressed != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enabled) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.enabled ? widget.onPressed : null,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          Widget animatedChild = widget.child;

          if (widget.scaleAnimation) {
            animatedChild = Transform.scale(
              scale: _scaleAnimation.value,
              child: animatedChild,
            );
          }

          if (widget.opacityAnimation) {
            animatedChild = Opacity(
              opacity: _opacityAnimation.value,
              child: animatedChild,
            );
          }

          return animatedChild;
        },
      ),
    );
  }
}
