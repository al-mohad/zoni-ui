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
  bool _checkboxValue = false;
  bool _switchValue = false;
  String _radioValue = 'option1';
  double _sliderValue = 0.5;
  RangeValues _rangeValues = const RangeValues(0.2, 0.8);
  String? _dropdownValue;
  final int _currentTabIndex = 0;
  int _currentPage = 1;
  final int _totalPages = 10;
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
          drawer: ZoniDrawer(
            header: const ZoniDrawerHeader(
              title: 'ZoniUI Demo',
              subtitle: 'Component Showcase',
              avatar: CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/40/40'),
              ),
            ),
            items: [
              ZoniDrawerItem(
                icon: Icons.home,
                title: 'Home',
                onTap: () => Navigator.pop(context),
              ),
              ZoniDrawerItem(
                icon: Icons.widgets,
                title: 'Components',
                badge: '50+',
                children: [
                  ZoniDrawerItem(
                    icon: Icons.smart_button,
                    title: 'Buttons',
                    onTap: () => Navigator.pop(context),
                  ),
                  ZoniDrawerItem(
                    icon: Icons.credit_card,
                    title: 'Cards',
                    onTap: () => Navigator.pop(context),
                  ),
                  ZoniDrawerItem(
                    icon: Icons.text_fields,
                    title: 'Forms',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              ZoniDrawerItem(
                icon: Icons.palette,
                title: 'Theme',
                onTap: () => Navigator.pop(context),
              ),
              ZoniDrawerItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () => Navigator.pop(context),
              ),
              ZoniDrawerItem(
                icon: Icons.help,
                title: 'Help & Support',
                badge: 'New',
                onTap: () => Navigator.pop(context),
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
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'New Components',
                  _buildNewComponentsExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'All Input Components',
                  _buildAllInputComponentsExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Additional Components',
                  _buildAdditionalComponentsExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Latest Components',
                  _buildLatestComponentsExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Design System Components',
                  _buildDesignSystemExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Advanced Components',
                  _buildAdvancedComponentsExamples(),
                ),
                SizedBox(height: ZoniUI.spacing.xl),
                _buildSection(
                  'Content & Media Components',
                  _buildContentMediaExamples(),
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
          // Text Fields
          Text('Text Fields', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
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
          SizedBox(height: ZoniUI.spacing.lg),

          // Search Field
          Text('Search Field', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniSearchField(
            hintText: 'Search for items...',
            onChanged: (value) => debugPrint('Search: $value'),
            onSubmitted: (value) => debugPrint('Search submitted: $value'),
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Date and Time Pickers
          Text('Date & Time Pickers', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniDatePicker(
            label: 'Select Date',
            onDateSelected: (date) => debugPrint('Date selected: $date'),
          ),
          SizedBox(height: ZoniUI.spacing.md),
          ZoniTimePicker(
            label: 'Select Time',
            onTimeSelected: (time) => debugPrint('Time selected: $time'),
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // File Upload
          Text('File Upload', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniFileUpload(
            title: 'Upload Files',
            subtitle: 'Select files to upload',
            onFilesSelected: (files) =>
                debugPrint('Files selected: ${files.length}'),
            maxFiles: 5,
            acceptedFileTypes: const ['jpg', 'png', 'pdf', 'doc'],
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

  Widget _buildNewComponentsExamples() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('ZoniText Components'),
          SizedBox(height: ZoniUI.spacing.sm),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ZoniText.displayLarge('Display Large'),
              ZoniText.headlineMedium('Headline Medium'),
              ZoniText.titleLarge('Title Large'),
              ZoniText.bodyMedium('Body Medium'),
              ZoniText.labelSmall('Label Small'),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const Text('ZoniContainer Components'),
          SizedBox(height: ZoniUI.spacing.sm),
          Row(
            children: <Widget>[
              const Expanded(
                child: ZoniContainer.card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Card Container'),
                  ),
                ),
              ),
              SizedBox(width: ZoniUI.spacing.md),
              const Expanded(
                child: ZoniContainer.surface(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Surface Container'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const Text('Feedback Components'),
          SizedBox(height: ZoniUI.spacing.sm),
          Wrap(
            spacing: ZoniUI.spacing.sm,
            runSpacing: ZoniUI.spacing.sm,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _showZoniSnackBar('success'),
                child: const Text('Success SnackBar'),
              ),
              ElevatedButton(
                onPressed: () => _showZoniSnackBar('error'),
                child: const Text('Error SnackBar'),
              ),
              ElevatedButton(
                onPressed: () => _showZoniSnackBar('warning'),
                child: const Text('Warning SnackBar'),
              ),
              ElevatedButton(
                onPressed: () => _showZoniSnackBar('info'),
                child: const Text('Info SnackBar'),
              ),
              ElevatedButton(
                onPressed: () => _showZoniDialog(),
                child: const Text('Confirmation Dialog'),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.md),
          const Text('Form Components'),
          SizedBox(height: ZoniUI.spacing.sm),
          _buildFormComponentsExample(),
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

  void _showZoniSnackBar(String type) {
    late ZoniSnackBar snackBar;
    switch (type) {
      case 'success':
        snackBar =
            ZoniSnackBar.success(message: 'Success! Operation completed.');
        break;
      case 'error':
        snackBar = ZoniSnackBar.error(message: 'Error! Something went wrong.');
        break;
      case 'warning':
        snackBar =
            ZoniSnackBar.warning(message: 'Warning! Please check your input.');
        break;
      case 'info':
        snackBar = ZoniSnackBar.info(
            message: 'Info: This is an informational message.');
        break;
      default:
        snackBar = ZoniSnackBar.info(message: 'Default message');
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showZoniDialog() {
    ZoniDialogHelper.showConfirmation(
      context,
      title: 'Confirm Action',
      message: 'Are you sure you want to proceed with this action?',
      isDangerous: true,
    ).then((confirmed) {
      if (confirmed == true) {
        _showZoniSnackBar('success');
      }
    });
  }

  Widget _buildFormComponentsExample() => Column(
        children: <Widget>[
          CheckboxListTile(
            value: _checkboxValue,
            onChanged: (value) =>
                setState(() => _checkboxValue = value ?? false),
            title: const Text('Checkbox option'),
          ),
          SizedBox(height: ZoniUI.spacing.sm),
          Row(
            children: <Widget>[
              const Text('Switch: '),
              ZoniSwitch(
                value: _switchValue,
                onChanged: (value) => setState(() => _switchValue = value),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Radio buttons:'),
              Row(
                children: <Widget>[
                  ZoniRadio<String>(
                    value: 'option1',
                    groupValue: _radioValue,
                    onChanged: (value) =>
                        setState(() => _radioValue = value ?? 'option1'),
                  ),
                  const Text('Option 1'),
                  SizedBox(width: ZoniUI.spacing.md),
                  ZoniRadio<String>(
                    value: 'option2',
                    groupValue: _radioValue,
                    onChanged: (value) =>
                        setState(() => _radioValue = value ?? 'option1'),
                  ),
                  const Text('Option 2'),
                ],
              ),
            ],
          ),
        ],
      );

  Widget _buildAllInputComponentsExamples() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Multi-Select
          Text('Multi-Select', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniMultiSelect<String>(
            options: [
              ZoniMultiSelectOption(value: 'flutter', label: 'Flutter'),
              ZoniMultiSelectOption(value: 'dart', label: 'Dart'),
              ZoniMultiSelectOption(value: 'ui', label: 'UI/UX'),
              ZoniMultiSelectOption(value: 'design', label: 'Design'),
            ],
            selectedValues: const ['flutter'],
            onChanged: (values) => debugPrint('Selected: $values'),
            title: 'Select Technologies',
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Toggle Group
          Text('Toggle Group', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniToggleGroup<String>(
            options: [
              ZoniToggleOption(
                value: 'left',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.format_align_left, size: 16),
                    SizedBox(width: 4),
                    Text('Left'),
                  ],
                ),
              ),
              ZoniToggleOption(
                value: 'center',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.format_align_center, size: 16),
                    SizedBox(width: 4),
                    Text('Center'),
                  ],
                ),
              ),
              ZoniToggleOption(
                value: 'right',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.format_align_right, size: 16),
                    SizedBox(width: 4),
                    Text('Right'),
                  ],
                ),
              ),
            ],
            selectedValues: const ['left'],
            onChanged: (values) => debugPrint('Toggle selected: $values'),
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Checkbox Examples
          Text('Checkboxes', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            children: [
              Row(
                children: [
                  ZoniCheckbox(
                    value: _checkboxValue,
                    onChanged: (value) =>
                        setState(() => _checkboxValue = value ?? false),
                  ),
                  SizedBox(width: ZoniUI.spacing.sm),
                  Text('Accept terms and conditions'),
                ],
              ),
              SizedBox(height: ZoniUI.spacing.sm),
              Row(
                children: [
                  ZoniCheckbox(
                    value: !_checkboxValue,
                    onChanged: (value) =>
                        setState(() => _checkboxValue = !(value ?? true)),
                    variant: ZoniCheckboxVariant.success,
                  ),
                  SizedBox(width: ZoniUI.spacing.sm),
                  Text('Subscribe to newsletter'),
                ],
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Form Example
          Text('Form Components', style: ZoniUI.textStyles.titleMedium),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniForm(
            child: Column(
              children: [
                ZoniTextField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  validator: (value) =>
                      value?.isEmpty == true ? 'Name is required' : null,
                ),
                SizedBox(height: ZoniUI.spacing.md),
                ZoniTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value?.contains('@') != true ? 'Invalid email' : null,
                ),
                SizedBox(height: ZoniUI.spacing.md),
                ZoniButton(
                  onPressed: () => debugPrint('Form submitted'),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildAdditionalComponentsExamples() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Badges and Chips
          const Text('Badges & Chips'),
          SizedBox(height: ZoniUI.spacing.sm),
          Wrap(
            spacing: ZoniUI.spacing.sm,
            runSpacing: ZoniUI.spacing.sm,
            children: [
              const ZoniBadge(label: 'Primary'),
              const ZoniBadge(
                  label: 'Success', variant: ZoniBadgeVariant.success),
              const ZoniBadge(
                  label: 'Warning', variant: ZoniBadgeVariant.warning),
              const ZoniBadge(label: 'Error', variant: ZoniBadgeVariant.error),
              ZoniChip(
                label: const Text('Filter Chip'),
                variant: ZoniChipVariant.filter,
                selected: true,
                onSelected: (selected) {},
              ),
              ZoniChip.action(
                label: const Text('Action Chip'),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Progress Indicators
          const Text('Progress Indicators'),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            children: [
              const ZoniProgress.linear(
                  value: 0.7, showLabel: true, label: 'Loading'),
              SizedBox(height: ZoniUI.spacing.md),
              Row(
                children: [
                  const ZoniProgress.circular(value: 0.5),
                  SizedBox(width: ZoniUI.spacing.md),
                  const ZoniProgress.ring(value: 0.8, showLabel: true),
                ],
              ),
              SizedBox(height: ZoniUI.spacing.md),
              const ZoniStepProgress(
                steps: ['Step 1', 'Step 2', 'Step 3', 'Step 4'],
                currentStep: 1,
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Sliders
          const Text('Sliders'),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            children: [
              ZoniSlider(
                value: _sliderValue,
                onChanged: (value) => setState(() => _sliderValue = value),
                showLabel: true,
                showValue: true,
                label: 'Volume',
              ),
              SizedBox(height: ZoniUI.spacing.md),
              ZoniSlider.range(
                rangeValues: _rangeValues,
                onRangeChanged: (values) =>
                    setState(() => _rangeValues = values),
                showValue: true,
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Dropdown
          const Text('Dropdown'),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniDropdown<String>.outlined(
            value: _dropdownValue,
            hint: const Text('Select an option'),
            items: const [
              DropdownMenuItem(value: 'option1', child: Text('Option 1')),
              DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              DropdownMenuItem(value: 'option3', child: Text('Option 3')),
            ],
            onChanged: (value) => setState(() => _dropdownValue = value),
            label: 'Choose Option',
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Avatars
          const Text('Avatars'),
          SizedBox(height: ZoniUI.spacing.sm),
          Row(
            children: [
              const ZoniAvatar.small(initials: 'AB'),
              SizedBox(width: ZoniUI.spacing.sm),
              const ZoniAvatar(name: 'John Doe'),
              SizedBox(width: ZoniUI.spacing.sm),
              const ZoniAvatar.large(initials: 'XY', showBorder: true),
              SizedBox(width: ZoniUI.spacing.sm),
              const ZoniAvatarGroup(
                avatars: [
                  ZoniAvatar(initials: 'A'),
                  ZoniAvatar(initials: 'B'),
                  ZoniAvatar(initials: 'C'),
                  ZoniAvatar(initials: 'D'),
                  ZoniAvatar(initials: 'E'),
                ],
                maxVisible: 3,
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Tooltips
          const Text('Tooltips'),
          SizedBox(height: ZoniUI.spacing.sm),
          Row(
            children: [
              ZoniTooltip(
                message: 'This is a primary tooltip',
                child: ZoniButton(
                  onPressed: () {},
                  child: const Text('Hover me'),
                ),
              ),
              SizedBox(width: ZoniUI.spacing.sm),
              ZoniTooltip.success(
                message: 'Success tooltip',
                child: ZoniButton(
                  onPressed: () {},
                  variant: ZoniButtonVariant.success,
                  child: const Text('Success'),
                ),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Breadcrumbs
          const Text('Breadcrumbs'),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniBreadcrumb(
            items: [
              ZoniBreadcrumbItem(label: 'Home', onTap: () {}),
              ZoniBreadcrumbItem(label: 'Products', onTap: () {}),
              ZoniBreadcrumbItem(label: 'Electronics', onTap: () {}),
              const ZoniBreadcrumbItem(label: 'Smartphones', isActive: true),
            ],
            showHomeIcon: true,
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Pagination
          const Text('Pagination'),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniPagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
          SizedBox(height: ZoniUI.spacing.md),
          ZoniPagination.simple(
            currentPage: _currentPage,
            totalPages: _totalPages,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Tabs
          const Text('Tabs'),
          SizedBox(height: ZoniUI.spacing.sm),
          const SizedBox(
            height: 200,
            child: ZoniTabs(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
              children: [
                Center(child: Text('Content for Tab 1')),
                Center(child: Text('Content for Tab 2')),
                Center(child: Text('Content for Tab 3')),
              ],
            ),
          ),
        ],
      );

  Widget _buildLatestComponentsExamples() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Radio buttons
          const Text('Radio Buttons'),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            children: [
              ZoniRadio<String>(
                value: 'option1',
                groupValue: _radioValue,
                onChanged: (value) => setState(() => _radioValue = value!),
                title: const Text('Option 1'),
              ),
              ZoniRadio<String>(
                value: 'option2',
                groupValue: _radioValue,
                onChanged: (value) => setState(() => _radioValue = value!),
                title: const Text('Option 2'),
                variant: ZoniRadioVariant.success,
              ),
            ],
          ),

          SizedBox(height: ZoniUI.spacing.lg),

          // Switches
          const Text('Switches'),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            children: [
              ZoniSwitch(
                value: _switchValue,
                onChanged: (value) => setState(() => _switchValue = value),
                title: const Text('Enable notifications'),
              ),
              ZoniSwitch(
                value: !_switchValue,
                onChanged: (value) => setState(() => _switchValue = !value),
                title: const Text('Dark mode'),
                variant: ZoniSwitchVariant.warning,
                size: ZoniSwitchSize.large,
              ),
            ],
          ),

          SizedBox(height: ZoniUI.spacing.lg),

          // Alerts
          const Text('Alerts'),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            children: [
              ZoniAlert.success(
                title: 'Success!',
                message: 'Your action was completed successfully.',
                isDismissible: true,
                onDismiss: () => ZoniUI.logInfo('Alert dismissed'),
              ),
              SizedBox(height: ZoniUI.spacing.sm),
              const ZoniAlert.warning(
                title: 'Warning',
                message: 'Please review your input before proceeding.',
              ),
              SizedBox(height: ZoniUI.spacing.sm),
              ZoniAlert.error(
                title: 'Error',
                message: 'Something went wrong. Please try again.',
                actions: [
                  ZoniButton(
                    onPressed: () => ZoniUI.logInfo('Retry pressed'),
                    variant: ZoniButtonVariant.outlined,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: ZoniUI.spacing.lg),

          // Dividers
          const Text('Dividers'),
          SizedBox(height: ZoniUI.spacing.sm),
          Column(
            children: [
              const ZoniDivider(),
              SizedBox(height: ZoniUI.spacing.sm),
              const ZoniDivider(
                variant: ZoniDividerVariant.dashed,
                thicknessLevel: ZoniDividerThickness.medium,
              ),
              SizedBox(height: ZoniUI.spacing.sm),
              const ZoniDividerWithContent(
                child: Text(
                  'OR',
                  style: TextStyle(color: ZoniColors.neutralGray),
                ),
              ),
            ],
          ),

          SizedBox(height: ZoniUI.spacing.lg),

          // Grid Layout
          const Text('Grid Layout'),
          SizedBox(height: ZoniUI.spacing.sm),
          ZoniGrid(
            columns: 3,
            children: [
              ZoniGridItem(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: ZoniColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('Item 1')),
                ),
              ),
              ZoniGridItem(
                span: 2,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: ZoniColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('Item 2 (span 2)')),
                ),
              ),
              ZoniGridItem(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: ZoniColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('Item 3')),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildDesignSystemExamples() => Column(
        children: <Widget>[
          // Color Palette Examples
          const ZoniColorPalette.primary(),
          SizedBox(height: ZoniUI.spacing.lg),
          const ZoniColorPalette.semantic(),
          SizedBox(height: ZoniUI.spacing.lg),

          // Code Block Examples
          const ZoniCodeBlock(
            code: '''
import 'package:flutter/material.dart';
import 'package:zoni_ui/zoni_ui.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoniButton(
      onPressed: () => print('Hello Zoni!'),
      child: Text('Click me'),
    );
  }
}''',
            language: 'dart',
            title: 'Flutter Example',
            showLineNumbers: true,
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Status Indicator Examples
          Wrap(
            spacing: ZoniUI.spacing.md,
            runSpacing: ZoniUI.spacing.sm,
            children: const [
              ZoniStatusIndicator.success(),
              ZoniStatusIndicator.warning(),
              ZoniStatusIndicator.error(),
              ZoniStatusIndicator.info(),
              ZoniStatusIndicator.processing(),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Info Card Examples
          const ZoniInfoCard.success(
            title: 'Success',
            description: 'Your action was completed successfully.',
          ),
          SizedBox(height: ZoniUI.spacing.sm),
          const ZoniInfoCard.warning(
            title: 'Warning',
            description: 'Please review your settings before proceeding.',
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Feature Card Examples
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: ZoniUI.spacing.md,
            mainAxisSpacing: ZoniUI.spacing.md,
            children: const [
              ZoniFeatureCard(
                title: 'Fast Performance',
                description: 'Optimized for speed and efficiency.',
                icon: Icons.speed,
              ),
              ZoniFeatureCard(
                title: 'Easy to Use',
                description: 'Intuitive design for better user experience.',
                icon: Icons.touch_app,
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Metric Card Examples
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: ZoniUI.spacing.md,
            mainAxisSpacing: ZoniUI.spacing.md,
            children: const [
              ZoniMetricCard(
                title: 'Total Users',
                value: '12,345',
                trend: ZoniMetricTrend.up,
                trendValue: '+12%',
                icon: Icons.people,
              ),
              ZoniMetricCard(
                title: 'Revenue',
                value: '\$45,678',
                trend: ZoniMetricTrend.up,
                trendValue: '+8%',
                icon: Icons.attach_money,
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // Empty State Examples
          const ZoniEmptyState.noData(),
          SizedBox(height: ZoniUI.spacing.lg),

          // Skeleton Examples
          const ZoniSkeletonCard(),
        ],
      );

  Widget _buildAdvancedComponentsExamples() {
    return Column(
      children: [
        // ZoniChart example
        SizedBox(
          height: 300,
          child: ZoniChart(
            type: ZoniChartType.line,
            title: 'Sales Over Time',
            series: [
              ZoniChartSeries(
                name: 'Sales',
                data: [
                  ZoniChartDataPoint(x: 1, y: 10),
                  ZoniChartDataPoint(x: 2, y: 20),
                  ZoniChartDataPoint(x: 3, y: 15),
                  ZoniChartDataPoint(x: 4, y: 25),
                  ZoniChartDataPoint(x: 5, y: 30),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniMultiSelect example
        ZoniMultiSelect<String>(
          options: [
            ZoniMultiSelectOption(value: 'option1', label: 'Option 1'),
            ZoniMultiSelectOption(value: 'option2', label: 'Option 2'),
            ZoniMultiSelectOption(value: 'option3', label: 'Option 3'),
          ],
          selectedValues: [],
          onChanged: (values) {},
          title: 'Select Options',
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniCalendar example
        SizedBox(
          height: 400,
          child: ZoniCalendar(
            events: [
              ZoniCalendarEvent(
                id: '1',
                title: 'Meeting',
                startTime: DateTime.now(),
                endTime: DateTime.now().add(Duration(hours: 1)),
              ),
            ],
          ),
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniStatsCard example
        Row(
          children: [
            Expanded(
              child: ZoniStatsCard(
                title: 'Total Sales',
                value: '\$12,345',
                icon: Icons.trending_up,
                trend: ZoniStatsTrend.up,
                trendValue: '+12.5%',
                color: ZoniColors.success,
              ),
            ),
            SizedBox(width: ZoniUI.spacing.sm),
            Expanded(
              child: ZoniStatsCard(
                title: 'Active Users',
                value: '1,234',
                icon: Icons.people,
                trend: ZoniStatsTrend.down,
                trendValue: '-2.1%',
                color: ZoniColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniUserProfile example
        ZoniUserProfile(
          profile: ZoniUserProfileData(
            name: 'John Doe',
            email: 'john.doe@example.com',
            role: 'Senior Developer',
            department: 'Engineering',
            status: ZoniUserStatus.online,
            badges: [
              ZoniUserBadge(label: 'Top Performer', icon: Icons.star),
              ZoniUserBadge(label: 'Team Lead', icon: Icons.group),
            ],
            stats: {
              'Projects': '12',
              'Commits': '1,234',
              'Reviews': '89',
            },
          ),
          variant: ZoniUserProfileVariant.card,
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniPricingCard example
        SizedBox(
          height: 400,
          child: Row(
            children: [
              Expanded(
                child: ZoniPricingCard(
                  plan: ZoniPricingPlan(
                    name: 'Basic',
                    price: '9',
                    description: 'Perfect for individuals',
                    features: [
                      '5 Projects',
                      '10GB Storage',
                      'Email Support',
                    ],
                  ),
                ),
              ),
              SizedBox(width: ZoniUI.spacing.sm),
              Expanded(
                child: ZoniPricingCard(
                  plan: ZoniPricingPlan(
                    name: 'Pro',
                    price: '29',
                    description: 'Best for teams',
                    features: [
                      'Unlimited Projects',
                      '100GB Storage',
                      'Priority Support',
                      'Advanced Analytics',
                    ],
                    isPopular: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniTestimonial example
        ZoniTestimonial(
          testimonial: ZoniTestimonialData(
            content:
                'This product has completely transformed our workflow. Highly recommended!',
            author: 'Jane Smith',
            authorTitle: 'Product Manager',
            authorCompany: 'Tech Corp',
            rating: 5,
            date: DateTime.now().subtract(Duration(days: 30)),
          ),
          variant: ZoniTestimonialVariant.card,
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniFeatureShowcase example
        ZoniFeatureShowcase(
          features: [
            ZoniFeature(
              title: 'Fast Performance',
              description: 'Lightning-fast performance with optimized code',
              icon: Icons.speed,
              color: ZoniColors.success,
            ),
            ZoniFeature(
              title: 'Secure',
              description: 'Enterprise-grade security for your data',
              icon: Icons.security,
              color: ZoniColors.primary,
            ),
            ZoniFeature(
              title: 'Scalable',
              description: 'Scales with your business needs',
              icon: Icons.trending_up,
              color: ZoniColors.warning,
            ),
            ZoniFeature(
              title: 'Easy to Use',
              description: 'Intuitive interface that anyone can use',
              icon: Icons.touch_app,
              color: ZoniColors.info,
            ),
          ],
          variant: ZoniFeatureShowcaseVariant.grid,
          crossAxisCount: 2,
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniActivityFeed example
        SizedBox(
          height: 300,
          child: ZoniActivityFeed(
            items: [
              ZoniActivityItem(
                id: '1',
                title: 'John commented on your post',
                description: 'Great work on the new feature!',
                timestamp: DateTime.now().subtract(Duration(minutes: 5)),
                icon: Icons.comment,
                color: ZoniColors.primary,
                avatar: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage('https://picsum.photos/32/32'),
                ),
              ),
              ZoniActivityItem(
                id: '2',
                title: 'Sarah liked your post',
                description: 'Flutter UI Components Tutorial',
                timestamp: DateTime.now().subtract(Duration(hours: 2)),
                icon: Icons.favorite,
                color: ZoniColors.error,
                avatar: CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      NetworkImage('https://picsum.photos/32/32?random=2'),
                ),
              ),
              ZoniActivityItem(
                id: '3',
                title: 'Mike shared your article',
                description: 'Building Better UIs with Flutter',
                timestamp: DateTime.now().subtract(Duration(days: 1)),
                icon: Icons.share,
                color: ZoniColors.success,
                avatar: CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      NetworkImage('https://picsum.photos/32/32?random=3'),
                ),
              ),
            ],
            onItemTap: (item) => print('Activity tapped: ${item.title}'),
          ),
        ),
        SizedBox(height: ZoniUI.spacing.md),

        // ZoniNotificationPanel example
        SizedBox(
          height: 250,
          child: ZoniNotificationPanel(
            notifications: [
              ZoniNotificationItem(
                id: '1',
                title: 'New Message',
                message: 'You have received a new message from John',
                type: ZoniNotificationType.info,
                timestamp: DateTime.now().subtract(Duration(minutes: 10)),
                isRead: false,
              ),
              ZoniNotificationItem(
                id: '2',
                title: 'System Update',
                message: 'System will be updated tonight at 2 AM',
                type: ZoniNotificationType.warning,
                timestamp: DateTime.now().subtract(Duration(hours: 1)),
                isRead: true,
              ),
              ZoniNotificationItem(
                id: '3',
                title: 'Payment Successful',
                message: 'Your payment of \$29.99 has been processed',
                type: ZoniNotificationType.success,
                timestamp: DateTime.now().subtract(Duration(days: 1)),
                isRead: true,
              ),
            ],
            onNotificationTap: (notification) =>
                print('Notification tapped: ${notification.title}'),
            onMarkAllAsRead: () => print('Mark all as read'),
          ),
        ),
      ],
    );
  }

  Widget _buildContentMediaExamples() => Column(
        children: <Widget>[
          // ZoniHeader Examples
          const ZoniHeader(
            title: 'Welcome to ZoniUI',
            subtitle: 'A comprehensive Flutter design system',
            description:
                'Build beautiful and consistent applications with our component library.',
            showDivider: true,
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // ZoniHeroHeader Example
          ZoniHeroHeader(
            title: 'Get Started Today',
            subtitle: 'Join thousands of developers',
            description: 'Build amazing apps with our design system',
            height: 200,
            actions: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Get Started'),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // ZoniMedia Examples
          Row(
            children: [
              Expanded(
                child: ZoniMedia(
                  src: 'https://picsum.photos/300/200',
                  type: ZoniMediaType.image,
                  height: 150,
                  onTap: () => print('Image tapped'),
                ),
              ),
              SizedBox(width: ZoniUI.spacing.sm),
              Expanded(
                child: ZoniMedia(
                  src: 'sample_video.mp4',
                  type: ZoniMediaType.video,
                  height: 150,
                  showControls: true,
                ),
              ),
            ],
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // ZoniArticleCard Example
          ZoniArticleCard(
            title: 'Getting Started with ZoniUI',
            excerpt:
                'Learn how to integrate ZoniUI into your Flutter project and start building beautiful applications.',
            author: const ZoniAuthor(
              name: 'John Doe',
              avatar: 'https://picsum.photos/40/40',
            ),
            publishDate: DateTime.now().subtract(const Duration(days: 2)),
            readTime: '5 min read',
            featuredImage: 'https://picsum.photos/400/200',
            tags: const ['Flutter', 'UI', 'Design'],
            onTap: () => print('Article tapped'),
            onTagTap: (tag) => print('Tag tapped: $tag'),
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // ZoniRangeSlider Example
          ZoniRangeSlider(
            values: const RangeValues(20, 80),
            onChanged: (values) => print('Range changed: $values'),
            min: 0,
            max: 100,
            divisions: 10,
            prefix: '\$',
            labels: const RangeLabels('20', '80'),
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // ZoniFilterBar Example
          ZoniFilterBar(
            title: 'Filter Options',
            filters: [
              const ZoniFilterOption(
                id: 'all',
                label: 'All',
                count: 150,
                isSelected: true,
              ),
              const ZoniFilterOption(
                id: 'flutter',
                label: 'Flutter',
                icon: Icons.flutter_dash,
                count: 45,
              ),
              const ZoniFilterOption(
                id: 'design',
                label: 'Design',
                icon: Icons.design_services,
                count: 32,
              ),
              const ZoniFilterOption(
                id: 'ui',
                label: 'UI/UX',
                icon: Icons.palette,
                count: 28,
              ),
            ],
            onFilterChanged: (filter) =>
                print('Filter changed: ${filter.label}'),
          ),
          SizedBox(height: ZoniUI.spacing.lg),

          // ZoniArticle Example
          ZoniArticle(
            title: 'Building Beautiful Flutter UIs with ZoniUI',
            content: '''
ZoniUI is a comprehensive Flutter design system that provides developers with a complete set of UI components for building modern, beautiful applications.

## Key Features

- **Consistent Design**: All components follow Material Design 3 principles
- **Easy Integration**: Simple to integrate into existing Flutter projects
- **Customizable**: Extensive theming and customization options
- **Well Documented**: Comprehensive documentation and examples

## Getting Started

To get started with ZoniUI, add it to your pubspec.yaml:

```yaml
dependencies:
  zoni_ui: ^0.2.0
```

Then import it in your Dart files:

```dart
import 'package:zoni_ui/zoni_ui.dart';
```

## Components

ZoniUI includes over 50+ components including buttons, forms, navigation, data display, and more.

Start building amazing Flutter apps today with ZoniUI!
            ''',
            author: const ZoniAuthor(
              name: 'ZoniUI Team',
              bio: 'The team behind the ZoniUI design system',
              avatar: 'https://picsum.photos/60/60',
            ),
            publishDate: DateTime.now().subtract(const Duration(days: 1)),
            readTime: '8 min read',
            featuredImage: 'https://picsum.photos/800/400',
            tags: const ['Flutter', 'UI', 'Design System', 'Components'],
            onTagTap: (tag) => print('Tag tapped: $tag'),
          ),
        ],
      );

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
