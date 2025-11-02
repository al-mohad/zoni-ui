import 'package:flutter/material.dart';

/// Color palette for the Zoni design system.
///
/// This class provides a centralized collection of colors used throughout
/// the Zoni design system, ensuring consistency across all components.
/// Based on Zoni's refined color system for brand consistency across all platforms.
class ZoniColors {
  const ZoniColors._();

  // Core Palette - Primary brand colors designed for high contrast and accessibility
  /// Primary brand color: Teal Green (#00A08D)
  static const Color primary = Color(0xFF00A08D);

  /// Primary light color for hover states (#33B5A5)
  static const Color primaryLight = Color(0xFF33B5A5);

  /// Primary dark color for active states (#008075)
  static const Color primaryDark = Color(0xFF008075);

  /// Success color: Green (#10B981)
  static const Color success = Color(0xFF10B981);

  /// Warning color: Amber (#F59E0B)
  static const Color warning = Color(0xFFF59E0B);

  /// Error color: Red (#EF4444)
  static const Color error = Color(0xFFEF4444);

  /// Accent color: Orange (#FF6B35)
  static const Color accent = Color(0xFFFF6B35);

  /// Neutral Gray: Supporting neutral color (#6C757D)
  static const Color neutralGray = Color(0xFF6C757D);

  // Legacy Colors - kept for backward compatibility
  /// Legacy: Zoni Blue - Primary brand color (#007BFF)
  static const Color zoniBlue = Color(0xFF007BFF);

  /// Legacy: Fresh Green - Secondary brand color (#28A745)
  static const Color freshGreen = Color(0xFF28A745);

  /// Legacy: Warm Orange - Accent color for calls-to-action (#FD7E14)
  static const Color warmOrange = Color(0xFFFD7E14);

  /// Soft White: Light background color (#FFFFFF)
  static const Color softWhite = Color(0xFFFFFFFF);

  /// Deep Black: Dark text and background color (#212529)
  static const Color deepBlack = Color(0xFF212529);

  // Legacy Color Variants - kept for backward compatibility
  /// Legacy: Zoni Blue Tint - Lighter variant for accents (#339CFF)
  static const Color zoniBlueTint = Color(0xFF339CFF);

  /// Legacy: Warm Orange Shade - Deeper shade for calls-to-action (#D55500)
  static const Color warmOrangeShade = Color(0xFFD55500);

  /// Legacy: Fresh Green Dark - Dark variant for depth (#1C6C2E)
  static const Color freshGreenDark = Color(0xFF1C6C2E);

  // Primary Variants
  /// Primary variant color: Primary Dark
  static const Color primaryVariant = primaryDark;

  // Secondary Colors
  /// Secondary color: Primary
  static const Color secondary = primary;

  /// Secondary variant color: Primary Dark
  static const Color secondaryVariant = primaryDark;

  // Semantic Color Variants
  /// Success light color: Success (same as success)
  static const Color successLight = success;

  /// Success dark color: Primary Dark
  static const Color successDark = primaryDark;

  /// Warning light color: Warning (same as warning)
  static const Color warningLight = warning;

  /// Warning dark color: Darker warning variant
  static const Color warningDark = Color(0xFFD97706);

  /// Error light color: Accent
  static const Color errorLight = accent;

  /// Error dark color: Deep Black
  static const Color errorDark = deepBlack;

  /// Info color: Primary
  static const Color info = primary;

  /// Info light color: Primary Light
  static const Color infoLight = primaryLight;

  /// Info dark color: Primary Dark
  static const Color infoDark = primaryDark;

  // On Colors - Text colors for different backgrounds
  /// Text color on primary background
  static const Color onPrimary = softWhite;

  /// Text color on secondary background
  static const Color onSecondary = softWhite;

  /// Text color on success background
  static const Color onSuccess = softWhite;

  /// Text color on warning background
  static const Color onWarning = deepBlack;

  /// Text color on error background
  static const Color onError = softWhite;

  /// Text color on info background
  static const Color onInfo = softWhite;

  /// Text color on surface background
  static const Color onSurface = deepBlack;

  /// Text color on background
  static const Color onBackground = deepBlack;

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
  /// Secondary text color: Neutral Gray
  static const Color onSurfaceVariant = neutralGray;

  /// Disabled text color: Neutral Gray (lighter variant)
  static const Color onSurfaceDisabled = Color(0xFF9AA0A6);

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
