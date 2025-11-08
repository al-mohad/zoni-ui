# ZoniUI Widgetbook

This is the Widgetbook for ZoniUI components. Widgetbook is a Flutter package that helps you catalog and test your UI components in isolation, similar to Storybook for web development.

## What is Widgetbook?

Widgetbook allows you to:
- **Catalog Components**: Browse all your UI components in one place
- **Test in Isolation**: Test components without the complexity of your full app
- **Multiple Themes**: Switch between light and dark themes instantly
- **Device Frames**: Preview components on different device frames
- **Text Scaling**: Test accessibility with different text scales
- **Interactive Controls**: Modify component properties in real-time

## Running the Widgetbook

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)

### Installation & Setup

1. Navigate to the widgetbook directory:
   ```bash
   cd widgetbook
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate widgetbook files (if needed):
   ```bash
   flutter packages pub run build_runner build
   ```

4. Run the widgetbook:
   ```bash
   flutter run
   ```

### Alternative: Run from Root Directory

You can also run the widgetbook from the root directory:

```bash
# From the root zoni_ui directory
cd widgetbook && flutter run
```

## Available Components

The widgetbook currently showcases:

### Layout & Headers
- **ZoniHeader**: Page headers with titles, subtitles, and actions
- **ZoniHeroHeader**: Hero sections with call-to-action buttons

### Navigation
- **ZoniDrawer**: Navigation drawer with hierarchical menu structure

### Media & Content
- **ZoniMedia**: Image, video, audio, and document display components
- **ZoniMediaGallery**: Gallery view for multiple media items
- **ZoniArticle**: Full article display with author information
- **ZoniArticleCard**: Article preview cards

### Inputs & Filters
- **ZoniRangeSlider**: Range selection sliders
- **ZoniPriceRangeSlider**: Price range selection
- **ZoniDateRangeSlider**: Date range selection
- **ZoniFilterBar**: Filter options with counts
- **ZoniSearchFilterBar**: Combined search and filter functionality

### Core Components
- **ZoniButton**: All button variants and sizes
- **ZoniCard**: Card components with different elevations
- **ZoniTextField**: Text input fields with various configurations
- **ZoniLoadingIndicator**: Loading states and animations

## Features

### Theme Switching
- Light and dark theme support
- Instant theme switching
- Consistent theming across all components

### Device Frames
Test your components on different devices:
- iPhone SE
- iPhone 13
- Samsung Galaxy S20
- Samsung Galaxy Note 20

### Text Scaling
Test accessibility with different text scales:
- 0.8x (Small)
- 1.0x (Normal)
- 1.2x (Large)
- 1.5x (Extra Large)
- 2.0x (Accessibility)

### Interactive Controls
Many components include interactive controls to:
- Change component properties
- Test different states
- Modify styling options
- Trigger callbacks and events

## Development

### Adding New Components

1. Create a new `WidgetbookComponent` in `lib/main.dart`:
   ```dart
   WidgetbookComponent(
     name: 'YourComponent',
     useCases: <WidgetbookUseCase>[
       WidgetbookUseCase(
         name: 'Default',
         builder: (BuildContext context) => YourComponent(),
       ),
       WidgetbookUseCase(
         name: 'With Custom Props',
         builder: (BuildContext context) => YourComponent(
           customProp: 'value',
         ),
       ),
     ],
   ),
   ```

2. Add it to the appropriate category in the `directories` list

3. Test the component in different themes and device frames

### Best Practices

1. **Multiple Use Cases**: Create different use cases for each component state
2. **Meaningful Names**: Use descriptive names for components and use cases
3. **Interactive Examples**: Include examples that demonstrate user interactions
4. **Error States**: Show error states and edge cases
5. **Accessibility**: Test with different text scales and themes

### Categories

Components are organized into logical categories:
- **Layout & Headers**: Page structure components
- **Navigation**: Menu and navigation components
- **Media & Content**: Content display components
- **Inputs & Filters**: Form and filter components
- **Core Components**: Basic UI building blocks

## Project Structure

```
widgetbook/
├── lib/
│   ├── main.dart                    # Main widgetbook configuration
│   └── main.directories.g.dart     # Generated directories (if using annotations)
├── pubspec.yaml                    # Dependencies including widgetbook
└── README.md                       # This file
```

## Dependencies

Key dependencies used:
- `widgetbook: ^3.18.0` - Main widgetbook package
- `widgetbook_annotation: ^3.1.0` - Annotations for code generation
- `widgetbook_generator: ^3.1.0` - Code generation tools
- `build_runner: ^2.4.7` - Build system for code generation

## Related

- [Main ZoniUI Documentation](../README.md)
- [Example App Documentation](../example/README.md)
- [Widgetbook Official Documentation](https://docs.widgetbook.io/)
- [Component API Reference](../lib/README.md)

## Tips

1. **Use Widgetbook for Development**: Develop components in isolation before integrating them into your app
2. **Test Edge Cases**: Use the widgetbook to test components with extreme values and edge cases
3. **Accessibility Testing**: Regularly test with different text scales and themes
4. **Documentation**: Use the widgetbook as living documentation for your design system
5. **Team Collaboration**: Share the widgetbook with designers and stakeholders for feedback
