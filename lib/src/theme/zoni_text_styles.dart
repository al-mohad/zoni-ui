import 'package:flutter/material.dart';

/// Typography styles for the Zoni design system.
///
/// This class provides a consistent set of text styles that follow
/// Material Design 3 typography guidelines and the Zoni brand standards.
/// The typography scale is based on a modular scale for visual harmony.
class ZoniTextStyles {
  const ZoniTextStyles._();

  // Display Styles (Large, prominent text)
  /// Display large text style (57px, Regular)
  /// Used for the largest text on screen, short and impactful.
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
  );

  /// Display medium text style (45px, Regular)
  /// Used for high-emphasis text that is slightly smaller than display large.
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
    letterSpacing: 0,
  );

  /// Display small text style (36px, Regular)
  /// Used for high-emphasis text that is smaller than display medium.
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
    letterSpacing: 0,
  );

  // Headline Styles (Medium-emphasis text)
  /// Headline large text style (32px, Regular)
  /// Used for high-emphasis text that is smaller than display styles.
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
    letterSpacing: 0,
  );

  /// Headline medium text style (28px, Regular)
  /// Used for high-emphasis text that is smaller than headline large.
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
    letterSpacing: 0,
  );

  /// Headline small text style (24px, Regular)
  /// Used for high-emphasis text that is smaller than headline medium.
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0,
  );

  // Title Styles (Medium-emphasis text, shorter than headlines)
  /// Title large text style (22px, Regular)
  /// Used for medium-emphasis text that is shorter than headlines.
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.27,
    letterSpacing: 0,
  );

  /// Title medium text style (16px, Medium)
  /// Used for medium-emphasis text that is shorter than title large.
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.50,
    letterSpacing: 0.15,
  );

  /// Title small text style (14px, Medium)
  /// Used for medium-emphasis text that is shorter than title medium.
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );

  // Label Styles (Small text for components)
  /// Label large text style (14px, Medium)
  /// Used for text in components like buttons.
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );

  /// Label medium text style (12px, Medium)
  /// Used for text in components like tabs.
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.5,
  );

  /// Label small text style (11px, Medium)
  /// Used for the smallest text in components.
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.5,
  );

  // Body Styles (Reading text)
  /// Body large text style (16px, Regular)
  /// Used for longer passages of text.
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0.5,
  );

  /// Body medium text style (14px, Regular)
  /// Used for reading text that is smaller than body large.
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  );

  /// Body small text style (12px, Regular)
  /// Used for reading text that is smaller than body medium.
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
  );

  // Deprecated styles (for backward compatibility)
  /// @deprecated Use [headlineMedium] instead
  static const TextStyle headline1 = headlineMedium;

  /// @deprecated Use [titleLarge] instead
  static const TextStyle headline2 = titleLarge;

  /// @deprecated Use [bodyMedium] instead
  static const TextStyle body = bodyMedium;

  /// @deprecated Use [bodySmall] instead
  static const TextStyle caption = bodySmall;
}
