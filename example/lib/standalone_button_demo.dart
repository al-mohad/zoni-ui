import 'package:flutter/material.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  runApp(const StandaloneButtonDemoApp());
}

class StandaloneButtonDemoApp extends StatelessWidget {
  const StandaloneButtonDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZoniButton Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StandaloneButtonDemo(),
    );
  }
}

/// Standalone demo page showcasing the enhanced ZoniButton.
class StandaloneButtonDemo extends StatefulWidget {
  const StandaloneButtonDemo({super.key});

  @override
  State<StandaloneButtonDemo> createState() => _StandaloneButtonDemoState();
}

class _StandaloneButtonDemoState extends State<StandaloneButtonDemo> {
  bool _isLoading = false;
  bool _isEnabled = true;
  ZoniButtonLoadingType _loadingType = ZoniButtonLoadingType.circular;
  ZoniHapticType _hapticType = ZoniHapticType.light;

  void _simulateAsyncAction() async {
    setState(() => _isLoading = true);
    
    // Simulate network request or processing
    await Future.delayed(const Duration(seconds: 3));
    
    setState(() => _isLoading = false);
    
    // Show success haptic feedback
    await ZoniHaptics.heavy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZoniButton Demo'),
        backgroundColor: ZoniColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Controls Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Button Controls',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    
                    // Enable/Disable Toggle
                    SwitchListTile(
                      title: const Text('Button Enabled'),
                      value: _isEnabled,
                      onChanged: (value) => setState(() => _isEnabled = value),
                    ),
                    
                    // Loading Type Selector
                    DropdownButtonFormField<ZoniButtonLoadingType>(
                      decoration: const InputDecoration(
                        labelText: 'Loading Animation Type',
                      ),
                      value: _loadingType,
                      items: ZoniButtonLoadingType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _loadingType = value);
                        }
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Haptic Type Selector
                    DropdownButtonFormField<ZoniHapticType>(
                      decoration: const InputDecoration(
                        labelText: 'Haptic Feedback Type',
                      ),
                      value: _hapticType,
                      items: ZoniHapticType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _hapticType = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Demo Buttons Section
            Text(
              'Button Variants',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Primary Button with Loading
            ZoniButton(
              onPressed: _isEnabled ? _simulateAsyncAction : null,
              variant: ZoniButtonVariant.filled,
              size: ZoniButtonSize.large,
              isLoading: _isLoading,
              isEnabled: _isEnabled,
              loadingType: _loadingType,
              loadingText: 'Processing...',
              hapticType: _hapticType,
              enableHapticFeedback: true,
              enablePressAnimation: true,
              semanticLabel: 'Primary action button with loading state',
              tooltip: 'Tap to simulate async action',
              child: Text(_isLoading ? 'Processing...' : 'Primary Action'),
            ),
            
            const SizedBox(height: 16),
            
            // Filled Tonal Button
            ZoniButton(
              onPressed: _isEnabled ? () => ZoniHaptics.medium() : null,
              variant: ZoniButtonVariant.filledTonal,
              size: ZoniButtonSize.medium,
              isEnabled: _isEnabled,
              hapticType: ZoniHapticType.medium,
              enableHapticFeedback: true,
              enablePressAnimation: true,
              onLongPress: () => ZoniHaptics.heavy(),
              child: const Text('Filled Tonal (Long Press Me)'),
            ),
            
            const SizedBox(height: 16),
            
            // Outlined Button
            ZoniButton(
              onPressed: _isEnabled ? () => ZoniHaptics.selection() : null,
              variant: ZoniButtonVariant.outlined,
              size: ZoniButtonSize.small,
              isEnabled: _isEnabled,
              hapticType: ZoniHapticType.selection,
              enableHapticFeedback: true,
              enablePressAnimation: true,
              customPressScale: 0.92,
              customPressOpacity: 0.7,
              child: const Text('Outlined Button'),
            ),
            
            const SizedBox(height: 16),
            
            // Text Button
            ZoniButton.text(
              onPressed: _isEnabled ? () => ZoniHaptics.light() : null,
              isEnabled: _isEnabled,
              hapticType: ZoniHapticType.light,
              enableHapticFeedback: true,
              enablePressAnimation: true,
              animationDuration: const Duration(milliseconds: 150),
              child: const Text('Text Button'),
            ),
            
            const SizedBox(height: 32),
            
            // Loading Types Demo
            Text(
              'Loading Animation Types',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Show all loading types
            ...ZoniButtonLoadingType.values.map((type) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ZoniButton(
                  onPressed: null, // Always disabled for demo
                  variant: ZoniButtonVariant.filled,
                  size: ZoniButtonSize.medium,
                  isLoading: true,
                  loadingType: type,
                  loadingText: type == ZoniButtonLoadingType.spinnerWithText 
                      ? 'Loading...' 
                      : null,
                  child: Text('${type.name} Loading'),
                ),
              );
            }).toList(),
            
            const SizedBox(height: 32),
            
            // Accessibility Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accessibility Features',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• Semantic labels for screen readers\n'
                      '• Keyboard navigation support\n'
                      '• Focus management\n'
                      '• Haptic feedback for interactions\n'
                      '• Loading state announcements\n'
                      '• Tooltip support\n'
                      '• High contrast support',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
