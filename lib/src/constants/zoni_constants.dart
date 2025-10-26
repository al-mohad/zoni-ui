/// Design system constants for the Zoni UI library.
///
/// This file contains all the design tokens and constants used throughout
/// the Zoni design system, including spacing, sizing, and other design values.
library;

/// Spacing constants following an 8pt grid system.
class ZoniSpacing {
  const ZoniSpacing._();

  /// Extra small spacing: 4px
  static const double xs = 4;

  /// Small spacing: 8px
  static const double sm = 8;

  /// Medium spacing: 16px
  static const double md = 16;

  /// Large spacing: 24px
  static const double lg = 24;

  /// Extra large spacing: 32px
  static const double xl = 32;

  /// Extra extra large spacing: 48px
  static const double xxl = 48;

  /// Extra extra extra large spacing: 64px
  static const double xxxl = 64;
}

/// Border radius constants for consistent rounded corners.
class ZoniBorderRadius {
  const ZoniBorderRadius._();

  /// No border radius: 0px
  static const double none = 0;

  /// Small border radius: 4px
  static const double sm = 4;

  /// Medium border radius: 8px
  static const double md = 8;

  /// Large border radius: 12px
  static const double lg = 12;

  /// Extra large border radius: 16px
  static const double xl = 16;

  /// Full border radius: 9999px (creates circular shape)
  static const double full = 9999;
}

/// Elevation constants for consistent shadow depths.
class ZoniElevation {
  const ZoniElevation._();

  /// No elevation: 0
  static const double none = 0;

  /// Extra small elevation: 0.5
  static const double xs = 0.5;

  /// Small elevation: 1
  static const double sm = 1;

  /// Medium elevation: 2
  static const double md = 2;

  /// Large elevation: 4
  static const double lg = 4;

  /// Extra large elevation: 8
  static const double xl = 8;

  /// Extra extra large elevation: 16
  static const double xxl = 16;
}

/// Animation duration constants for consistent motion.
class ZoniDuration {
  const ZoniDuration._();

  /// Fast animation: 150ms
  static const Duration fast = Duration(milliseconds: 150);

  /// Normal animation: 250ms
  static const Duration normal = Duration(milliseconds: 250);

  /// Slow animation: 350ms
  static const Duration slow = Duration(milliseconds: 350);

  /// Extra slow animation: 500ms
  static const Duration extraSlow = Duration(milliseconds: 500);
}

/// Breakpoint constants for responsive design.
class ZoniBreakpoints {
  const ZoniBreakpoints._();

  /// Mobile breakpoint: 0px - 767px
  static const double mobile = 768;

  /// Tablet breakpoint: 768px - 1023px
  static const double tablet = 1024;

  /// Desktop breakpoint: 1024px+
  static const double desktop = 1024;
}
