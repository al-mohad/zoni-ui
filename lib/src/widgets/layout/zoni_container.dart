import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';

/// A container widget that follows Zoni design system principles.
class ZoniContainer extends StatelessWidget {
  /// Creates a ZoniContainer.
  const ZoniContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.elevation = 0,
    this.shadowColor,
    this.borderRadius,
    this.border,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// Empty space to inscribe inside the container.
  final EdgeInsetsGeometry? padding;

  /// Empty space to surround the container.
  final EdgeInsetsGeometry? margin;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The color to paint behind the child.
  final Color? color;

  /// The decoration to paint behind the child.
  final Decoration? decoration;

  /// The decoration to paint in front of the child.
  final Decoration? foregroundDecoration;

  /// Additional constraints to apply to the child.
  final BoxConstraints? constraints;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The alignment of the origin for the transform.
  final AlignmentGeometry? transformAlignment;

  /// The clip behavior when content overflows.
  final Clip clipBehavior;

  /// The elevation of the container.
  final double elevation;

  /// The color of the shadow.
  final Color? shadowColor;

  /// The border radius of the container.
  final BorderRadius? borderRadius;

  /// The border of the container.
  final Border? border;

  /// Creates a ZoniContainer with small padding.
  const ZoniContainer.small({
    super.key,
    this.child,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.elevation = 0,
    this.shadowColor,
    this.borderRadius,
    this.border,
  }) : padding = const EdgeInsets.all(ZoniSpacing.sm);

  /// Creates a ZoniContainer with medium padding.
  const ZoniContainer.medium({
    super.key,
    this.child,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.elevation = 0,
    this.shadowColor,
    this.borderRadius,
    this.border,
  }) : padding = const EdgeInsets.all(ZoniSpacing.md);

  /// Creates a ZoniContainer with large padding.
  const ZoniContainer.large({
    super.key,
    this.child,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.elevation = 0,
    this.shadowColor,
    this.borderRadius,
    this.border,
  }) : padding = const EdgeInsets.all(ZoniSpacing.lg);

  /// Creates a ZoniContainer with card-like appearance.
  const ZoniContainer.card({
    super.key,
    this.child,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.foregroundDecoration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.shadowColor,
    this.border,
  })  : padding = const EdgeInsets.all(ZoniSpacing.md),
        elevation = ZoniElevation.sm,
        borderRadius =
            const BorderRadius.all(Radius.circular(ZoniBorderRadius.md)),
        decoration = null;

  /// Creates a ZoniContainer with surface appearance.
  const ZoniContainer.surface({
    super.key,
    this.child,
    this.margin,
    this.width,
    this.height,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.elevation = 0,
    this.shadowColor,
    this.border,
  })  : padding = const EdgeInsets.all(ZoniSpacing.md),
        color = ZoniColors.softWhite,
        borderRadius =
            const BorderRadius.all(Radius.circular(ZoniBorderRadius.sm));

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: _buildDecoration(),
      foregroundDecoration: foregroundDecoration,
      constraints: constraints,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );

    if (elevation > 0) {
      return Material(
        elevation: elevation,
        shadowColor: shadowColor ?? ZoniColors.deepBlack.withOpacity(0.1),
        borderRadius: borderRadius ?? BorderRadius.zero,
        color: Colors.transparent,
        child: container,
      );
    }

    return container;
  }

  Decoration? _buildDecoration() {
    if (decoration != null) {
      return decoration;
    }

    if (color != null || borderRadius != null || border != null) {
      return BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
      );
    }

    return null;
  }
}

/// A widget that provides consistent spacing in the Zoni design system.
class ZoniSpacer extends StatelessWidget {
  /// Creates a ZoniSpacer widget.
  const ZoniSpacer({
    super.key,
    required this.size,
  });

  /// The size of the spacing.
  final double size;

  /// Creates extra small spacing (4px).
  const ZoniSpacer.xs({super.key}) : size = ZoniSpacing.xs;

  /// Creates small spacing (8px).
  const ZoniSpacer.sm({super.key}) : size = ZoniSpacing.sm;

  /// Creates medium spacing (16px).
  const ZoniSpacer.md({super.key}) : size = ZoniSpacing.md;

  /// Creates large spacing (24px).
  const ZoniSpacer.lg({super.key}) : size = ZoniSpacing.lg;

  /// Creates extra large spacing (32px).
  const ZoniSpacer.xl({super.key}) : size = ZoniSpacing.xl;

  /// Creates extra extra large spacing (48px).
  const ZoniSpacer.xxl({super.key}) : size = ZoniSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
    );
  }
}

/// A widget that provides horizontal spacing in the Zoni design system.
class ZoniHorizontalSpacing extends StatelessWidget {
  /// Creates a ZoniHorizontalSpacing widget.
  const ZoniHorizontalSpacing({
    super.key,
    required this.size,
  });

  /// The size of the spacing.
  final double size;

  /// Creates extra small horizontal spacing (4px).
  const ZoniHorizontalSpacing.xs({super.key}) : size = ZoniSpacing.xs;

  /// Creates small horizontal spacing (8px).
  const ZoniHorizontalSpacing.sm({super.key}) : size = ZoniSpacing.sm;

  /// Creates medium horizontal spacing (16px).
  const ZoniHorizontalSpacing.md({super.key}) : size = ZoniSpacing.md;

  /// Creates large horizontal spacing (24px).
  const ZoniHorizontalSpacing.lg({super.key}) : size = ZoniSpacing.lg;

  /// Creates extra large horizontal spacing (32px).
  const ZoniHorizontalSpacing.xl({super.key}) : size = ZoniSpacing.xl;

  /// Creates extra extra large horizontal spacing (48px).
  const ZoniHorizontalSpacing.xxl({super.key}) : size = ZoniSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}

/// A widget that provides vertical spacing in the Zoni design system.
class ZoniVerticalSpacing extends StatelessWidget {
  /// Creates a ZoniVerticalSpacing widget.
  const ZoniVerticalSpacing({
    super.key,
    required this.size,
  });

  /// The size of the spacing.
  final double size;

  /// Creates extra small vertical spacing (4px).
  const ZoniVerticalSpacing.xs({super.key}) : size = ZoniSpacing.xs;

  /// Creates small vertical spacing (8px).
  const ZoniVerticalSpacing.sm({super.key}) : size = ZoniSpacing.sm;

  /// Creates medium vertical spacing (16px).
  const ZoniVerticalSpacing.md({super.key}) : size = ZoniSpacing.md;

  /// Creates large vertical spacing (24px).
  const ZoniVerticalSpacing.lg({super.key}) : size = ZoniSpacing.lg;

  /// Creates extra large vertical spacing (32px).
  const ZoniVerticalSpacing.xl({super.key}) : size = ZoniSpacing.xl;

  /// Creates extra extra large vertical spacing (48px).
  const ZoniVerticalSpacing.xxl({super.key}) : size = ZoniSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
