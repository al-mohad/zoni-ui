import 'package:flutter/material.dart';
import 'package:zoni_ui/zoni_ui.dart';

import 'input_demo.dart';

/// Standalone demo app for testing enhanced ZoniTextField.
void main() {
  runApp(const StandaloneInputDemoApp());
}

/// Main app widget for the standalone input demo.
class StandaloneInputDemoApp extends StatelessWidget {
  const StandaloneInputDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZoniTextField Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InputDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}
