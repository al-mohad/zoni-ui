# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2025-10-30

### Added

#### Content & Media Components
- **ZoniArticle** - Article content component for blog posts and articles
  - Author information with avatar and bio support
  - Publication date and read time display
  - Tag system with interactive tag selection
  - Featured image support with error handling
  - Excerpt display for article previews
  - Customizable metadata display
  - Action buttons for article interactions

- **ZoniArticleCard** - Compact article card for article lists
  - Featured image with fallback handling
  - Author, date, and read time metadata
  - Tag display with tap handling
  - Responsive design for grid layouts
  - Excerpt truncation with ellipsis

- **ZoniMedia** - Media display component with multi-format support
  - Image display with network and asset support
  - Video player placeholder with controls
  - Audio file display with playback controls
  - Document preview with file type icons
  - Loading and error state handling
  - Customizable fit and border radius

- **ZoniMediaGallery** - Media gallery for multiple items
  - Grid layout with configurable columns
  - Aspect ratio control for consistent sizing
  - Interactive item selection
  - Support for mixed media types

#### Layout & Navigation Components
- **ZoniHeader** - Header component for page titles and descriptions
  - Background image and gradient support
  - Action buttons integration
  - Multiple text alignment options
  - Customizable padding and height
  - Optional divider display

- **ZoniHeroHeader** - Large hero header with centered content
  - Full-width background support
  - Gradient overlay effects
  - Call-to-action button integration
  - Responsive height adjustment

- **ZoniDrawer** - Navigation drawer with nested items
  - Expandable menu sections
  - Badge support for notifications
  - Icon and text combinations
  - Selected state management
  - Custom header and footer support

- **ZoniDrawerHeader** - Drawer header with user information
  - Avatar and user details display
  - Background image support
  - Gradient backgrounds
  - Interactive tap handling

#### Input & Filter Components
- **ZoniRangeSlider** - Range slider for value selection
  - Dual thumb range selection
  - Custom prefix and suffix support
  - Division markers for discrete values
  - Label display with formatting
  - Color customization options

- **ZoniPriceRangeSlider** - Specialized price range selector
  - Currency symbol support
  - Price formatting with divisions
  - Min/max price display
  - Interactive range adjustment

- **ZoniDateRangeSlider** - Date range selection slider
  - Date range visualization
  - Min/max date constraints
  - Formatted date display
  - Smooth date range adjustment

- **ZoniFilterBar** - Filter options display and management
  - Multiple filter selection
  - Count badges for filter options
  - Clear all functionality
  - Scrollable and wrap layouts
  - Icon support for filters

- **ZoniSearchFilterBar** - Combined search and filter interface
  - Integrated search field
  - Filter chips with counts
  - Clear search functionality
  - Responsive layout options

#### Advanced Data Visualization Components
- **ZoniChart** - Comprehensive chart component for data visualization
  - Multiple chart types: line, bar, pie, area, donut
  - Customizable series with colors and styling options
  - Interactive legends and grid display
  - Support for multiple data series
  - Custom painters for efficient rendering
- **ZoniDashboard** - Dashboard layout component for organizing widgets
  - Multiple layout types: grid, masonry, list
  - Drag-and-drop support for reordering items
  - Customizable item sizing and constraints
  - Loading, error, and empty state handling
  - Scrollable and responsive layouts
- **ZoniDataGrid** - Advanced data grid with enterprise features
  - Column sorting and resizing capabilities
  - Row selection (single and multiple modes)
  - Custom cell and header builders
  - Alternating row colors and hover effects
  - Loading and empty state management
  - Context menu support for rows

#### Project Management Components
- **ZoniKanban** - Kanban board component for project management
  - Drag-and-drop cards between columns
  - Customizable card and column styling
  - Priority indicators and due date tracking
  - Assignee avatars and tag support
  - Collapsible columns and card limits
  - Context menus for cards and columns
- **ZoniCalendar** - Comprehensive calendar component
  - Multiple view types: month, week, day, agenda
  - Event management with colors and categories
  - Holiday and weekend highlighting
  - Multi-select date support
  - Custom event and day builders
  - Navigation and view switching controls

#### Enhanced Input Components
- **ZoniMultiSelect** - Multi-selection component with various display modes
  - Multiple variants: dropdown, list, chips, modal
  - Search and filtering capabilities
  - Group-based organization of options
  - Selection limits and validation
  - Custom item and chip builders
  - Select all and clear all functionality

#### Business & Marketing Components
- **ZoniStatsCard** - Statistics card component for displaying key metrics
  - Trend indicators with up/down/neutral states
  - Icon and color customization
  - Subtitle and value formatting
  - Interactive tap handling
  - Responsive sizing options

- **ZoniActivityFeed** - Activity feed component for chronological displays
  - Timeline connector with customizable styling
  - Avatar and icon support for activities
  - Timestamp formatting with relative dates
  - Empty state handling
  - Interactive item selection

- **ZoniNotificationPanel** - Notification panel with comprehensive features
  - Multiple notification types: info, success, warning, error
  - Read/unread state management
  - Dismissible notifications with swipe gestures
  - Batch operations: mark all read, clear all
  - Timestamp display and formatting
  - Custom notification actions

- **ZoniUserProfile** - User profile component with multiple variants
  - Card, compact, and detailed display modes
  - Status indicators: online, away, busy, offline
  - Badge system for achievements and roles
  - Statistics display for user metrics
  - Avatar support with fallback initials
  - Custom action buttons

- **ZoniPricingCard** - Pricing card component for subscription plans
  - Popular and recommended plan highlighting
  - Feature list with checkmark indicators
  - Flexible pricing display with currency support
  - Action buttons with custom styling
  - Responsive grid layout support
  - Mobile-optimized carousel view

- **ZoniTestimonial** - Testimonial component for customer reviews
  - Multiple variants: card, compact, featured
  - Star rating display system
  - Author information with avatar support
  - Quote formatting with optional quote marks
  - Carousel support for multiple testimonials
  - Auto-play functionality with indicators

- **ZoniFeatureShowcase** - Feature showcase component for product highlights
  - Multiple layout options: grid, list, carousel
  - Icon and image support for features
  - Responsive design with configurable columns
  - Interactive feature cards with tap handling
  - Custom color theming per feature
  - Mobile-optimized layouts

- **ZoniColorPalette** - Color palette display component for showcasing design system colors
  - Named constructors for primary, semantic, and neutral color palettes
  - Hex value display with copy-to-clipboard functionality
  - Hover effects and grid layout support
- **ZoniCodeBlock** - Code block component for displaying syntax-highlighted code
  - Dark and light theme variants
  - Line numbers support and copy button functionality
  - Horizontal scrolling and line truncation
  - Language specification support
- **ZoniStatusIndicator** - Status indicator component with multiple variants
  - Status types: success, warning, error, info, neutral, processing
  - Three size variants (small, medium, large)
  - Animated processing state with pulse effect
  - ZoniStatusCard variant for richer status displays
- **ZoniSection** - Section components for organizing content
  - ZoniSection base component with title, description, and header actions
  - ZoniGridSection for grid layouts
  - ZoniListSection for vertical lists
  - Card and minimal variants with customizable styling
- **ZoniInfoCard** - Enhanced card component for displaying information
  - Multiple variants: neutral, success, warning, error, info
  - Named constructors for each variant
  - Support for icons, descriptions, and trailing widgets
- **ZoniFeatureCard** - Feature card component for showcasing features or services
  - Support for icons or images
  - Customizable aspect ratio and action buttons
  - Responsive design with proper text overflow handling
- **ZoniEmptyState** - Empty state components for no data scenarios
  - Named constructors for common scenarios: noData, noResults, error, offline
  - ZoniEmptyList and ZoniEmptySearch specialized variants
  - Support for custom illustrations and action buttons
- **ZoniSkeleton** - Skeleton loader components for loading states
  - Multiple variants: circle, rectangle, text
  - Animated shimmer effect with customizable colors
  - Pre-built components: ZoniSkeletonListItem, ZoniSkeletonCard, ZoniSkeletonParagraph
- **ZoniMetricCard** - Metric display components for KPIs and analytics
  - Trend indicators with up/down/neutral states
  - ZoniMetricGrid for grid layouts
  - ZoniMetric and ZoniMetricRow for simple metric displays
- **ZoniStack** - Enhanced layout components with positioning utilities
  - ZoniPositioned with named constructors for common positions
  - ZoniFlex with row/column variants
  - ZoniWrap for responsive wrapping layouts
- **ZoniForm** - Form wrapper component with validation and submission handling
  - Form validation with GlobalKey<FormState>
  - Auto-validation modes and change callbacks
  - Customizable padding and submission handling
- **ZoniFormSection** - Form section component for grouping related form fields
  - Section titles and descriptions
  - Collapsible sections with expand/collapse functionality
  - Consistent spacing and styling
- **ZoniFormField** - Form field wrapper with label and validation display
  - Required field indicators
  - Helper text and error message display
  - Consistent field styling and spacing
- **ZoniFormActions** - Form actions component for submit/cancel buttons
  - Configurable button alignment (left, center, right, spaceBetween)
  - Primary and secondary action buttons
  - Responsive button layouts
- **ZoniToggleGroup** - Toggle group component for single or multi-select options
  - Generic type support for any data type
  - Horizontal and vertical layout directions
  - Multi-select and single-select modes
  - Customizable spacing and styling
- **ZoniRating** - Star rating component with interactive and read-only modes
  - Half-rating support with allowHalfRating option
  - Customizable star count and colors
  - Interactive rating changes with callbacks
  - Read-only display mode
- **ZoniTagInput** - Tag input component for adding and removing tags
  - Add tags with Enter key or custom delimiter
  - Remove tags with backspace or tap
  - Customizable tag styling and colors
  - Input validation and callbacks
- **ZoniTimeline** - Timeline component for displaying chronological events
  - Vertical and horizontal timeline layouts
  - Customizable indicators with completion states
  - Active item highlighting and custom colors
  - Support for custom indicator widgets

### Enhanced

- Updated example app with comprehensive design system component showcase
- Added new component exports to main library file

## [0.2.0] - 2024-10-27

### Added

#### Advanced Display Components
- **ZoniTable**: Comprehensive data table component
  - Column configuration with custom headers and cell builders
  - Row selection (single/multiple) with callbacks
  - Sortable columns with ascending/descending indicators
  - Responsive design with horizontal scrolling
  - Customizable styling for headers, rows, and cells
  - Pagination support integration
- **ZoniAccordion**: Expandable/collapsible content component
  - Single or multiple expansion modes
  - Custom expand/collapse icons with smooth animations
  - Header and content styling customization
  - 5 semantic variants: primary, secondary, success, warning, error
  - Animation duration control and easing curves

#### Advanced Navigation Components
- **ZoniStepper**: Step-by-step navigation component
  - 5 step states: inactive, active, completed, error, disabled
  - 2 orientations: horizontal, vertical
  - 3 sizes: small, medium, large
  - Custom step icons and content with flexible builders
  - Optional steps support for non-linear workflows
  - Custom controls builder with ControlsDetails
  - Connector customization (color, thickness, style)
- **ZoniSidebar**: Collapsible sidebar navigation
  - Nested menu items with unlimited depth
  - Expand/collapse animations with smooth transitions
  - Custom icons and badges for menu items
  - Header and footer sections with custom content
  - Responsive design with overlay mode for mobile
  - Theme-aware styling with dark/light mode support

#### Advanced Feedback Components
- **ZoniModal**: Overlay modal/dialog component
  - Multiple sizes: small, medium, large, fullscreen
  - Backdrop blur and color customization
  - ESC key and backdrop tap to close functionality
  - Custom header, body, and footer sections
  - Smooth show/hide animations with fade and scale effects
  - Barrier dismissible control with custom callbacks

#### Advanced Input Components
- **ZoniDatePicker**: Material Design 3 date picker integration
  - Date range selection support with start/end dates
  - Custom date formatting with locale support
  - Validation with error states and custom validators
  - Internationalization support for multiple locales
  - Custom styling and theming integration
  - Accessibility features with screen reader support
- **ZoniTimePicker**: Material Design 3 time picker integration
  - 12/24 hour format support with automatic detection
  - Custom time formatting with locale preferences
  - Validation with error states and time constraints
  - Custom styling and theming integration
  - Accessibility features with keyboard navigation
- **ZoniFileUpload**: Drag-and-drop file upload component
  - Multiple file selection with configurable limits
  - File type validation (extensions, MIME types)
  - File size validation with custom size limits
  - Upload progress indication with percentage display
  - Custom upload area styling with drag states
  - File preview and removal functionality
  - Error handling with detailed error messages
- **ZoniSearchField**: Search input with autocomplete
  - Debounced search queries with configurable delay
  - Custom suggestion builder with flexible layouts
  - Keyboard navigation (arrow keys, enter, escape)
  - Focus management and overlay positioning
  - Custom styling for input and suggestions
  - Search history and recent searches support

### Enhanced

#### Technical Architecture
- **Overlay Management**: Advanced overlay system using Flutter's Overlay API
  - Layer Link positioning with CompositedTransformTarget/Follower
  - Precise overlay positioning for floating elements
  - Z-index management for complex UI hierarchies
- **Animation System**: Comprehensive animation framework
  - Animation controllers with SingleTickerProviderStateMixin
  - Smooth transitions with configurable easing curves
  - Performance-optimized animations with proper disposal
- **Focus Management**: Advanced keyboard interaction system
  - Proper focus handling with FocusNode management
  - Keyboard listeners for ESC key and navigation
  - Tab order management for accessibility
- **File Validation**: Robust file handling system
  - Comprehensive file type and size validation
  - MIME type detection and validation
  - Error handling with user-friendly messages
- **Search Optimization**: Performance-optimized search functionality
  - Debouncing implementation for search queries
  - Efficient suggestion filtering and display
  - Memory management for large suggestion lists

#### Design System Maturity
- **Component Consistency**: Unified design language across all components
  - Consistent spacing, typography, and color usage
  - Standardized component APIs and naming conventions
  - Unified error handling and validation patterns
- **Accessibility Improvements**: Enhanced accessibility features
  - Comprehensive screen reader support
  - Keyboard navigation for all interactive elements
  - High contrast mode support
  - Focus indicators and semantic markup
- **Responsive Design**: Advanced responsive capabilities
  - Breakpoint-aware component behavior
  - Mobile-first design approach
  - Adaptive layouts for different screen sizes

### Fixed
- **ZoniStepper Implementation**: Resolved file corruption issues during development
  - Fixed debug method conflicts causing compilation errors
  - Proper method naming with private underscore prefixes
  - Stable file creation using shell heredoc pattern
- **Type Safety**: Enhanced generic type support
  - Proper type constraints for generic components
  - Improved type inference and error messages
  - Null safety compliance across all new components

### Technical Improvements
- **Performance Optimization**: Enhanced rendering performance
  - Efficient widget rebuilding with proper keys
  - Optimized animation performance
  - Memory leak prevention with proper disposal
- **Code Quality**: Improved code architecture
  - Consistent error handling patterns
  - Comprehensive documentation coverage
  - Enhanced debugging capabilities

## [0.1.1] - 2024-10-26

### Added

#### Typography Components
- **ZoniText**: Complete Material Design 3 typography system
  - 15 named constructors for all text styles (displayLarge, displayMedium, displaySmall, headlineLarge, headlineMedium, headlineSmall, titleLarge, titleMedium, titleSmall, bodyLarge, bodyMedium, bodySmall, labelLarge, labelMedium, labelSmall)
  - Consistent styling with theme integration
  - Accessibility support with semantic labels

#### Layout Components
- **ZoniContainer**: Flexible container component with semantic variants
  - Named constructors: card(), surface(), small(), medium(), large()
  - Consistent spacing and styling
  - Theme-aware background colors
- **ZoniDivider**: Versatile divider component
  - 3 variants: solid, dashed, dotted
  - 3 thickness options: thin, medium, thick
  - Horizontal and vertical orientations
  - Custom painter for advanced line styles
- **ZoniGrid**: Responsive 12-column grid system
  - Column spanning with ZoniGridItem
  - Configurable spacing and auto-adjustment
  - Responsive breakpoint support

#### Navigation Components
- **ZoniAppBar**: Enhanced app bar with Zoni branding
  - Material Design 3 styling
  - Custom color schemes
  - Action button support
- **ZoniTabs**: Comprehensive tab system
  - Multiple variants: primary, secondary, outlined
  - Scrollable and fixed tab bars
  - Custom styling and theming
- **ZoniBreadcrumb**: Navigation breadcrumb component
  - Customizable separators
  - Click navigation support
  - Overflow handling
- **ZoniPagination**: Complete pagination component
  - Page number display and navigation
  - First/last page buttons
  - Customizable page size
- **ZoniBottomNavigation**: Material 3 bottom navigation
  - Custom styling with Zoni brand colors
  - Icon and label support
  - State management for selected items

#### Input Components
- **ZoniCheckbox**: Enhanced checkbox component
  - 5 variants: primary, secondary, success, warning, error
  - 3 sizes: small, medium, large
  - List tile integration support
- **ZoniRadio**: Type-safe radio button component
  - Generic type support: ZoniRadio<T>
  - 5 variants: primary, secondary, success, warning, error
  - 3 sizes: small, medium, large
  - Group management with ZoniRadioGroup<T>
- **ZoniSwitch**: Material 3 switch component
  - 5 variants: primary, secondary, success, warning, error
  - 3 sizes: small, medium, large
  - Support for both standalone switches and switch list tiles
- **ZoniSlider**: Customizable slider component
  - Range and single value support
  - Custom styling and theming
  - Accessibility features
- **ZoniDropdown**: Enhanced dropdown component
  - Multiple selection support
  - Custom styling
  - Search functionality

#### Display Components
- **ZoniAvatar**: Flexible avatar component
  - Multiple sizes and variants
  - Image, text, and icon support
  - Fallback handling
- **ZoniBadge**: Notification badge component
  - 7 variants: primary, secondary, success, warning, error, info, light
  - 3 sizes: small, medium, large
  - Text and count badge support
- **ZoniChip**: Interactive chip component
  - 6 variants: filled, outlined, input, choice, filter, action
  - 3 sizes: small, medium, large
  - Selection and deletion support
- **ZoniTooltip**: Enhanced tooltip component
  - Multiple positions and variants
  - Custom styling and theming
  - Accessibility support
- **ZoniList**: Comprehensive list components
  - ZoniListTile with enhanced styling
  - ZoniExpansionTile for collapsible content
  - ZoniListView with built-in styling

#### Feedback Components
- **ZoniSnackbar**: Enhanced snackbar component
  - 4 semantic variants: info, success, warning, error
  - Action button support
  - Custom duration and positioning
- **ZoniDialog**: Comprehensive dialog system
  - Multiple variants: info, success, warning, error, confirmation
  - Custom actions and content
  - Accessibility features
- **ZoniProgress**: Progress indicator components
  - Linear and circular variants
  - Determinate and indeterminate modes
  - Custom styling and theming
- **ZoniAlert**: Alert/banner component
  - 4 semantic variants: info, success, warning, error
  - 3 sizes: small, medium, large
  - Dismissible functionality with callbacks

### Enhanced

#### Design System
- **Zoni Brand Colors**: Complete integration of Zoni color palette
  - Core colors: Zoni Blue (#007BFF), Fresh Green (#28A745), Neutral Gray (#6C757D), Warm Orange (#FD7E14), Soft White (#FFFFFF), Deep Black (#212529)
  - Semantic color variants for all components
  - Consistent color application across the design system

#### Developer Experience
- **Centralized ZoniUI API**: Single entry point for all design system utilities
  - Organized component access through ZoniUI class
  - Consistent naming conventions
  - Type-safe APIs with comprehensive error handling

#### Example Application
- **Comprehensive Component Showcase**: Updated example app with all new components
  - Interactive demonstrations of all component variants
  - Real-world usage examples
  - Responsive design patterns

### Fixed
- **Debug Method Issues**: Resolved compilation errors caused by orphaned debugFillProperties methods
- **Import Dependencies**: Added proper imports for DragStartBehavior and other Flutter dependencies
- **File System Conflicts**: Overcame file creation/deletion conflicts during development
- **Deprecated API Usage**: Updated withOpacity() calls to use withValues(alpha:) for better precision

### Technical Improvements
- **Material Design 3 Compliance**: All components follow latest Material Design guidelines
- **Type Safety**: Enhanced generic type support and proper enum usage
- **Performance**: Efficient rendering with proper widget lifecycle management
- **Code Quality**: Consistent architecture patterns across all components

## [0.1.0] - 2024-01-XX

### Added

#### Design System Foundation
- Complete color system with semantic tokens following Material Design 3
- Typography scale with display, headline, title, body, and label styles
- Spacing system following 8pt grid
- Border radius and elevation constants
- Animation duration constants
- Responsive breakpoint constants

#### Theme System
- Light and dark theme implementations
- Material Design 3 color schemes
- Comprehensive component theming
- Theme switching support

#### Components
- **ZoniButton**: Multi-variant button component with filled, outlined, text, and filled tonal styles
  - Multiple sizes (small, medium, large)
  - Loading states with progress indicators
  - Icon support
  - Accessibility features
  - Tooltip support
- **ZoniCard**: Flexible card component with elevation variants
  - Multiple elevation levels
  - Custom padding and margins
  - Tap interaction support
  - Accessibility features
- **ZoniTextField**: Comprehensive text input component
  - Multiple sizes
  - Prefix and suffix icon support
  - Helper and error text
  - Form validation support
  - Accessibility features
- **ZoniLoadingIndicator**: Loading indicator with multiple styles
  - Circular, linear, and dots variants
  - Multiple sizes
  - Custom colors
  - Accessibility features

#### Developer Experience
- Comprehensive documentation
- Complete test coverage (unit, widget, and golden tests)
- Strict linting rules and code quality standards
- Type-safe APIs with proper error handling
- Debug utilities and diagnostic properties

#### Accessibility
- Semantic labels for all components
- Screen reader support
- Keyboard navigation support
- High contrast support
- Focus management

### Technical Details
- Minimum Flutter version: 3.10.0
- Minimum Dart version: 3.0.0
- Material Design 3 support
- Null safety enabled
- Comprehensive test coverage

## [0.0.1] - 2024-01-XX

### Added
- Initial project setup
- Basic project structure
