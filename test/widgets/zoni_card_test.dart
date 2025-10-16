import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  group('ZoniCard', () {
    testWidgets('should render with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniCard(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should render with different elevation levels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                ZoniCard(
                  elevation: ZoniCardElevation.none,
                  child: Text('No Elevation'),
                ),
                ZoniCard(
                  child: Text('Low Elevation'),
                ),
                ZoniCard(
                  elevation: ZoniCardElevation.medium,
                  child: Text('Medium Elevation'),
                ),
                ZoniCard(
                  elevation: ZoniCardElevation.high,
                  child: Text('High Elevation'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('No Elevation'), findsOneWidget);
      expect(find.text('Low Elevation'), findsOneWidget);
      expect(find.text('Medium Elevation'), findsOneWidget);
      expect(find.text('High Elevation'), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(4));
    });

    testWidgets('should render with padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniCard(
              padding: EdgeInsets.all(16),
              child: Text('Padded Content'),
            ),
          ),
        ),
      );

      expect(find.text('Padded Content'), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);

      final Padding padding = tester.widget(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(16));
    });

    testWidgets('should render with custom dimensions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniCard(
              width: 200,
              height: 100,
              child: Text('Sized Card'),
            ),
          ),
        ),
      );

      expect(find.text('Sized Card'), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);

      final SizedBox sizedBox = tester.widget(find.byType(SizedBox));
      expect(sizedBox.width, 200);
      expect(sizedBox.height, 100);
    });

    testWidgets('should be tappable when onTap is provided',
        (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniCard(
              onTap: () => wasTapped = true,
              child: const Text('Tappable Card'),
            ),
          ),
        ),
      );

      expect(find.text('Tappable Card'), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);

      await tester.tap(find.byType(ZoniCard));
      expect(wasTapped, true);
    });

    testWidgets('should render with semantic label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniCard(
              semanticLabel: 'Accessible card',
              child: Text('Card with semantics'),
            ),
          ),
        ),
      );

      expect(find.text('Card with semantics'), findsOneWidget);
      expect(find.byType(Semantics), findsOneWidget);
    });

    testWidgets('should render with custom margin',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniCard(
              margin: EdgeInsets.all(20),
              child: Text('Card with margin'),
            ),
          ),
        ),
      );

      expect(find.text('Card with margin'), findsOneWidget);

      final Card card = tester.widget(find.byType(Card));
      expect(card.margin, const EdgeInsets.all(20));
    });

    testWidgets('should render with custom clip behavior',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniCard(
              clipBehavior: Clip.antiAlias,
              child: Text('Clipped card'),
            ),
          ),
        ),
      );

      expect(find.text('Clipped card'), findsOneWidget);

      final Card card = tester.widget(find.byType(Card));
      expect(card.clipBehavior, Clip.antiAlias);
    });
  });
}
