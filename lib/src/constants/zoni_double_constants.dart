/// Double constants for the Zoni design system.
///
/// This class provides a comprehensive set of double constants organized by
/// usage categories to ensure consistency across the design system.
///
/// ## Usage Categories:
/// - **Spacing & Layout**: Padding, margins, gaps, and layout dimensions
/// - **Typography**: Line heights, letter spacing, and text scaling
/// - **Animation**: Duration, opacity, and scale values
/// - **Borders & Radius**: Border widths and corner radius values
/// - **Elevation**: Shadow and elevation values
///
/// ## Examples:
/// ```dart
/// // Spacing
/// Container(
///   padding: EdgeInsets.all(ZoniDoubleConstants.spacing16),
///   margin: EdgeInsets.symmetric(horizontal: ZoniDoubleConstants.spacing24),
/// )
///
/// // Typography
/// Text(
///   'Hello World',
///   style: TextStyle(
///     height: ZoniDoubleConstants.lineHeightNormal,
///     letterSpacing: ZoniDoubleConstants.letterSpacingNormal,
///   ),
/// )
///
/// // Animation
/// AnimatedOpacity(
///   opacity: isVisible ? ZoniDoubleConstants.opacityFull : ZoniDoubleConstants.opacityHidden,
///   duration: Duration(milliseconds: ZoniDoubleConstants.animationDurationMedium.toInt()),
/// )
/// ```
class ZoniDoubleConstants {
  // ============================================================================
  // SPACING & LAYOUT CONSTANTS
  // ============================================================================

  /// Zero spacing - used for no padding/margin
  static const double spacing0 = 0;

  /// Extra small spacing - 2px
  static const double spacing2 = 2;

  /// Small spacing - 4px
  static const double spacing4 = 4;

  /// Medium-small spacing - 8px
  static const double spacing8 = 8;

  /// Medium spacing - 12px
  static const double spacing12 = 12;

  /// Standard spacing - 16px (most commonly used)
  static const double spacing16 = 16;

  /// Large spacing - 20px
  static const double spacing20 = 20;

  /// Extra large spacing - 24px
  static const double spacing24 = 24;

  /// XXL spacing - 32px
  static const double spacing32 = 32;

  /// XXXL spacing - 40px
  static const double spacing40 = 40;

  /// Maximum spacing - 48px
  static const double spacing48 = 48;

  /// Section spacing - 64px
  static const double spacing64 = 64;

  /// Page spacing - 80px
  static const double spacing80 = 80;

  /// Hero spacing - 96px
  static const double spacing96 = 96;

  // ============================================================================
  // TYPOGRAPHY CONSTANTS
  // ============================================================================

  /// Tight line height - 1.2
  static const double lineHeightTight = 1.2;

  /// Normal line height - 1.4 (default for body text)
  static const double lineHeightNormal = 1.4;

  /// Relaxed line height - 1.5
  static const double lineHeightRelaxed = 1.5;

  /// Loose line height - 1.6 (for better readability)
  static const double lineHeightLoose = 1.6;

  /// Extra loose line height - 1.8
  static const double lineHeightExtraLoose = 1.8;

  /// Tight letter spacing - -0.5px
  static const double letterSpacingTight = -0.5;

  /// Normal letter spacing - 0px
  static const double letterSpacingNormal = 0;

  /// Wide letter spacing - 0.5px
  static const double letterSpacingWide = 0.5;

  /// Extra wide letter spacing - 1.0px
  static const double letterSpacingExtraWide = 1;

  // ============================================================================
  // OPACITY CONSTANTS
  // ============================================================================

  /// Completely transparent
  static const double opacityHidden = 0;

  /// Very low opacity - 10%
  static const double opacityVeryLow = 0.1;

  /// Low opacity - 30%
  static const double opacityLow = 0.3;

  /// Medium opacity - 50%
  static const double opacityMedium = 0.5;

  /// High opacity - 70%
  static const double opacityHigh = 0.7;

  /// Very high opacity - 85%
  static const double opacityVeryHigh = 0.85;

  /// Near full opacity - 90%
  static const double opacityNearFull = 0.9;

  /// Completely opaque
  static const double opacityFull = 1;

  // ============================================================================
  // BORDER & RADIUS CONSTANTS
  // ============================================================================

  /// No border radius
  static const double radiusNone = 0;

  /// Extra small border radius - 2px
  static const double radiusXS = 2;

  /// Small border radius - 4px
  static const double radiusSM = 4;

  /// Medium border radius - 8px (most commonly used)
  static const double radiusMD = 8;

  /// Large border radius - 12px
  static const double radiusLG = 12;

  /// Extra large border radius - 16px
  static const double radiusXL = 16;

  /// XXL border radius - 20px
  static const double radiusXXL = 20;

  /// XXXL border radius - 24px
  static const double radiusXXXL = 24;

  /// Full border radius - 9999px (creates circular shape)
  static const double radiusFull = 9999;

  /// Thin border width - 1px
  static const double borderThin = 1;

  /// Medium border width - 2px
  static const double borderMedium = 2;

  /// Thick border width - 4px
  static const double borderThick = 4;

  // ============================================================================
  // ANIMATION CONSTANTS
  // ============================================================================

  /// Very fast animation duration - 100ms
  static const double animationVeryFast = 100;

  /// Fast animation duration - 150ms
  static const double animationFast = 150;

  /// Normal animation duration - 200ms
  static const double animationNormal = 200;

  /// Medium animation duration - 300ms
  static const double animationMedium = 300;

  /// Slow animation duration - 500ms
  static const double animationSlow = 500;

  /// Very slow animation duration - 700ms
  static const double animationVerySlow = 700;

  /// Scale factor for pressed state - 0.95
  static const double scalePressed = 0.95;

  /// Scale factor for hover state - 1.05
  static const double scaleHover = 1.05;

  /// Scale factor for active state - 0.98
  static const double scaleActive = 0.98;

  // ============================================================================
  // ELEVATION CONSTANTS
  // ============================================================================

  /// No elevation
  static const double elevationNone = 0;

  /// Low elevation - 1px
  static const double elevationLow = 1;

  /// Medium elevation - 2px
  static const double elevationMedium = 2;

  /// High elevation - 4px
  static const double elevationHigh = 4;

  /// Very high elevation - 8px
  static const double elevationVeryHigh = 8;

  /// Maximum elevation - 16px
  static const double elevationMax = 16;

  // ============================================================================
  // SIZE CONSTANTS
  // ============================================================================

  /// Icon size extra small - 12px
  static const double iconXS = 12;

  /// Icon size small - 16px
  static const double iconSM = 16;

  /// Icon size medium - 20px
  static const double iconMD = 20;

  /// Icon size large - 24px
  static const double iconLG = 24;

  /// Icon size extra large - 32px
  static const double iconXL = 32;

  /// Icon size XXL - 40px
  static const double iconXXL = 40;

  /// Button height small - 32px
  static const double buttonHeightSM = 32;

  /// Button height medium - 40px
  static const double buttonHeightMD = 40;

  /// Button height large - 48px
  static const double buttonHeightLG = 48;

  /// Input field height small - 36px
  static const double inputHeightSM = 36;

  /// Input field height medium - 44px
  static const double inputHeightMD = 44;

  /// Input field height large - 52px
  static const double inputHeightLG = 52;

  // ============================================================================
  // LEGACY CONSTANTS (for backward compatibility)
  // ============================================================================

  /// @deprecated Use [lineHeightNormal] instead
  static const double lineSpacing = 1.4;

  /// @deprecated Use [lineHeightRelaxed] instead
  static const double lineSpacing2 = 1.5;

  /// @deprecated Use [lineHeightLoose] instead
  static const double lineSpacing3 = 1.6;

  /// @deprecated Use [opacityVeryHigh] instead
  static const double zeroPonit85 = 0.85;

  /// @deprecated Use [opacityLow] instead
  static const double double0Point3 = 0.3;

  /// @deprecated Use [opacityMedium] instead
  static const double double0Point5 = 0.5;

  /// @deprecated Use [opacityHigh] instead
  static const double double0Point7 = 0.7;

  /// @deprecated Use [opacityNearFull] instead
  static const double double0Point9 = 0.9;
}
