import 'package:flutter/material.dart';

import '../../theme/zoni_text_styles.dart';

/// A comprehensive text widget that provides access to all Zoni text styles.
class ZoniText extends StatelessWidget {
  /// Creates a ZoniText widget.
  const ZoniText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// The text to display.
  final String data;

  /// The style to apply to the text.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span.
  final int? maxLines;

  /// An alternative semantics label for this text.
  final String? semanticsLabel;

  /// The different ways of measuring the width of one or more lines of text.
  final TextWidthBasis? textWidthBasis;

  /// Defines how to apply TextStyle.height over and under text.
  final TextHeightBehavior? textHeightBehavior;

  /// The color to use when painting the selection.
  final Color? selectionColor;

  /// Creates a display large text.
  const ZoniText.displayLarge(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a display medium text.
  const ZoniText.displayMedium(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a display small text.
  const ZoniText.displaySmall(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a headline large text.
  const ZoniText.headlineLarge(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a headline medium text.
  const ZoniText.headlineMedium(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a headline small text.
  const ZoniText.headlineSmall(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a title large text.
  const ZoniText.titleLarge(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a title medium text.
  const ZoniText.titleMedium(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a title small text.
  const ZoniText.titleSmall(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a body large text.
  const ZoniText.bodyLarge(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a body medium text.
  const ZoniText.bodyMedium(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a body small text.
  const ZoniText.bodySmall(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a label large text.
  const ZoniText.labelLarge(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a label medium text.
  const ZoniText.labelMedium(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  /// Creates a label small text.
  const ZoniText.labelSmall(
    this.data, {
    super.key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : style = null;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveStyle = _getEffectiveStyle(context);

    return Text(
      data,
      style: style != null ? effectiveStyle.merge(style) : effectiveStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  TextStyle _getEffectiveStyle(BuildContext context) {
    // Determine which named constructor was used based on the style being null
    // and the runtimeType pattern
    final String constructorName = toString();

    if (constructorName.contains('displayLarge')) {
      return ZoniTextStyles.displayLarge;
    } else if (constructorName.contains('displayMedium')) {
      return ZoniTextStyles.displayMedium;
    } else if (constructorName.contains('displaySmall')) {
      return ZoniTextStyles.displaySmall;
    } else if (constructorName.contains('headlineLarge')) {
      return ZoniTextStyles.headlineLarge;
    } else if (constructorName.contains('headlineMedium')) {
      return ZoniTextStyles.headlineMedium;
    } else if (constructorName.contains('headlineSmall')) {
      return ZoniTextStyles.headlineSmall;
    } else if (constructorName.contains('titleLarge')) {
      return ZoniTextStyles.titleLarge;
    } else if (constructorName.contains('titleMedium')) {
      return ZoniTextStyles.titleMedium;
    } else if (constructorName.contains('titleSmall')) {
      return ZoniTextStyles.titleSmall;
    } else if (constructorName.contains('bodyLarge')) {
      return ZoniTextStyles.bodyLarge;
    } else if (constructorName.contains('bodyMedium')) {
      return ZoniTextStyles.bodyMedium;
    } else if (constructorName.contains('bodySmall')) {
      return ZoniTextStyles.bodySmall;
    } else if (constructorName.contains('labelLarge')) {
      return ZoniTextStyles.labelLarge;
    } else if (constructorName.contains('labelMedium')) {
      return ZoniTextStyles.labelMedium;
    } else if (constructorName.contains('labelSmall')) {
      return ZoniTextStyles.labelSmall;
    }

    // Default to bodyMedium if no specific constructor is detected
    return ZoniTextStyles.bodyMedium;
  }
}
