import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  group('ZoniUI Class', () {
    test('should provide access to nil widget', () {
      expect(ZoniUI.nil, isA<Widget>());
      expect(ZoniUI.nil, isA<Nil>());
    });

    test('should provide access to spacing constants', () {
      expect(ZoniUI.spacing.xs, equals(4));
      expect(ZoniUI.spacing.sm, equals(8));
      expect(ZoniUI.spacing.md, equals(16));
      expect(ZoniUI.spacing.lg, equals(24));
      expect(ZoniUI.spacing.xl, equals(32));
      expect(ZoniUI.spacing.xxl, equals(48));
      expect(ZoniUI.spacing.xxxl, equals(64));
    });

    test('should provide access to border radius constants', () {
      expect(ZoniUI.borderRadius.none, equals(0));
      expect(ZoniUI.borderRadius.sm, equals(4));
      expect(ZoniUI.borderRadius.md, equals(8));
      expect(ZoniUI.borderRadius.lg, equals(12));
      expect(ZoniUI.borderRadius.xl, equals(16));
      expect(ZoniUI.borderRadius.full, equals(9999));
    });

    test('should provide access to elevation constants', () {
      expect(ZoniUI.elevation.none, equals(0));
      expect(ZoniUI.elevation.sm, equals(1));
      expect(ZoniUI.elevation.md, equals(2));
      expect(ZoniUI.elevation.lg, equals(4));
      expect(ZoniUI.elevation.xl, equals(8));
      expect(ZoniUI.elevation.xxl, equals(16));
    });

    test('should provide access to duration constants', () {
      expect(ZoniUI.duration.fast, equals(const Duration(milliseconds: 150)));
      expect(ZoniUI.duration.normal, equals(const Duration(milliseconds: 250)));
      expect(ZoniUI.duration.slow, equals(const Duration(milliseconds: 350)));
      expect(
        ZoniUI.duration.extraSlow,
        equals(const Duration(milliseconds: 500)),
      );
    });

    test('should provide access to breakpoint constants', () {
      expect(ZoniUI.breakpoints.mobile, equals(768));
      expect(ZoniUI.breakpoints.tablet, equals(1024));
      expect(ZoniUI.breakpoints.desktop, equals(1024));
    });

    test('should provide access to colors', () {
      expect(ZoniUI.colors.primary, isA<Color>());
      expect(ZoniUI.colors.secondary, isA<Color>());
      expect(ZoniUI.colors.success, isA<Color>());
      expect(ZoniUI.colors.warning, isA<Color>());
      expect(ZoniUI.colors.error, isA<Color>());
      expect(ZoniUI.colors.info, isA<Color>());
    });

    test('should provide access to text styles', () {
      expect(ZoniUI.textStyles.displayLarge, isA<TextStyle>());
      expect(ZoniUI.textStyles.headlineLarge, isA<TextStyle>());
      expect(ZoniUI.textStyles.titleLarge, isA<TextStyle>());
      expect(ZoniUI.textStyles.bodyLarge, isA<TextStyle>());
      expect(ZoniUI.textStyles.labelLarge, isA<TextStyle>());
    });

    test('should provide access to themes', () {
      final ThemeData lightTheme = ZoniUI.theme.light();
      final ThemeData darkTheme = ZoniUI.theme.dark();

      expect(lightTheme, isA<ThemeData>());
      expect(darkTheme, isA<ThemeData>());
      expect(lightTheme.brightness, equals(Brightness.light));
      expect(darkTheme.brightness, equals(Brightness.dark));
    });

    test('should maintain consistency across multiple calls', () {
      // Test that getters return equivalent instances
      expect(ZoniUI.spacing.md, equals(ZoniUI.spacing.md));
      expect(ZoniUI.colors.primary, equals(ZoniUI.colors.primary));
      expect(
        ZoniUI.textStyles.bodyMedium,
        equals(ZoniUI.textStyles.bodyMedium),
      );
    });
  });
}
