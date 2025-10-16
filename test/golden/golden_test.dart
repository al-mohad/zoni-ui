import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  group('Golden Tests', () {
    setUpAll(() async {
      await loadAppFonts();
    });

    group('ZoniButton Golden Tests', () {
      testGoldens('ZoniButton variants', (WidgetTester tester) async {
        final Widget widget = MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Button Variants',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ZoniButton(
                    onPressed: () {},
                    child: const Text('Filled Button'),
                  ),
                  const SizedBox(height: 8),
                  ZoniButton(
                    onPressed: () {},
                    variant: ZoniButtonVariant.outlined,
                    child: const Text('Outlined Button'),
                  ),
                  const SizedBox(height: 8),
                  ZoniButton(
                    onPressed: () {},
                    variant: ZoniButtonVariant.text,
                    child: const Text('Text Button'),
                  ),
                  const SizedBox(height: 8),
                  ZoniButton(
                    onPressed: () {},
                    variant: ZoniButtonVariant.filledTonal,
                    child: const Text('Filled Tonal Button'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidgetBuilder(widget);
        await screenMatchesGolden(tester, 'zoni_button_variants');
      });

      testGoldens('ZoniButton sizes', (WidgetTester tester) async {
        final Widget widget = MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Button Sizes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ZoniButton(
                    onPressed: () {},
                    size: ZoniButtonSize.small,
                    child: const Text('Small Button'),
                  ),
                  const SizedBox(height: 8),
                  ZoniButton(
                    onPressed: () {},
                    child: const Text('Medium Button'),
                  ),
                  const SizedBox(height: 8),
                  ZoniButton(
                    onPressed: () {},
                    size: ZoniButtonSize.large,
                    child: const Text('Large Button'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidgetBuilder(widget);
        await screenMatchesGolden(tester, 'zoni_button_sizes');
      });

      testGoldens('ZoniButton states', (WidgetTester tester) async {
        final Widget widget = MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Button States',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ZoniButton(
                    onPressed: () {},
                    child: const Text('Enabled Button'),
                  ),
                  const SizedBox(height: 8),
                  const ZoniButton(
                    onPressed: null,
                    child: Text('Disabled Button'),
                  ),
                  const SizedBox(height: 8),
                  ZoniButton(
                    onPressed: () {},
                    isLoading: true,
                    child: const Text('Loading Button'),
                  ),
                  const SizedBox(height: 8),
                  ZoniButton(
                    onPressed: () {},
                    icon: const Icon(Icons.star),
                    child: const Text('Icon Button'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidgetBuilder(widget);
        await screenMatchesGolden(tester, 'zoni_button_states');
      });
    });

    group('ZoniCard Golden Tests', () {
      testGoldens('ZoniCard elevations', (WidgetTester tester) async {
        final Widget widget = MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            backgroundColor: Colors.grey[100],
            body: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Card Elevations',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ZoniCard(
                    elevation: ZoniCardElevation.none,
                    padding: EdgeInsets.all(16),
                    child: Text('No Elevation'),
                  ),
                  SizedBox(height: 16),
                  ZoniCard(
                    padding: EdgeInsets.all(16),
                    child: Text('Low Elevation'),
                  ),
                  SizedBox(height: 16),
                  ZoniCard(
                    elevation: ZoniCardElevation.medium,
                    padding: EdgeInsets.all(16),
                    child: Text('Medium Elevation'),
                  ),
                  SizedBox(height: 16),
                  ZoniCard(
                    elevation: ZoniCardElevation.high,
                    padding: EdgeInsets.all(16),
                    child: Text('High Elevation'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidgetBuilder(widget);
        await screenMatchesGolden(tester, 'zoni_card_elevations');
      });
    });

    group('ZoniTextField Golden Tests', () {
      testGoldens('ZoniTextField states', (WidgetTester tester) async {
        final Widget widget = MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Text Field States',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ZoniTextField(
                    label: 'Default Field',
                    hintText: 'Enter text here',
                  ),
                  SizedBox(height: 16),
                  ZoniTextField(
                    label: 'Field with Helper',
                    helperText: 'This is helper text',
                  ),
                  SizedBox(height: 16),
                  ZoniTextField(
                    label: 'Field with Error',
                    errorText: 'This is an error message',
                  ),
                  SizedBox(height: 16),
                  ZoniTextField(
                    label: 'Disabled Field',
                    enabled: false,
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidgetBuilder(widget);
        await screenMatchesGolden(tester, 'zoni_text_field_states');
      });
    });

    group('ZoniLoadingIndicator Golden Tests', () {
      testGoldens('ZoniLoadingIndicator variants', (WidgetTester tester) async {
        final Widget widget = MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Loading Indicators',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      ZoniLoadingIndicator(
                        size: ZoniLoadingSize.small,
                      ),
                      SizedBox(width: 16),
                      ZoniLoadingIndicator(),
                      SizedBox(width: 16),
                      ZoniLoadingIndicator(
                        size: ZoniLoadingSize.large,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ZoniLoadingIndicator(
                    style: ZoniLoadingStyle.linear,
                  ),
                  SizedBox(height: 16),
                  ZoniLoadingIndicator(
                    style: ZoniLoadingStyle.dots,
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpWidgetBuilder(widget);
        await screenMatchesGolden(tester, 'zoni_loading_indicator_variants');
      });
    });
  });
}
