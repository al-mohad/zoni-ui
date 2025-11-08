# ZoniUI Example App

This example app demonstrates all the components available in the ZoniUI design system. It showcases buttons, input fields, cards, loading indicators, typography, colors, and many other components with interactive examples.

## Features Demonstrated

### Core Components
- **Buttons**: All variants (filled, outlined, text, filled tonal) with different sizes and states
- **Cards**: Different elevation levels and interactive cards
- **Text Fields**: Basic inputs, email, password, with helpers and error states
- **Loading Indicators**: Circular, linear, and dots styles

### Input Components
- **Text Fields**: Enhanced with decoration support, haptic feedback, and animations
- **Search Field**: Dedicated search input with proper styling
- **Date & Time Pickers**: Calendar and time selection components
- **File Upload**: Drag-and-drop file upload with progress tracking
- **Multi-Select**: Multiple option selection component
- **Toggle Group**: Button group for single/multiple selection
- **Checkboxes**: Various checkbox variants and sizes
- **Form Components**: Complete form wrapper with validation

### Advanced Components
- **Charts**: Line, bar, and pie charts with data visualization
- **Calendar**: Event calendar with scheduling capabilities
- **User Profiles**: Profile cards and user information display
- **Pricing Cards**: Subscription and pricing plan displays
- **Testimonials**: Customer testimonial components
- **Activity Feeds**: Timeline and activity tracking
- **Notification Panels**: In-app notification management

### Design System Elements
- **Typography**: All text styles from display to label sizes
- **Colors**: Primary, secondary, and semantic color palettes
- **Spacing**: Consistent spacing system
- **Badges & Chips**: Status indicators and filter chips
- **Progress Indicators**: Linear, circular, ring, and step progress
- **Sliders**: Single and range sliders with customization
- **Avatars**: Individual and group avatar displays
- **Tooltips**: Contextual help and information tooltips
- **Breadcrumbs**: Navigation breadcrumb trails
- **Pagination**: Page navigation components
- **Tabs**: Tabbed content organization
- **Alerts**: Success, warning, error, and info alerts
- **Dividers**: Content separation elements
- **Grid Layout**: Responsive grid system

## Running the Example

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)

### Installation
1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the example app:
   ```bash
   flutter run
   ```

### Available Demo Apps

#### 1. Main Example App
The comprehensive demo showing all components:
```bash
flutter run lib/main.dart
```

#### 2. Standalone Button Demo
Focused demo for button components with interactive controls:
```bash
flutter run lib/standalone_button_demo.dart
```

#### 3. Standalone Input Demo
Focused demo for input field components:
```bash
flutter run lib/standalone_input_demo.dart
```

## Project Structure

```
example/
├── lib/
│   ├── main.dart                    # Main comprehensive demo
│   ├── button_demo.dart            # Button component demos
│   ├── input_demo.dart             # Input component demos
│   ├── standalone_button_demo.dart # Standalone button app
│   ├── standalone_input_demo.dart  # Standalone input app
│   └── logger_demo.dart            # Logger functionality demo
├── pubspec.yaml                    # Dependencies
└── README.md                       # This file
```

## Key Features

### Interactive Examples
- Toggle between light and dark themes
- Real-time component state changes
- Interactive controls for testing different configurations
- Form validation examples
- Loading state demonstrations

### Navigation
- Drawer navigation with hierarchical menu structure
- Theme switching capability
- Component categorization for easy browsing

### Responsive Design
- Works on different screen sizes
- Adaptive layouts for mobile and tablet
- Proper spacing and typography scaling

## Development

### Adding New Examples
1. Create component examples in the appropriate `_build*Examples()` method
2. Add proper state management for interactive components
3. Include error handling and validation examples
4. Test with both light and dark themes

### Testing Components
- Use the interactive controls to test different states
- Verify accessibility features work correctly
- Test form validation and submission
- Check responsive behavior on different screen sizes

## Related

- [Main ZoniUI Documentation](../README.md)
- [Widgetbook Documentation](../widgetbook/README.md)
- [Component API Reference](../lib/README.md)
