import 'package:flutter/material.dart';

/// Enhanced stack widget with common positioning utilities.
class ZoniStack extends StatelessWidget {
  /// Creates a Zoni stack.
  const ZoniStack({
    super.key,
    required this.children,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
  });

  /// The widgets to stack.
  final List<Widget> children;

  /// How to align the non-positioned children.
  final AlignmentGeometry alignment;

  /// Text direction for alignment.
  final TextDirection? textDirection;

  /// How to size the non-positioned children.
  final StackFit fit;

  /// How to clip the stack.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
      children: children,
    );
  }
}

/// Positioned widget with common positioning utilities.
class ZoniPositioned extends StatelessWidget {
  /// Creates a positioned widget.
  const ZoniPositioned({
    super.key,
    required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  });

  /// The widget to position.
  final Widget child;

  /// Distance from the left edge.
  final double? left;

  /// Distance from the top edge.
  final double? top;

  /// Distance from the right edge.
  final double? right;

  /// Distance from the bottom edge.
  final double? bottom;

  /// Width of the positioned widget.
  final double? width;

  /// Height of the positioned widget.
  final double? height;

  /// Creates a positioned widget at the top-left.
  const ZoniPositioned.topLeft({
    super.key,
    required this.child,
    this.left = 0,
    this.top = 0,
    this.width,
    this.height,
  }) : right = null, bottom = null;

  /// Creates a positioned widget at the top-right.
  const ZoniPositioned.topRight({
    super.key,
    required this.child,
    this.right = 0,
    this.top = 0,
    this.width,
    this.height,
  }) : left = null, bottom = null;

  /// Creates a positioned widget at the bottom-left.
  const ZoniPositioned.bottomLeft({
    super.key,
    required this.child,
    this.left = 0,
    this.bottom = 0,
    this.width,
    this.height,
  }) : right = null, top = null;

  /// Creates a positioned widget at the bottom-right.
  const ZoniPositioned.bottomRight({
    super.key,
    required this.child,
    this.right = 0,
    this.bottom = 0,
    this.width,
    this.height,
  }) : left = null, top = null;

  /// Creates a positioned widget that fills the entire stack.
  const ZoniPositioned.fill({
    super.key,
    required this.child,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  }) : width = null, height = null;

  /// Creates a centered positioned widget.
  const ZoniPositioned.center({
    super.key,
    required this.child,
    this.width,
    this.height,
  }) : left = null, top = null, right = null, bottom = null;

  @override
  Widget build(BuildContext context) {
    if (left == null && top == null && right == null && bottom == null) {
      // Center positioning
      return Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Center(
          child: SizedBox(
            width: width,
            height: height,
            child: child,
          ),
        ),
      );
    }

    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: child,
    );
  }
}

/// Flex widget with common configurations.
class ZoniFlex extends StatelessWidget {
  /// Creates a flex widget.
  const ZoniFlex({
    super.key,
    required this.children,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
  });

  /// The widgets to arrange.
  final List<Widget> children;

  /// The direction to arrange children.
  final Axis direction;

  /// How to align children along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How to align children along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space to occupy on the main axis.
  final MainAxisSize mainAxisSize;

  /// Text direction.
  final TextDirection? textDirection;

  /// Vertical direction.
  final VerticalDirection verticalDirection;

  /// Text baseline for alignment.
  final TextBaseline? textBaseline;

  /// How to clip the flex.
  final Clip clipBehavior;

  /// Creates a horizontal flex (Row).
  const ZoniFlex.row({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
  }) : direction = Axis.horizontal;

  /// Creates a vertical flex (Column).
  const ZoniFlex.column({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
  }) : direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      children: children,
    );
  }
}

/// Wrap widget with common configurations.
class ZoniWrap extends StatelessWidget {
  /// Creates a wrap widget.
  const ZoniWrap({
    super.key,
    required this.children,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  });

  /// The widgets to wrap.
  final List<Widget> children;

  /// The direction to arrange children.
  final Axis direction;

  /// How to align children within a run.
  final WrapAlignment alignment;

  /// Spacing between children in a run.
  final double spacing;

  /// How to align runs.
  final WrapAlignment runAlignment;

  /// Spacing between runs.
  final double runSpacing;

  /// How to align children within a run on the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// Text direction.
  final TextDirection? textDirection;

  /// Vertical direction.
  final VerticalDirection verticalDirection;

  /// How to clip the wrap.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      children: children,
    );
  }
}
