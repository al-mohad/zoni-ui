import 'package:flutter/material.dart';

import '../constants/zoni_constants.dart';
import 'zoni_colors.dart';
import 'zoni_text_styles.dart';

/// Theme configuration for the Zoni design system.
///
/// This class provides pre-configured [ThemeData] objects that implement
/// the Zoni design system's visual language and component styling.
/// Themes follow Material Design 3 specifications.
class ZoniTheme {
  const ZoniTheme._();

  /// Creates a light theme configuration for the Zoni design system.
  ///
  /// This theme implements Material Design 3 with Zoni brand colors
  /// and typography. All components are styled consistently according
  /// to the design system specifications.
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: _lightColorScheme,
        scaffoldBackgroundColor: ZoniColors.background,
        textTheme: _textTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        filledButtonTheme: _filledButtonTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        dividerTheme: _dividerTheme,
        chipTheme: _chipTheme,
      );

  /// Creates a dark theme configuration for the Zoni design system.
  ///
  /// This theme implements Material Design 3 dark theme with Zoni
  /// brand colors adapted for dark mode usage.
  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorScheme: _darkColorScheme,
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: _textTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        filledButtonTheme: _filledButtonTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        dividerTheme: _dividerTheme,
        chipTheme: _chipTheme,
      );

  // Color Schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: ZoniColors.primary,
    primaryContainer: ZoniColors.primaryLight,
    onPrimaryContainer: ZoniColors.primaryDark,
    secondary: ZoniColors.secondary,
    onSecondary: ZoniColors.onSecondary,
    secondaryContainer: ZoniColors.secondaryVariant,
    error: ZoniColors.error,
    errorContainer: ZoniColors.errorLight,
    onErrorContainer: ZoniColors.errorDark,
    onSurface: ZoniColors.onSurface,
    onSurfaceVariant: ZoniColors.onSurfaceVariant,
    outline: ZoniColors.outline,
    outlineVariant: ZoniColors.outlineVariant,
    shadow: ZoniColors.shadow,
    scrim: ZoniColors.scrim,
    surfaceContainerHighest: ZoniColors.surfaceContainerHigh,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: ZoniColors.primaryLight,
    onPrimary: ZoniColors.primaryDark,
    primaryContainer: ZoniColors.primaryDark,
    onPrimaryContainer: ZoniColors.primaryLight,
    secondary: ZoniColors.secondary,
    onSecondary: ZoniColors.onSecondary,
    secondaryContainer: ZoniColors.secondaryVariant,
    error: ZoniColors.errorLight,
    onError: ZoniColors.errorDark,
    errorContainer: ZoniColors.errorDark,
    onErrorContainer: ZoniColors.errorLight,
    onSurface: Color(0xFFE3E3E3),
    surfaceContainerHighest: Color(0xFF1E1E1E),
    onSurfaceVariant: Color(0xFFCAC4D0),
    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),
    shadow: ZoniColors.shadow,
    scrim: ZoniColors.scrim,
  );

  // Text Theme
  static const TextTheme _textTheme = TextTheme(
    displayLarge: ZoniTextStyles.displayLarge,
    displayMedium: ZoniTextStyles.displayMedium,
    displaySmall: ZoniTextStyles.displaySmall,
    headlineLarge: ZoniTextStyles.headlineLarge,
    headlineMedium: ZoniTextStyles.headlineMedium,
    headlineSmall: ZoniTextStyles.headlineSmall,
    titleLarge: ZoniTextStyles.titleLarge,
    titleMedium: ZoniTextStyles.titleMedium,
    titleSmall: ZoniTextStyles.titleSmall,
    labelLarge: ZoniTextStyles.labelLarge,
    labelMedium: ZoniTextStyles.labelMedium,
    labelSmall: ZoniTextStyles.labelSmall,
    bodyLarge: ZoniTextStyles.bodyLarge,
    bodyMedium: ZoniTextStyles.bodyMedium,
    bodySmall: ZoniTextStyles.bodySmall,
  );

  // Component Themes
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: ZoniSpacing.md,
        horizontal: ZoniSpacing.lg,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      ),
      elevation: ZoniElevation.sm,
      textStyle: ZoniTextStyles.labelLarge,
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: ZoniSpacing.md,
        horizontal: ZoniSpacing.lg,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      ),
      side: const BorderSide(color: ZoniColors.outline),
      textStyle: ZoniTextStyles.labelLarge,
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: ZoniSpacing.md,
        horizontal: ZoniSpacing.lg,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      ),
      textStyle: ZoniTextStyles.labelLarge,
    ),
  );

  static final FilledButtonThemeData _filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: ZoniSpacing.md,
        horizontal: ZoniSpacing.lg,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      ),
      textStyle: ZoniTextStyles.labelLarge,
    ),
  );

  static final CardThemeData _cardTheme = CardThemeData(
    elevation: ZoniElevation.sm,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
    ),
    margin: const EdgeInsets.all(ZoniSpacing.sm),
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    elevation: ZoniElevation.none,
    centerTitle: false,
    titleTextStyle: ZoniTextStyles.titleLarge,
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      borderSide: const BorderSide(color: ZoniColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      borderSide: const BorderSide(color: ZoniColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      borderSide: const BorderSide(color: ZoniColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
      borderSide: const BorderSide(color: ZoniColors.error),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: ZoniSpacing.md,
      horizontal: ZoniSpacing.md,
    ),
    labelStyle: ZoniTextStyles.bodyMedium,
    hintStyle: ZoniTextStyles.bodyMedium,
  );

  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: ZoniColors.outlineVariant,
    thickness: 1,
    space: 1,
  );

  static final ChipThemeData _chipTheme = ChipThemeData(
    backgroundColor: ZoniColors.surfaceVariant,
    deleteIconColor: ZoniColors.onSurfaceVariant,
    disabledColor: ZoniColors.onSurfaceDisabled,
    selectedColor: ZoniColors.primary,
    secondarySelectedColor: ZoniColors.secondary,
    padding: const EdgeInsets.symmetric(
      horizontal: ZoniSpacing.sm,
      vertical: ZoniSpacing.xs,
    ),
    labelStyle: ZoniTextStyles.labelMedium,
    secondaryLabelStyle: ZoniTextStyles.labelMedium,
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
    ),
  );
}
