import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';

/// Loading indicator size variants for the Zoni design system.
enum ZoniLoadingSize {
  /// Small loading indicator (16px)
  small,

  /// Medium loading indicator (24px) - default
  medium,

  /// Large loading indicator (32px)
  large,

  /// Extra large loading indicator (48px)
  extraLarge,
}

/// Loading indicator style variants for the Zoni design system.
enum ZoniLoadingStyle {
  /// Circular progress indicator
  circular,

  /// Linear progress indicator
  linear,

  /// Dots loading indicator
  dots,
}

/// A customizable loading indicator widget following the Zoni design system.
///
/// This widget provides consistent loading indicators with multiple
/// sizes and styles. It follows Material Design 3 guidelines for
/// progress indicators.
///
/// Example usage:
/// ```dart
/// ZoniLoadingIndicator(
///   size: ZoniLoadingSize.large,
///   style: ZoniLoadingStyle.circular,
/// )
/// ```
class ZoniLoadingIndicator extends StatelessWidget {
  /// Creates a Zoni loading indicator.
  const ZoniLoadingIndicator({
    super.key,
    this.size = ZoniLoadingSize.medium,
    this.style = ZoniLoadingStyle.circular,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.value,
    this.semanticLabel,
  });

  /// The size of the loading indicator.
  final ZoniLoadingSize size;

  /// The style of the loading indicator.
  final ZoniLoadingStyle style;

  /// The color of the loading indicator.
  ///
  /// If null, uses the theme's primary color.
  final Color? color;

  /// The background color of the loading indicator.
  ///
  /// Only used for circular and linear styles.
  final Color? backgroundColor;

  /// The stroke width of the loading indicator.
  ///
  /// Only used for circular style.
  final double? strokeWidth;

  /// The progress value (0.0 to 1.0).
  ///
  /// If null, shows an indeterminate progress indicator.
  final double? value;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double indicatorSize = _getIndicatorSize();
    final Color effectiveColor = color ?? ZoniColors.primary;

    Widget indicator = _buildIndicatorByStyle(
      context: context,
      size: indicatorSize,
      color: effectiveColor,
    );

    if (semanticLabel != null) {
      indicator = Semantics(
        label: semanticLabel,
        child: indicator,
      );
    }

    return indicator;
  }

  double _getIndicatorSize() {
    switch (size) {
      case ZoniLoadingSize.small:
        return 16;
      case ZoniLoadingSize.medium:
        return 24;
      case ZoniLoadingSize.large:
        return 32;
      case ZoniLoadingSize.extraLarge:
        return 48;
    }
  }

  Widget _buildIndicatorByStyle({
    required BuildContext context,
    required double size,
    required Color color,
  }) {
    switch (style) {
      case ZoniLoadingStyle.circular:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: value,
            color: color,
            backgroundColor: backgroundColor,
            strokeWidth: strokeWidth ?? _getDefaultStrokeWidth(),
          ),
        );
      case ZoniLoadingStyle.linear:
        return SizedBox(
          height: 4,
          child: LinearProgressIndicator(
            value: value,
            color: color,
            backgroundColor: backgroundColor,
          ),
        );
      case ZoniLoadingStyle.dots:
        return _DotsLoadingIndicator(
          size: size,
          color: color,
        );
    }
  }

  double _getDefaultStrokeWidth() {
    switch (size) {
      case ZoniLoadingSize.small:
        return 2;
      case ZoniLoadingSize.medium:
        return 3;
      case ZoniLoadingSize.large:
        return 4;
      case ZoniLoadingSize.extraLarge:
        return 5;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZoniLoadingSize>('size', size))
      ..add(EnumProperty<ZoniLoadingStyle>('style', style))
      ..add(ColorProperty('color', color))
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(DoubleProperty('value', value))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

/// A custom dots loading indicator widget.
class _DotsLoadingIndicator extends StatefulWidget {
  const _DotsLoadingIndicator({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  State<_DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('size', size))
      ..add(ColorProperty('color', color));
  }
}

class _DotsLoadingIndicatorState extends State<_DotsLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: ZoniDuration.slow,
      vsync: this,
    );

    _animations = List<Animation<double>>.generate(
      3,
      (int index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            (index * 0.2) + 0.6,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double dotSize = widget.size * 0.25;

    return SizedBox(
      width: widget.size,
      height: dotSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
          3,
          (int index) => AnimatedBuilder(
            animation: _animations[index],
            builder: (BuildContext context, Widget? child) => Transform.scale(
              scale: 0.5 + (_animations[index].value * 0.5),
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: widget.color.withValues(
                    alpha: 0.3 + (_animations[index].value * 0.7),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
