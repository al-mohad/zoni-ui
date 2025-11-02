import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  group('ZoniColors', () {
    test('should have consistent primary color values', () {
      expect(ZoniColors.primary, const Color(0xFF28A745)); // Fresh Green
      expect(
        ZoniColors.primaryVariant,
        const Color(0xFF1C6C2E),
      ); // Fresh Green Dark
      expect(
        ZoniColors.primaryLight,
        const Color(0xFF28A745),
      ); // Fresh Green
      expect(
        ZoniColors.primaryDark,
        const Color(0xFF1C6C2E),
      ); // Fresh Green Dark
    });

    test('should have consistent semantic color values', () {
      expect(ZoniColors.success, const Color(0xFF28A745)); // Fresh Green
      expect(ZoniColors.warning, const Color(0xFFFD7E14)); // Warm Orange
      expect(ZoniColors.error, const Color(0xFFD55500)); // Warm Orange Shade
      expect(ZoniColors.info, const Color(0xFF28A745)); // Fresh Green
    });

    test('should have consistent surface color values', () {
      expect(ZoniColors.background, const Color(0xFFFFFFFF)); // Soft White
      expect(ZoniColors.surface, const Color(0xFFFFFFFF)); // Soft White
      expect(ZoniColors.surfaceVariant, const Color(0xFFFFFFFF)); // Soft White
    });

    test('should have consistent text color values', () {
      expect(ZoniColors.onSurface, const Color(0xFF212529)); // Deep Black
      expect(
        ZoniColors.onSurfaceVariant,
        const Color(0xFF6C757D),
      ); // Neutral Gray
      expect(ZoniColors.onPrimary, const Color(0xFFFFFFFF)); // Soft White
    });
  });

  group('ZoniTextStyles', () {
    test('should have proper display text styles', () {
      expect(ZoniTextStyles.displayLarge.fontSize, 57);
      expect(ZoniTextStyles.displayMedium.fontSize, 45);
      expect(ZoniTextStyles.displaySmall.fontSize, 36);
    });

    test('should have proper headline text styles', () {
      expect(ZoniTextStyles.headlineLarge.fontSize, 32);
      expect(ZoniTextStyles.headlineMedium.fontSize, 28);
      expect(ZoniTextStyles.headlineSmall.fontSize, 24);
    });

    test('should have proper title text styles', () {
      expect(ZoniTextStyles.titleLarge.fontSize, 22);
      expect(ZoniTextStyles.titleMedium.fontSize, 16);
      expect(ZoniTextStyles.titleSmall.fontSize, 14);
    });

    test('should have proper body text styles', () {
      expect(ZoniTextStyles.bodyLarge.fontSize, 16);
      expect(ZoniTextStyles.bodyMedium.fontSize, 14);
      expect(ZoniTextStyles.bodySmall.fontSize, 12);
    });

    test('should have proper label text styles', () {
      expect(ZoniTextStyles.labelLarge.fontSize, 14);
      expect(ZoniTextStyles.labelMedium.fontSize, 12);
      expect(ZoniTextStyles.labelSmall.fontSize, 11);
    });

    test('should maintain backward compatibility', () {
      expect(ZoniTextStyles.headline1, ZoniTextStyles.headlineMedium);
      expect(ZoniTextStyles.headline2, ZoniTextStyles.titleLarge);
      expect(ZoniTextStyles.body, ZoniTextStyles.bodyMedium);
      expect(ZoniTextStyles.caption, ZoniTextStyles.bodySmall);
    });
  });

  group('ZoniSpacing', () {
    test('should follow 8pt grid system', () {
      expect(ZoniSpacing.xs, 4.0);
      expect(ZoniSpacing.sm, 8.0);
      expect(ZoniSpacing.md, 16.0);
      expect(ZoniSpacing.lg, 24.0);
      expect(ZoniSpacing.xl, 32.0);
      expect(ZoniSpacing.xxl, 48.0);
      expect(ZoniSpacing.xxxl, 64.0);
    });
  });

  group('ZoniBorderRadius', () {
    test('should have consistent border radius values', () {
      expect(ZoniBorderRadius.none, 0.0);
      expect(ZoniBorderRadius.sm, 4.0);
      expect(ZoniBorderRadius.md, 8.0);
      expect(ZoniBorderRadius.lg, 12.0);
      expect(ZoniBorderRadius.xl, 16.0);
      expect(ZoniBorderRadius.full, 9999.0);
    });
  });

  group('ZoniElevation', () {
    test('should have consistent elevation values', () {
      expect(ZoniElevation.none, 0.0);
      expect(ZoniElevation.sm, 1.0);
      expect(ZoniElevation.md, 2.0);
      expect(ZoniElevation.lg, 4.0);
      expect(ZoniElevation.xl, 8.0);
      expect(ZoniElevation.xxl, 16.0);
    });
  });

  group('ZoniDuration', () {
    test('should have consistent animation durations', () {
      expect(ZoniDuration.fast, const Duration(milliseconds: 150));
      expect(ZoniDuration.normal, const Duration(milliseconds: 250));
      expect(ZoniDuration.slow, const Duration(milliseconds: 350));
      expect(ZoniDuration.extraSlow, const Duration(milliseconds: 500));
    });
  });

  group('ZoniBreakpoints', () {
    test('should have consistent breakpoint values', () {
      expect(ZoniBreakpoints.mobile, 768.0);
      expect(ZoniBreakpoints.tablet, 1024.0);
      expect(ZoniBreakpoints.desktop, 1024.0);
    });
  });

  group('ZoniTheme', () {
    test('should create light theme with Material 3', () {
      final ThemeData theme = ZoniTheme.light();
      expect(theme.useMaterial3, true);
      expect(theme.colorScheme.primary, ZoniColors.primary);
      expect(theme.scaffoldBackgroundColor, ZoniColors.background);
    });

    test('should create dark theme with Material 3', () {
      final ThemeData theme = ZoniTheme.dark();
      expect(theme.useMaterial3, true);
      expect(theme.colorScheme.primary, ZoniColors.primaryLight);
      expect(theme.scaffoldBackgroundColor, const Color(0xFF121212));
    });
  });
}
