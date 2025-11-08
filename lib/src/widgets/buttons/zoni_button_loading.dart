import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../utils/zoni_animations.dart';

/// Loading state variants for button components.
enum ZoniButtonLoadingType {
  /// Circular progress indicator (default)
  circular,
  
  /// Linear progress indicator
  linear,
  
  /// Dots animation
  dots,
  
  /// Pulse animation
  pulse,
  
  /// Spinner with text
  spinnerWithText,
  
  /// Fade transition
  fade,
}

/// A specialized loading indicator for button components.
///
/// This widget provides various loading animations optimized for button
/// contexts, with smooth transitions and proper sizing for different
/// button sizes.
class ZoniButtonLoading extends StatefulWidget {
  /// Creates a button loading indicator.
  const ZoniButtonLoading({
    super.key,
    this.type = ZoniButtonLoadingType.circular,
    this.size = 20.0,
    this.color,
    this.strokeWidth = 2.0,
    this.loadingText,
    this.showText = false,
    this.textStyle,
    this.animationDuration,
  });

  /// The type of loading animation to display
  final ZoniButtonLoadingType type;

  /// The size of the loading indicator
  final double size;

  /// The color of the loading indicator
  final Color? color;

  /// The stroke width for circular indicators
  final double strokeWidth;

  /// Optional text to display with the loading indicator
  final String? loadingText;

  /// Whether to show the loading text
  final bool showText;

  /// Text style for the loading text
  final TextStyle? textStyle;

  /// Custom animation duration
  final Duration? animationDuration;

  @override
  State<ZoniButtonLoading> createState() => _ZoniButtonLoadingState();
}

class _ZoniButtonLoadingState extends State<ZoniButtonLoading>
    with TickerProviderStateMixin, ZoniAnimationMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = createStandardController(
      duration: widget.animationDuration ?? ZoniAnimations.loadingRotationDuration,
      debugLabel: 'ZoniButtonLoading',
    );

    _rotationAnimation = createTween<double>(
      controller: _controller,
      begin: 0.0,
      end: 1.0,
      curve: Curves.linear,
    );

    _pulseAnimation = createTween<double>(
      controller: _controller,
      begin: 0.5,
      end: 1.0,
      curve: Curves.easeInOut,
    );

    _fadeAnimation = createTween<double>(
      controller: _controller,
      begin: 0.3,
      end: 1.0,
      curve: Curves.easeInOut,
    );

    _startAnimation();
  }

  void _startAnimation() {
    switch (widget.type) {
      case ZoniButtonLoadingType.circular:
      case ZoniButtonLoadingType.spinnerWithText:
        _controller.repeat();
        break;
      case ZoniButtonLoadingType.pulse:
        _controller.repeat(reverse: true);
        break;
      case ZoniButtonLoadingType.fade:
        _controller.repeat(reverse: true);
        break;
      case ZoniButtonLoadingType.dots:
        _controller.repeat();
        break;
      case ZoniButtonLoadingType.linear:
        _controller.repeat();
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = widget.color ?? 
        Theme.of(context).colorScheme.onPrimary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _buildLoadingByType(effectiveColor);
      },
    );
  }

  Widget _buildLoadingByType(Color color) {
    switch (widget.type) {
      case ZoniButtonLoadingType.circular:
        return _buildCircularLoading(color);
      case ZoniButtonLoadingType.linear:
        return _buildLinearLoading(color);
      case ZoniButtonLoadingType.dots:
        return _buildDotsLoading(color);
      case ZoniButtonLoadingType.pulse:
        return _buildPulseLoading(color);
      case ZoniButtonLoadingType.spinnerWithText:
        return _buildSpinnerWithText(color);
      case ZoniButtonLoadingType.fade:
        return _buildFadeLoading(color);
    }
  }

  Widget _buildCircularLoading(Color color) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        strokeWidth: widget.strokeWidth,
        color: color,
        value: null, // Indeterminate
      ),
    );
  }

  Widget _buildLinearLoading(Color color) {
    return SizedBox(
      width: widget.size * 2,
      height: 4,
      child: LinearProgressIndicator(
        color: color,
        backgroundColor: color.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildDotsLoading(Color color) {
    return SizedBox(
      width: widget.size * 1.5,
      height: widget.size * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          final delay = index * 0.2;
          final animation = Tween<double>(
            begin: 0.5,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                delay,
                delay + 0.6,
                curve: Curves.easeInOut,
              ),
            ),
          );

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.scale(
                scale: animation.value,
                child: Container(
                  width: widget.size * 0.15,
                  height: widget.size * 0.15,
                  decoration: BoxDecoration(
                    color: color.withValues(
                      alpha: 0.3 + (animation.value * 0.7),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildPulseLoading(Color color) {
    return Transform.scale(
      scale: _pulseAnimation.value,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: _pulseAnimation.value),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildSpinnerWithText(Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.rotate(
          angle: _rotationAnimation.value * 2 * 3.14159,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              strokeWidth: widget.strokeWidth,
              color: color,
              value: null,
            ),
          ),
        ),
        if (widget.showText && widget.loadingText != null) ...[
          SizedBox(width: ZoniSpacing.sm),
          Text(
            widget.loadingText!,
            style: widget.textStyle ?? TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFadeLoading(Color color) {
    return Opacity(
      opacity: _fadeAnimation.value,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.hourglass_empty,
          color: Colors.white,
          size: widget.size * 0.6,
        ),
      ),
    );
  }
}

/// A widget that smoothly transitions between content and loading states.
///
/// This widget provides smooth animations when switching between normal
/// button content and loading indicators.
class ZoniButtonLoadingTransition extends StatefulWidget {
  /// Creates a loading transition widget.
  const ZoniButtonLoadingTransition({
    super.key,
    required this.isLoading,
    required this.child,
    required this.loadingWidget,
    this.duration,
    this.curve = Curves.easeInOut,
  });

  /// Whether the loading state is active
  final bool isLoading;

  /// The normal content to display
  final Widget child;

  /// The loading widget to display
  final Widget loadingWidget;

  /// Animation duration for the transition
  final Duration? duration;

  /// Animation curve for the transition
  final Curve curve;

  @override
  State<ZoniButtonLoadingTransition> createState() => 
      _ZoniButtonLoadingTransitionState();
}

class _ZoniButtonLoadingTransitionState extends State<ZoniButtonLoadingTransition>
    with TickerProviderStateMixin, ZoniAnimationMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = createStandardController(
      duration: widget.duration ?? ZoniAnimations.loadingTransitionDuration,
      debugLabel: 'ZoniButtonLoadingTransition',
    );

    _fadeAnimation = createTween<double>(
      controller: _controller,
      begin: 0.0,
      end: 1.0,
      curve: widget.curve,
    );

    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(ZoniButtonLoadingTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Normal content
            Opacity(
              opacity: 1.0 - _fadeAnimation.value,
              child: widget.child,
            ),
            // Loading content
            Opacity(
              opacity: _fadeAnimation.value,
              child: widget.loadingWidget,
            ),
          ],
        );
      },
    );
  }
}
