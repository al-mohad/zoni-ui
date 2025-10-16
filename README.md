# Zoni UI

A comprehensive Flutter design system providing themes, components, and utilities for building consistent Zoni applications.

[![pub package](https://img.shields.io/pub/v/zoni_ui.svg)](https://pub.dev/packages/zoni_ui)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 🎨 **Complete Design System**: Comprehensive color palette, typography scale, and spacing system
- 🧩 **Ready-to-use Components**: Buttons, cards, text fields, loading indicators, and more
- 🌙 **Dark Mode Support**: Built-in light and dark theme variants
- ♿ **Accessibility First**: All components include proper semantic labels and accessibility support
- 📱 **Material Design 3**: Follows the latest Material Design guidelines
- 🧪 **Fully Tested**: Comprehensive unit, widget, and golden tests
- 📚 **Well Documented**: Extensive documentation and examples

## Getting Started

### Installation

Add `zoni_ui` to your `pubspec.yaml`:

```yaml
dependencies:
  zoni_ui: ^0.1.0
```

Then run:

```bash
flutter pub get
```

### Basic Setup

Wrap your app with the Zoni theme:

```dart
import 'package:flutter/material.dart';
import 'package:zoni_ui/zoni_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Zoni App',
      theme: ZoniTheme.light(),
      darkTheme: ZoniTheme.dark(),
      home: MyHomePage(),
    );
  }
}
```

## Usage

### Components

#### Buttons

```dart
// Filled button (default)
ZoniButton(
  onPressed: () => print('Pressed!'),
  child: Text('Filled Button'),
)

// Outlined button
ZoniButton(
  onPressed: () => print('Pressed!'),
  variant: ZoniButtonVariant.outlined,
  child: Text('Outlined Button'),
)

// Button with icon
ZoniButton(
  onPressed: () => print('Pressed!'),
  icon: Icon(Icons.star),
  child: Text('Icon Button'),
)

// Loading button
ZoniButton(
  onPressed: () => print('Pressed!'),
  isLoading: true,
  child: Text('Loading...'),
)
```

#### Cards

```dart
ZoniCard(
  elevation: ZoniCardElevation.medium,
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      Text('Card Title'),
      Text('Card content goes here'),
    ],
  ),
)
```

#### Text Fields

```dart
ZoniTextField(
  label: 'Email',
  hintText: 'Enter your email',
  prefixIcon: Icon(Icons.email),
  onChanged: (value) => print('Input: $value'),
)
```

#### Loading Indicators

```dart
// Circular loading indicator
ZoniLoadingIndicator(
  style: ZoniLoadingStyle.circular,
  size: ZoniLoadingSize.large,
)

// Dots loading indicator
ZoniLoadingIndicator(
  style: ZoniLoadingStyle.dots,
)
```

### Design Tokens

#### Colors

```dart
// Primary colors
ZoniColors.primary
ZoniColors.primaryLight
ZoniColors.primaryDark

// Semantic colors
ZoniColors.success
ZoniColors.warning
ZoniColors.error
ZoniColors.info

// Surface colors
ZoniColors.background
ZoniColors.surface
ZoniColors.surfaceVariant
```

#### Typography

```dart
// Display styles
ZoniTextStyles.displayLarge
ZoniTextStyles.displayMedium
ZoniTextStyles.displaySmall

// Headline styles
ZoniTextStyles.headlineLarge
ZoniTextStyles.headlineMedium
ZoniTextStyles.headlineSmall

// Body styles
ZoniTextStyles.bodyLarge
ZoniTextStyles.bodyMedium
ZoniTextStyles.bodySmall
```

#### Spacing

```dart
// Spacing values (following 8pt grid)
ZoniSpacing.xs    // 4px
ZoniSpacing.sm    // 8px
ZoniSpacing.md    // 16px
ZoniSpacing.lg    // 24px
ZoniSpacing.xl    // 32px
```

#### Border Radius

```dart
ZoniBorderRadius.sm    // 4px
ZoniBorderRadius.md    // 8px
ZoniBorderRadius.lg    // 12px
ZoniBorderRadius.xl    // 16px
```

## Examples

Check out the `/example` folder for complete examples showing how to use Zoni UI components in real applications.

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
# zoni-ui
