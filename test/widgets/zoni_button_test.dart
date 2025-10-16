import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  group('ZoniButton', () {
    testWidgets('should render with default properties',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () => wasPressed = true,
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.tap(find.byType(ZoniButton));
      expect(wasPressed, true);
    });

    testWidgets('should render outlined variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () {},
              variant: ZoniButtonVariant.outlined,
              child: const Text('Outlined Button'),
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Outlined Button'), findsOneWidget);
    });

    testWidgets('should render text variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () {},
              variant: ZoniButtonVariant.text,
              child: const Text('Text Button'),
            ),
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('should render filled tonal variant',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () {},
              variant: ZoniButtonVariant.filledTonal,
              child: const Text('Filled Tonal Button'),
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.text('Filled Tonal Button'), findsOneWidget);
    });

    testWidgets('should show loading indicator when loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () {},
              isLoading: true,
              child: const Text('Loading Button'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);
    });

    testWidgets('should render with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () {},
              icon: const Icon(Icons.star),
              child: const Text('Icon Button'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);
    });

    testWidgets('should be disabled when onPressed is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniButton(
              onPressed: null,
              child: Text('Disabled Button'),
            ),
          ),
        ),
      );

      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('should render with tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () {},
              tooltip: 'Button tooltip',
              child: const Text('Tooltip Button'),
            ),
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);

      final Tooltip tooltip = tester.widget(find.byType(Tooltip));
      expect(tooltip.message, 'Button tooltip');
    });

    testWidgets('should render different sizes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: Column(
              children: <Widget>[
                ZoniButton(
                  onPressed: () {},
                  size: ZoniButtonSize.small,
                  child: const Text('Small'),
                ),
                ZoniButton(
                  onPressed: () {},
                  child: const Text('Medium'),
                ),
                ZoniButton(
                  onPressed: () {},
                  size: ZoniButtonSize.large,
                  child: const Text('Large'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
      expect(find.text('Medium'), findsOneWidget);
      expect(find.text('Large'), findsOneWidget);
    });

    testWidgets('should respect custom width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniButton(
              onPressed: () {},
              width: 200,
              child: const Text('Wide Button'),
            ),
          ),
        ),
      );

      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      final ButtonStyle? style = button.style;
      final Size? minimumSize = style?.minimumSize?.resolve(<WidgetState>{});

      expect(minimumSize?.width, 200);
    });
  });
}
