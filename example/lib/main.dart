import 'package:flutter/material.dart';
import 'package:zoni_ui/zoni_ui.dart';

import 'logger_demo.dart';

void main() {
  runApp(const ZoniUIExampleApp());
}

class ZoniUIExampleApp extends StatelessWidget {
  const ZoniUIExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Zoni UI Example',
        theme: ZoniUI.theme.light(),
        darkTheme: ZoniUI.theme.dark(),
        home: const ExampleHomePage(),
      );
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  bool _isDarkMode = false;
  bool _isLoading = false;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Theme(
        data: _isDarkMode ? ZoniUI.theme.dark() : ZoniUI.theme.light(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Zoni UI Components'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.bug_report),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoggerDemoPage(),
                    ),
                  );
                },
                tooltip: 'Logger Demo',
              ),
              IconButton(
                icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(ZoniUI.spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildSection(
                  'Buttons',
                  _buildButtonExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Cards',
                  _buildCardExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Text Fields',
                  _buildTextFieldExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Loading Indicators',
                  _buildLoadingExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Typography',
                  _buildTypographyExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Colors',
                  _buildColorExamples(),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildSection(String title, Widget content) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: ZoniUI.textStyles.headlineMedium,
          ),
          SizedBox(height: ZoniUI.spacing.md),
          content,
        ],
      );

  Widget _buildButtonExamples() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Button Variants'),
          SizedBox(height: ZoniUI.spacing.sm),
          Wrap(
            spacing: ZoniUI.spacing.sm,
            runSpacing: ZoniUI.spacing.sm,
            children: <Widget>[
              ZoniButton(
                onPressed: () => _showSnackBar('Filled button pressed'),
                child: const Text('Filled'),
              ),
              ZoniButton(
                onPressed: () => _showSnackBar('Outlined button pressed'),
                variant: ZoniButtonVariant.outlined,
                child: const Text('Outlined'),
              ),
              ZoniButton(
                onPressed: () => _showSnackBar('Text button pressed'),
                variant: ZoniButtonVariant.text,
                child: const Text('Text'),
              ),
              ZoniButton(
                onPressed: () => _showSnackBar('Filled tonal button pressed'),
                variant: ZoniButtonVariant.filledTonal,
                child: const Text('Filled Tonal'),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const Text('Button Sizes'),
          SizedBox(height: ZoniUI.spacing.sm),
          Wrap(
            spacing: ZoniUI.spacing.sm,
            runSpacing: ZoniUI.spacing.sm,
            children: <Widget>[
              ZoniButton(
                onPressed: () => _showSnackBar('Small button pressed'),
                size: ZoniButtonSize.small,
                child: const Text('Small'),
              ),
              ZoniButton(
                onPressed: () => _showSnackBar('Medium button pressed'),
                child: const Text('Medium'),
              ),
              ZoniButton(
                onPressed: () => _showSnackBar('Large button pressed'),
                size: ZoniButtonSize.large,
                child: const Text('Large'),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const Text('Button States'),
          SizedBox(height: ZoniUI.spacing.sm),
          Wrap(
            spacing: ZoniUI.spacing.sm,
            runSpacing: ZoniUI.spacing.sm,
            children: <Widget>[
              ZoniButton(
                onPressed: _toggleLoading,
                isLoading: _isLoading,
                child: Text(_isLoading ? 'Loading...' : 'Toggle Loading'),
              ),
              ZoniButton(
                onPressed: () => _showSnackBar('Icon button pressed'),
                icon: const Icon(Icons.star),
                child: const Text('With Icon'),
              ),
              const ZoniButton(
                onPressed: null,
                child: Text('Disabled'),
              ),
            ],
          ),
        ],
      );

  Widget _buildCardExamples() => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: ZoniCard(
                  padding: EdgeInsets.all(ZoniUI.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Low Elevation Card',
                        style: ZoniUI.textStyles.titleMedium,
                      ),
                      SizedBox(height: ZoniUI.spacing.sm),
                      const Text('This card has low elevation.'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: ZoniUI.spacing.md),
              Expanded(
                child: ZoniCard(
                  elevation: ZoniCardElevation.high,
                  padding: EdgeInsets.all(ZoniUI.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'High Elevation Card',
                        style: ZoniUI.textStyles.titleMedium,
                      ),
                      SizedBox(height: ZoniUI.spacing.sm),
                      const Text('This card has high elevation.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.md),
          ZoniCard(
            elevation: ZoniCardElevation.medium,
            padding: EdgeInsets.all(ZoniUI.spacing.md),
            onTap: () => _showSnackBar('Tappable card pressed'),
            child: Row(
              children: <Widget>[
                const Icon(Icons.touch_app),
                SizedBox(width: ZoniUI.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tappable Card',
                        style: ZoniUI.textStyles.titleMedium,
                      ),
                      const Text('Tap this card to see interaction.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildTextFieldExamples() => Column(
        children: <Widget>[
          ZoniTextField(
            controller: _textController,
            label: 'Basic Text Field',
            hintText: 'Enter some text',
            onChanged: (String value) => debugPrint('Input: $value'),
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const ZoniTextField(
            label: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const ZoniTextField(
            label: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: Icon(Icons.visibility),
            obscureText: true,
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const ZoniTextField(
            label: 'Field with Helper',
            helperText: 'This is helper text',
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const ZoniTextField(
            label: 'Field with Error',
            errorText: 'This field has an error',
          ),
        ],
      );

  Widget _buildLoadingExamples() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Circular Indicators'),
          SizedBox(height: ZoniUI.spacing.sm),
          Row(
            children: <Widget>[
              const ZoniLoadingIndicator(
                size: ZoniLoadingSize.small,
              ),
              SizedBox(width: ZoniUI.spacing.md),
              const ZoniLoadingIndicator(),
              SizedBox(width: ZoniUI.spacing.md),
              const ZoniLoadingIndicator(
                size: ZoniLoadingSize.large,
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const Text('Linear Indicator'),
          SizedBox(height: ZoniUI.spacing.sm),
          const ZoniLoadingIndicator(
            style: ZoniLoadingStyle.linear,
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const Text('Dots Indicator'),
          SizedBox(height: ZoniUI.spacing.sm),
          const ZoniLoadingIndicator(
            style: ZoniLoadingStyle.dots,
          ),
        ],
      );

  Widget _buildTypographyExamples() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Display Large', style: ZoniUI.textStyles.displayLarge),
          Text('Display Medium', style: ZoniUI.textStyles.displayMedium),
          Text('Display Small', style: ZoniUI.textStyles.displaySmall),
          SizedBox(height: ZoniUI.spacing.sm),
          Text('Headline Large', style: ZoniUI.textStyles.headlineLarge),
          Text('Headline Medium', style: ZoniUI.textStyles.headlineMedium),
          Text('Headline Small', style: ZoniUI.textStyles.headlineSmall),
          SizedBox(height: ZoniUI.spacing.sm),
          Text('Title Large', style: ZoniUI.textStyles.titleLarge),
          Text('Title Medium', style: ZoniUI.textStyles.titleMedium),
          Text('Title Small', style: ZoniUI.textStyles.titleSmall),
          SizedBox(height: ZoniUI.spacing.sm),
          Text('Body Large', style: ZoniUI.textStyles.bodyLarge),
          Text('Body Medium', style: ZoniUI.textStyles.bodyMedium),
          Text('Body Small', style: ZoniUI.textStyles.bodySmall),
          SizedBox(height: ZoniUI.spacing.sm),
          Text('Label Large', style: ZoniUI.textStyles.labelLarge),
          Text('Label Medium', style: ZoniUI.textStyles.labelMedium),
          Text('Label Small', style: ZoniUI.textStyles.labelSmall),
        ],
      );

  Widget _buildColorExamples() => Wrap(
        spacing: ZoniUI.spacing.sm,
        runSpacing: ZoniUI.spacing.sm,
        children: <Widget>[
          _buildColorSwatch('Primary', ZoniUI.colors.primary),
          _buildColorSwatch('Secondary', ZoniUI.colors.secondary),
          _buildColorSwatch('Success', ZoniUI.colors.success),
          _buildColorSwatch('Warning', ZoniUI.colors.warning),
          _buildColorSwatch('Error', ZoniUI.colors.error),
          _buildColorSwatch('Info', ZoniUI.colors.info),
        ],
      );

  Widget _buildColorSwatch(String name, Color color) => Column(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(ZoniUI.borderRadius.md),
            ),
          ),
          SizedBox(height: ZoniUI.spacing.xs),
          Text(
            name,
            style: ZoniUI.textStyles.labelSmall,
          ),
        ],
      );

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
