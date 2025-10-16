import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';

/// Card elevation variants for the Zoni design system.
enum ZoniCardElevation {
  /// No elevation (0dp)
  none,

  /// Low elevation (1dp)
  low,

  /// Medium elevation (3dp)
  medium,

  /// High elevation (6dp)
  high,
}

/// A customizable card widget following the Zoni design system.
/// 
/// This widget provides a consistent card implementation with multiple
/// elevation levels and styling options. It follows Material Design 3
/// guidelines for surface components.
/// 
/// Example usage:
/// ```dart
/// ZoniCard(
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Card content'),
///   ),
///   elevation: ZoniCardElevation.medium,
/// )
/// ```
class ZoniCard extends StatelessWidget {
  /// Creates a Zoni card.
  /// 
  /// The [child] parameter is required.
  /// The [elevation] parameter defaults to [ZoniCardElevation.low].
  const ZoniCard({
    required this.child,
    super.key,
    this.elevation = ZoniCardElevation.low,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.onTap,
    this.semanticLabel,
    this.clipBehavior = Clip.none,
  });

  /// The widget to display inside the card.
  final Widget child;

  /// The elevation level of the card.
  final ZoniCardElevation elevation;

  /// The margin around the card.
  /// 
  /// If null, uses the theme's default card margin.
  final EdgeInsetsGeometry? margin;

  /// The padding inside the card.
  /// 
  /// If null, no padding is applied.
  final EdgeInsetsGeometry? padding;

  /// The width of the card.
  /// 
  /// If null, the card will size itself to its content.
  final double? width;

  /// The height of the card.
  /// 
  /// If null, the card will size itself to its content.
  final double? height;

  /// Called when the card is tapped.
  /// 
  /// If null, the card will not be interactive.
  final VoidCallback? onTap;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// The clip behavior for the card.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final double cardElevation = _getElevation();
    
    Widget card = Card(
      elevation: cardElevation,
      margin: margin,
      clipBehavior: clipBehavior,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
      ),
      child: _buildCardContent(),
    );

    if (width != null || height != null) {
      card = SizedBox(
        width: width,
        height: height,
        child: card,
      );
    }

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
        child: card,
      );
    }

    if (semanticLabel != null) {
      card = Semantics(
        label: semanticLabel,
        child: card,
      );
    }

    return card;
  }

  Widget _buildCardContent() {
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: child,
      );
    }
    return child;
  }

  double _getElevation() {
    switch (elevation) {
      case ZoniCardElevation.none:
        return ZoniElevation.none;
      case ZoniCardElevation.low:
        return ZoniElevation.sm;
      case ZoniCardElevation.medium:
        return ZoniElevation.md;
      case ZoniCardElevation.high:
        return ZoniElevation.lg;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZoniCardElevation>('elevation', elevation))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(EnumProperty<Clip>('clipBehavior', clipBehavior));
  }
}
