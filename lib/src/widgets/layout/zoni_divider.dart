import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// Enum for divider variants
enum ZoniDividerVariant {
  solid,
  dashed,
  dotted,
}

/// Enum for divider thickness
enum ZoniDividerThickness {
  thin,
  medium,
  thick,
}

/// A customizable divider component following Zoni design system.
///
/// The [ZoniDivider] widget provides a horizontal or vertical divider
/// with consistent styling and behavior across the application.
///
/// Example usage:
/// ```dart
/// ZoniDivider()
/// 
/// ZoniDivider.vertical(
///   height: 100,
///   variant: ZoniDividerVariant.dashed,
/// )
/// ```
class ZoniDivider extends StatelessWidget {
  /// Creates a horizontal Zoni divider.
  const ZoniDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.variant = ZoniDividerVariant.solid,
    this.thicknessLevel = ZoniDividerThickness.thin,
  }) : isVertical = false;

  /// Creates a vertical Zoni divider.
  const ZoniDivider.vertical({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.variant = ZoniDividerVariant.solid,
    this.thicknessLevel = ZoniDividerThickness.thin,
  }) : isVertical = true;

  /// The divider's height extent.
  final double? height;

  /// The thickness of the line drawn within the divider.
  final double? thickness;

  /// The amount of empty space to the leading edge of the divider.
  final double? indent;

  /// The amount of empty space to the trailing edge of the divider.
  final double? endIndent;

  /// The color to use when painting the line.
  final Color? color;

  /// The visual variant of the divider.
  final ZoniDividerVariant variant;

  /// The thickness level of the divider.
  final ZoniDividerThickness thicknessLevel;

  /// Whether this is a vertical divider.
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? ZoniColors.outline;
    final effectiveThickness = thickness ?? _getThickness();

    if (variant == ZoniDividerVariant.solid) {
      return isVertical
          ? VerticalDivider(
              width: height,
              thickness: effectiveThickness,
              indent: indent,
              endIndent: endIndent,
              color: effectiveColor,
            )
          : Divider(
              height: height,
              thickness: effectiveThickness,
              indent: indent,
              endIndent: endIndent,
              color: effectiveColor,
            );
    }

    return CustomPaint(
      size: isVertical
          ? Size(effectiveThickness, height ?? double.infinity)
          : Size(double.infinity, effectiveThickness),
      painter: _DividerPainter(
        color: effectiveColor,
        thickness: effectiveThickness,
        variant: variant,
        isVertical: isVertical,
        indent: indent ?? 0,
        endIndent: endIndent ?? 0,
      ),
    );
  }

  double _getThickness() {
    switch (thicknessLevel) {
      case ZoniDividerThickness.thin:
        return 1.0;
      case ZoniDividerThickness.medium:
        return 2.0;
      case ZoniDividerThickness.thick:
        return 4.0;
    }
  }
}

/// Custom painter for dashed and dotted dividers.
class _DividerPainter extends CustomPainter {
  const _DividerPainter({
    required this.color,
    required this.thickness,
    required this.variant,
    required this.isVertical,
    required this.indent,
    required this.endIndent,
  });

  final Color color;
  final double thickness;
  final ZoniDividerVariant variant;
  final bool isVertical;
  final double indent;
  final double endIndent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    if (isVertical) {
      _paintVertical(canvas, size, paint);
    } else {
      _paintHorizontal(canvas, size, paint);
    }
  }

  void _paintHorizontal(Canvas canvas, Size size, Paint paint) {
    final startX = indent;
    final endX = size.width - endIndent;
    final y = size.height / 2;

    if (variant == ZoniDividerVariant.dashed) {
      _drawDashedLine(canvas, paint, Offset(startX, y), Offset(endX, y));
    } else if (variant == ZoniDividerVariant.dotted) {
      _drawDottedLine(canvas, paint, Offset(startX, y), Offset(endX, y));
    }
  }

  void _paintVertical(Canvas canvas, Size size, Paint paint) {
    final startY = indent;
    final endY = size.height - endIndent;
    final x = size.width / 2;

    if (variant == ZoniDividerVariant.dashed) {
      _drawDashedLine(canvas, paint, Offset(x, startY), Offset(x, endY));
    } else if (variant == ZoniDividerVariant.dotted) {
      _drawDottedLine(canvas, paint, Offset(x, startY), Offset(x, endY));
    }
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    final distance = (end - start).distance;
    final dashCount = (distance / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startOffset = start + (end - start) * (i * (dashWidth + dashSpace) / distance);
      final endOffset = start + (end - start) * ((i * (dashWidth + dashSpace) + dashWidth) / distance);
      canvas.drawLine(startOffset, endOffset, paint);
    }
  }

  void _drawDottedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    const dotRadius = 1.0;
    const dotSpace = 3.0;
    final distance = (end - start).distance;
    final dotCount = (distance / (dotRadius * 2 + dotSpace)).floor();

    paint.style = PaintingStyle.fill;

    for (int i = 0; i < dotCount; i++) {
      final offset = start + (end - start) * (i * (dotRadius * 2 + dotSpace) / distance);
      canvas.drawCircle(offset, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _DividerPainter ||
        oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.variant != variant ||
        oldDelegate.isVertical != isVertical ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

/// A divider with text or icon in the middle.
class ZoniDividerWithContent extends StatelessWidget {
  /// Creates a divider with content in the middle.
  const ZoniDividerWithContent({
    super.key,
    required this.child,
    this.height,
    this.thickness,
    this.color,
    this.variant = ZoniDividerVariant.solid,
    this.thicknessLevel = ZoniDividerThickness.thin,
    this.spacing = ZoniSpacing.md,
  });

  /// The content to display in the middle of the divider.
  final Widget child;

  /// The divider's height extent.
  final double? height;

  /// The thickness of the line drawn within the divider.
  final double? thickness;

  /// The color to use when painting the line.
  final Color? color;

  /// The visual variant of the divider.
  final ZoniDividerVariant variant;

  /// The thickness level of the divider.
  final ZoniDividerThickness thicknessLevel;

  /// The spacing between the content and the divider lines.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ZoniDivider(
            height: height,
            thickness: thickness,
            color: color,
            variant: variant,
            thicknessLevel: thicknessLevel,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: child,
        ),
        Expanded(
          child: ZoniDivider(
            height: height,
            thickness: thickness,
            color: color,
            variant: variant,
            thicknessLevel: thicknessLevel,
          ),
        ),
      ],
    );
  }
}
