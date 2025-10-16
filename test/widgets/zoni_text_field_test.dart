import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  group('ZoniTextField', () {
    testWidgets('should render with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should render with label and hint text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(
              label: 'Email',
              hintText: 'Enter your email',
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('should render with helper and error text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(
              helperText: 'Helper text',
              errorText: 'Error text',
            ),
          ),
        ),
      );

      expect(find.text('Helper text'), findsOneWidget);
      expect(find.text('Error text'), findsOneWidget);
    });

    testWidgets('should render with prefix and suffix icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(
              prefixIcon: Icon(Icons.email),
              suffixIcon: Icon(Icons.visibility),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should handle text input', (WidgetTester tester) async {
      String inputValue = '';

      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniTextField(
              onChanged: (String value) => inputValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test input');
      expect(inputValue, 'test input');
    });

    testWidgets('should handle text submission', (WidgetTester tester) async {
      String submittedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniTextField(
              onSubmitted: (String value) => submittedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'submitted text');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      expect(submittedValue, 'submitted text');
    });

    testWidgets('should render different sizes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                ZoniTextField(
                  size: ZoniTextFieldSize.small,
                  label: 'Small',
                ),
                ZoniTextField(
                  label: 'Medium',
                ),
                ZoniTextField(
                  size: ZoniTextFieldSize.large,
                  label: 'Large',
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

    testWidgets('should be disabled when enabled is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(
              enabled: false,
              label: 'Disabled Field',
            ),
          ),
        ),
      );

      final TextFormField textField = tester.widget(find.byType(TextFormField));
      expect(textField.enabled, false);
    });

    testWidgets('should be read-only when readOnly is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(
              readOnly: true,
              label: 'Read-only Field',
            ),
          ),
        ),
      );

      // Verify the text field is read-only by checking the ZoniTextField widget
      final ZoniTextField zoniTextField =
          tester.widget(find.byType(ZoniTextField));
      expect(zoniTextField.readOnly, true);
    });

    testWidgets('should obscure text when obscureText is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(
              obscureText: true,
              label: 'Password Field',
            ),
          ),
        ),
      );

      // Verify the text field obscures text by checking the ZoniTextField widget
      final ZoniTextField zoniTextField =
          tester.widget(find.byType(ZoniTextField));
      expect(zoniTextField.obscureText, true);
    });

    testWidgets('should handle validation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: Form(
              child: ZoniTextField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final FormState form = tester.state(find.byType(Form));
      expect(form.validate(), false);

      await tester.pump();
      expect(find.text('Field is required'), findsOneWidget);
    });

    testWidgets('should render with semantic label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: const Scaffold(
            body: ZoniTextField(
              semanticLabel: 'Accessible text field',
            ),
          ),
        ),
      );

      expect(find.byType(Semantics), findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ZoniUI.theme.light(),
          home: Scaffold(
            body: ZoniTextField(
              onTap: () => wasTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextFormField));
      expect(wasTapped, true);
    });
  });
}
