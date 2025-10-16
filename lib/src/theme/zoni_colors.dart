import 'package:flutter/material.dart';

/// Color palette for the Zoni design system.
///
/// This class provides a centralized collection of colors used throughout
/// the Zoni design system, ensuring consistency across all components.
/// Based on Zoni's refined color system for brand consistency across all platforms.
class ZoniColors {
  const ZoniColors._();

  // Core Palette - Primary brand colors designed for high contrast and accessibility
  /// Zoni Blue: Primary brand color (#007BFF)
  static const Color zoniBlue = Color(0xFF007BFF);

  /// Fresh Green: Secondary brand color (#28A745)
  static const Color freshGreen = Color(0xFF28A745);

  /// Neutral Gray: Supporting neutral color (#6C757D)
  static const Color neutralGray = Color(0xFF6C757D);

  /// Warm Orange: Accent color for calls-to-action (#FD7E14)
  static const Color warmOrange = Color(0xFFFD7E14);

  /// Soft White: Light background color (#FFFFFF)
  static const Color softWhite = Color(0xFFFFFFFF);

  /// Deep Black: Dark text and background color (#212529)
  static const Color deepBlack = Color(0xFF212529);

  // Wallet Sub-Palette - Financial trust-focused colors with Zoni Blue dominant
  /// Zoni Blue Tint: Lighter variant for accents (#339CFF)
  static const Color zoniBlueTint = Color(0xFF339CFF);

  // Store Sub-Palette - Empowerment-focused colors with Warm Orange as lead
  /// Warm Orange Shade: Deeper shade for calls-to-action (#D55500)
  static const Color warmOrangeShade = Color(0xFFD55500);

  // Logistics Sub-Palette - Rider and mapping oriented colors using Fresh Green
  /// Fresh Green Dark: Dark variant for depth (#1C6C2E)
  static const Color freshGreenDark = Color(0xFF1C6C2E);

  // Semantic Colors - Using core palette colors for consistency
  /// Primary color: Zoni Blue
  static const Color primary = zoniBlue;

  /// Primary variant color: Zoni Blue Tint
  static const Color primaryVariant = zoniBlueTint;

  /// Light primary color: Zoni Blue Tint
  static const Color primaryLight = zoniBlueTint;

  /// Dark primary color: Fresh Green Dark
  static const Color primaryDark = freshGreenDark;

  // Secondary Colors
  /// Secondary color: Fresh Green
  static const Color secondary = freshGreen;

  /// Secondary variant color: Fresh Green Dark
  static const Color secondaryVariant = freshGreenDark;

  // Semantic Colors - Using Zoni brand colors for consistency
  /// Success color: Fresh Green
  static const Color success = freshGreen;

  /// Success light color: Fresh Green (same as success)
  static const Color successLight = freshGreen;

  /// Success dark color: Fresh Green Dark
  static const Color successDark = freshGreenDark;

  /// Warning color: Warm Orange
  static const Color warning = warmOrange;

  /// Warning light color: Warm Orange (same as warning)
  static const Color warningLight = warmOrange;

  /// Warning dark color: Warm Orange Shade
  static const Color warningDark = warmOrangeShade;

  /// Error color: Warm Orange Shade (using for errors)
  static const Color error = warmOrangeShade;

  /// Error light color: Warm Orange
  static const Color errorLight = warmOrange;

  /// Error dark color: Deep Black
  static const Color errorDark = deepBlack;

  /// Info color: Zoni Blue
  static const Color info = zoniBlue;

  /// Info light color: Zoni Blue Tint
  static const Color infoLight = zoniBlueTint;

  /// Info dark color: Fresh Green Dark
  static const Color infoDark = freshGreenDark;

  // Surface Colors - Using Zoni brand colors
  /// Background color: Soft White
  static const Color background = softWhite;

  /// Surface color: Soft White
  static const Color surface = softWhite;

  /// Surface variant color: Soft White (same as surface)
  static const Color surfaceVariant = softWhite;

  /// Surface container color: Neutral Gray (light variant)
  static const Color surfaceContainer = Color(0xFFF8F9FA);

  /// Surface container high color: Neutral Gray (medium variant)
  static const Color surfaceContainerHigh = Color(0xFFE9ECEF);

  // Text Colors - Using Zoni brand colors for consistency
  /// Primary text color: Deep Black
  static const Color onSurface = deepBlack;

  /// Secondary text color: Neutral Gray
  static const Color onSurfaceVariant = neutralGray;

  /// Disabled text color: Neutral Gray (lighter variant)
  static const Color onSurfaceDisabled = Color(0xFF9AA0A6);

  /// Text on primary color: Soft White
  static const Color onPrimary = softWhite;

  /// Text on secondary color: Soft White
  static const Color onSecondary = softWhite;

  /// Text on error color: Soft White
  static const Color onError = softWhite;

  // Border Colors - Using Zoni brand colors
  /// Outline color: Neutral Gray
  static const Color outline = neutralGray;

  /// Outline variant color: Neutral Gray (lighter variant)
  static const Color outlineVariant = Color(0xFFDEE2E6);

  // Shadow Colors
  /// Shadow color: Deep Black with opacity
  static const Color shadow = deepBlack;

  /// Scrim color: Deep Black with opacity
  static const Color scrim = deepBlack;

  // Deprecated colors (for backward compatibility)
  /// @deprecated Use [onSurface] instead
  static const Color textPrimary = onSurface;

  /// @deprecated Use [onSurfaceVariant] instead
  static const Color textSecondary = onSurfaceVariant;
}
