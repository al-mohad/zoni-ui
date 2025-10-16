import 'package:flutter/material.dart';

import 'constants/zoni_constants.dart';
import 'theme/zoni_colors.dart';
import 'theme/zoni_text_styles.dart';
import 'theme/zoni_theme.dart';
import 'utils/zoni_logger.dart';
import 'widgets/others/nil.dart';

/// Wrapper class for ZoniSpacing to provide instance access to static properties.
class ZoniSpacingWrapper {
  const ZoniSpacingWrapper();

  double get xs => ZoniSpacing.xs;
  double get sm => ZoniSpacing.sm;
  double get md => ZoniSpacing.md;
  double get lg => ZoniSpacing.lg;
  double get xl => ZoniSpacing.xl;
  double get xxl => ZoniSpacing.xxl;
  double get xxxl => ZoniSpacing.xxxl;
}

/// Wrapper class for ZoniBorderRadius to provide instance access to static properties.
class ZoniBorderRadiusWrapper {
  const ZoniBorderRadiusWrapper();

  double get none => ZoniBorderRadius.none;
  double get sm => ZoniBorderRadius.sm;
  double get md => ZoniBorderRadius.md;
  double get lg => ZoniBorderRadius.lg;
  double get xl => ZoniBorderRadius.xl;
  double get full => ZoniBorderRadius.full;
}

/// Wrapper class for ZoniElevation to provide instance access to static properties.
class ZoniElevationWrapper {
  const ZoniElevationWrapper();

  double get none => ZoniElevation.none;
  double get sm => ZoniElevation.sm;
  double get md => ZoniElevation.md;
  double get lg => ZoniElevation.lg;
  double get xl => ZoniElevation.xl;
  double get xxl => ZoniElevation.xxl;
}

/// Wrapper class for ZoniDuration to provide instance access to static properties.
class ZoniDurationWrapper {
  const ZoniDurationWrapper();

  Duration get fast => ZoniDuration.fast;
  Duration get normal => ZoniDuration.normal;
  Duration get slow => ZoniDuration.slow;
  Duration get extraSlow => ZoniDuration.extraSlow;
}

/// Wrapper class for ZoniBreakpoints to provide instance access to static properties.
class ZoniBreakpointsWrapper {
  const ZoniBreakpointsWrapper();

  double get mobile => ZoniBreakpoints.mobile;
  double get tablet => ZoniBreakpoints.tablet;
  double get desktop => ZoniBreakpoints.desktop;
}

/// Wrapper class for ZoniColors to provide instance access to static properties.
class ZoniColorsWrapper {
  const ZoniColorsWrapper();

  Color get primary => ZoniColors.primary;
  Color get primaryLight => ZoniColors.primaryLight;
  Color get primaryDark => ZoniColors.primaryDark;
  Color get secondary => ZoniColors.secondary;
  Color get success => ZoniColors.success;
  Color get warning => ZoniColors.warning;
  Color get error => ZoniColors.error;
  Color get info => ZoniColors.info;
  Color get surface => ZoniColors.surface;
  Color get background => ZoniColors.background;
  Color get onSurface => ZoniColors.onSurface;
  Color get onSurfaceVariant => ZoniColors.onSurfaceVariant;
  Color get outline => ZoniColors.outline;
}

/// Wrapper class for ZoniTextStyles to provide instance access to static properties.
class ZoniTextStylesWrapper {
  const ZoniTextStylesWrapper();

  TextStyle get displayLarge => ZoniTextStyles.displayLarge;
  TextStyle get displayMedium => ZoniTextStyles.displayMedium;
  TextStyle get displaySmall => ZoniTextStyles.displaySmall;
  TextStyle get headlineLarge => ZoniTextStyles.headlineLarge;
  TextStyle get headlineMedium => ZoniTextStyles.headlineMedium;
  TextStyle get headlineSmall => ZoniTextStyles.headlineSmall;
  TextStyle get titleLarge => ZoniTextStyles.titleLarge;
  TextStyle get titleMedium => ZoniTextStyles.titleMedium;
  TextStyle get titleSmall => ZoniTextStyles.titleSmall;
  TextStyle get bodyLarge => ZoniTextStyles.bodyLarge;
  TextStyle get bodyMedium => ZoniTextStyles.bodyMedium;
  TextStyle get bodySmall => ZoniTextStyles.bodySmall;
  TextStyle get labelLarge => ZoniTextStyles.labelLarge;
  TextStyle get labelMedium => ZoniTextStyles.labelMedium;
  TextStyle get labelSmall => ZoniTextStyles.labelSmall;
}

/// Wrapper class for ZoniTheme to provide instance access to static methods.
class ZoniThemeWrapper {
  const ZoniThemeWrapper();

  ThemeData light() => ZoniTheme.light();
  ThemeData dark() => ZoniTheme.dark();
}

/// The main ZoniUI class providing access to design system utilities.
///
/// This class serves as a centralized access point for all Zoni UI
/// design system components, constants, and utilities.
///
/// Example usage:
/// ```dart
/// // Access the nil widget
/// Widget myWidget = ZoniUI.nil;
///
/// // Access design constants
/// double spacing = ZoniUI.spacing.md;
/// Color primaryColor = ZoniUI.colors.primary;
/// TextStyle titleStyle = ZoniUI.textStyles.titleLarge;
///
/// // Access themes
/// ThemeData lightTheme = ZoniUI.theme.light();
/// ThemeData darkTheme = ZoniUI.theme.dark();
/// ```
abstract final class ZoniUI {
  /// A widget which is not in the layout and does nothing.
  /// It is useful when you have to return a widget and can't return null.
  ///
  /// Example:
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return condition ? MyWidget() : ZoniUI.nil;
  /// }
  /// ```
  static const Widget nil = Nil();

  /// Access to the Zoni design system spacing constants.
  ///
  /// Provides access to the 8pt grid system spacing values:
  /// - `ZoniUI.spacing.xs` (4px)
  /// - `ZoniUI.spacing.sm` (8px)
  /// - `ZoniUI.spacing.md` (16px)
  /// - `ZoniUI.spacing.lg` (24px)
  /// - `ZoniUI.spacing.xl` (32px)
  /// - `ZoniUI.spacing.xxl` (48px)
  /// - `ZoniUI.spacing.xxxl` (64px)
  static const ZoniSpacingWrapper spacing = ZoniSpacingWrapper();

  /// Access to the Zoni design system border radius constants.
  ///
  /// Provides access to consistent border radius values:
  /// - `ZoniUI.borderRadius.none` (0px)
  /// - `ZoniUI.borderRadius.sm` (4px)
  /// - `ZoniUI.borderRadius.md` (8px)
  /// - `ZoniUI.borderRadius.lg` (12px)
  /// - `ZoniUI.borderRadius.xl` (16px)
  /// - `ZoniUI.borderRadius.full` (9999px)
  static const ZoniBorderRadiusWrapper borderRadius = ZoniBorderRadiusWrapper();

  /// Access to the Zoni design system elevation constants.
  ///
  /// Provides access to Material Design 3 elevation values:
  /// - `ZoniUI.elevation.none` (0)
  /// - `ZoniUI.elevation.sm` (1)
  /// - `ZoniUI.elevation.md` (2)
  /// - `ZoniUI.elevation.lg` (4)
  /// - `ZoniUI.elevation.xl` (8)
  /// - `ZoniUI.elevation.xxl` (16)
  static const ZoniElevationWrapper elevation = ZoniElevationWrapper();

  /// Access to the Zoni design system animation duration constants.
  ///
  /// Provides access to consistent animation timing:
  /// - `ZoniUI.duration.fast` (150ms)
  /// - `ZoniUI.duration.normal` (300ms)
  /// - `ZoniUI.duration.slow` (500ms)
  /// - `ZoniUI.duration.extraSlow` (1000ms)
  static const ZoniDurationWrapper duration = ZoniDurationWrapper();

  /// Access to the Zoni design system breakpoint constants.
  ///
  /// Provides access to responsive design breakpoints:
  /// - `ZoniUI.breakpoints.mobile` (768px)
  /// - `ZoniUI.breakpoints.tablet` (1024px)
  /// - `ZoniUI.breakpoints.desktop` (1024px)
  static const ZoniBreakpointsWrapper breakpoints = ZoniBreakpointsWrapper();

  /// Access to the Zoni design system color palette.
  ///
  /// Provides access to all design system colors:
  /// - Primary colors: `ZoniUI.colors.primary`, etc.
  /// - Secondary colors: `ZoniUI.colors.secondary`, etc.
  /// - Semantic colors: `ZoniUI.colors.success`, etc.
  /// - Surface colors: `ZoniUI.colors.surface`, etc.
  static const ZoniColorsWrapper colors = ZoniColorsWrapper();

  /// Access to the Zoni design system text styles.
  ///
  /// Provides access to the complete typography scale:
  /// - Display styles: `ZoniUI.textStyles.displayLarge`, etc.
  /// - Headline styles: `ZoniUI.textStyles.headlineLarge`, etc.
  /// - Title styles: `ZoniUI.textStyles.titleLarge`, etc.
  /// - Body styles: `ZoniUI.textStyles.bodyLarge`, etc.
  /// - Label styles: `ZoniUI.textStyles.labelLarge`, etc.
  static const ZoniTextStylesWrapper textStyles = ZoniTextStylesWrapper();

  /// Access to the Zoni design system themes.
  ///
  /// Provides access to pre-configured Material Design 3 themes:
  /// - `ZoniUI.theme.light()` - Light theme
  /// - `ZoniUI.theme.dark()` - Dark theme
  static const ZoniThemeWrapper theme = ZoniThemeWrapper();

  // Logger methods for debugging and development

  /// Logs a debug message. Use for development information.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.logDebug('Component rendered', metadata: {'widget': 'ZoniButton'});
  /// ```
  static void logDebug(String message, {Object? metadata}) {
    ZoniLogger.debug(message, metadata: metadata);
  }

  /// Logs an info message. Use for general information.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.logInfo('User logged in successfully');
  /// ```
  static void logInfo(String message, {Object? metadata}) {
    ZoniLogger.info(message, metadata: metadata);
  }

  /// Logs a success message. Use for successful operations.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.logSuccess('Data saved successfully');
  /// ```
  static void logSuccess(String message, {Object? metadata}) {
    ZoniLogger.success(message, metadata: metadata);
  }

  /// Logs a warning message. Use for potential issues.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.logWarning('API response slow', metadata: {'duration': '2.5s'});
  /// ```
  static void logWarning(String message, {Object? metadata}) {
    ZoniLogger.warning(message, metadata: metadata);
  }

  /// Logs an error message. Use for recoverable errors.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.logError('Failed to load data', metadata: {'error': exception});
  /// ```
  static void logError(String message, {Object? metadata}) {
    ZoniLogger.error(message, metadata: metadata);
  }

  /// Logs a critical error message. Use for severe errors.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.logCritical('Database connection lost');
  /// ```
  static void logCritical(String message, {Object? metadata}) {
    ZoniLogger.critical(message, metadata: metadata);
  }

  /// Generic log method that accepts any log level.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.log(ZoniLogLevel.info, 'Custom log message');
  /// ```
  static void log(ZoniLogLevel level, String message, {Object? metadata}) {
    ZoniLogger.log(level, message, metadata: metadata);
  }

  /// Quick print function for simple debug output.
  ///
  /// Only works in debug mode. Similar to print() but with Zoni formatting.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.pp('Quick debug message');
  /// ```
  static void pp(Object? object) {
    ZoniLogger.pp(object);
  }

  /// Quick log function for simple debug output.
  ///
  /// Works in debug and profile modes. Uses dart:developer log.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.ll('Debug information');
  /// ```
  static void ll(Object? object) {
    ZoniLogger.ll(object);
  }

  /// Initializes the logger with custom settings.
  ///
  /// Example:
  /// ```dart
  /// ZoniUI.initializeLogger(
  ///   isEnabled: true,
  ///   allowedLevels: {ZoniLogLevel.error, ZoniLogLevel.critical},
  ///   prefix: 'MyApp',
  /// );
  /// ```
  static void initializeLogger({
    bool? isEnabled,
    Set<ZoniLogLevel>? allowedLevels,
    String? prefix,
  }) {
    ZoniLogger.initialize(
      isEnabled: isEnabled,
      allowedLevels: allowedLevels,
      prefix: prefix,
    );
  }
}
