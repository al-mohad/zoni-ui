/// Integer constants for the Zoni design system.
///
/// This class provides a comprehensive set of integer constants organized by
/// usage categories to ensure consistency across the design system.
///
/// ## Usage Categories:
/// - **Animation Durations**: Millisecond values for animations
/// - **Limits & Counts**: Maximum/minimum values for UI elements
/// - **Grid & Layout**: Column counts, flex values, and layout ratios
/// - **Z-Index**: Layer ordering for overlays and modals
/// - **Timing**: Debounce delays, timeouts, and intervals
///
/// ## Examples:
/// ```dart
/// // Animation durations
/// AnimatedContainer(
///   duration: Duration(milliseconds: ZoniIntConstants.animationFast),
///   curve: Curves.easeInOut,
/// )
///
/// // Grid layouts
/// GridView.count(
///   crossAxisCount: ZoniIntConstants.gridColumnsTablet,
///   children: widgets,
/// )
///
/// // Z-index layering
/// Positioned(
///   child: Container(),
///   // Use z-index constants for proper layering
/// )
/// ```
class ZoniIntConstants {
  // ==========================================================================
  // ANIMATION DURATION CONSTANTS (in milliseconds)
  // ==========================================================================

  /// Instant animation - 0ms
  static const int animationInstant = 0;

  /// Very fast animation - 100ms
  static const int animationVeryFast = 100;

  /// Fast animation - 150ms
  static const int animationFast = 150;

  /// Normal animation - 200ms
  static const int animationNormal = 200;

  /// Medium animation - 300ms
  static const int animationMedium = 300;

  /// Slow animation - 500ms
  static const int animationSlow = 500;

  /// Very slow animation - 700ms
  static const int animationVerySlow = 700;

  /// Extra slow animation - 1000ms
  static const int animationExtraSlow = 1000;

  // ==========================================================================
  // GRID & LAYOUT CONSTANTS
  // ==========================================================================

  /// Single column layout
  static const int gridColumnsSingle = 1;

  /// Two column layout (mobile)
  static const int gridColumnsMobile = 2;

  /// Three column layout (tablet)
  static const int gridColumnsTablet = 3;

  /// Four column layout (desktop)
  static const int gridColumnsDesktop = 4;

  /// Six column layout (wide desktop)
  static const int gridColumnsWide = 6;

  /// Twelve column layout (full grid system)
  static const int gridColumnsFull = 12;

  /// Default flex value
  static const int flexDefault = 1;

  /// Double flex value
  static const int flexDouble = 2;

  /// Triple flex value
  static const int flexTriple = 3;

  // ==========================================================================
  // Z-INDEX CONSTANTS
  // ==========================================================================

  /// Base z-index (default layer)
  static const int zIndexBase = 0;

  /// Dropdown z-index
  static const int zIndexDropdown = 1000;

  /// Sticky elements z-index
  static const int zIndexSticky = 1020;

  /// Fixed elements z-index
  static const int zIndexFixed = 1030;

  /// Modal backdrop z-index
  static const int zIndexModalBackdrop = 1040;

  /// Modal z-index
  static const int zIndexModal = 1050;

  /// Popover z-index
  static const int zIndexPopover = 1060;

  /// Tooltip z-index
  static const int zIndexTooltip = 1070;

  /// Toast/Snackbar z-index
  static const int zIndexToast = 1080;

  /// Maximum z-index
  static const int zIndexMax = 2147483647;

  // ==========================================================================
  // LIMITS & COUNTS
  // ==========================================================================

  /// Minimum items to show
  static const int minItems = 1;

  /// Default page size
  static const int defaultPageSize = 10;

  /// Small page size
  static const int smallPageSize = 5;

  /// Large page size
  static const int largePageSize = 20;

  /// Maximum page size
  static const int maxPageSize = 100;

  /// Default max lines for text
  static const int maxLinesDefault = 3;

  /// Maximum characters for short text
  static const int maxCharsShort = 50;

  /// Maximum characters for medium text
  static const int maxCharsMedium = 100;

  /// Maximum characters for long text
  static const int maxCharsLong = 500;

  /// Maximum file size in MB
  static const int maxFileSizeMB = 10;

  /// Maximum image size in MB
  static const int maxImageSizeMB = 5;

  // ==========================================================================
  // TIMING CONSTANTS (in milliseconds)
  // ==========================================================================

  /// Short debounce delay - 300ms
  static const int debounceShort = 300;

  /// Medium debounce delay - 500ms
  static const int debounceMedium = 500;

  /// Long debounce delay - 1000ms
  static const int debounceLong = 1000;

  /// Auto-hide timeout for toasts - 3000ms
  static const int toastTimeout = 3000;

  /// Auto-hide timeout for tooltips - 5000ms
  static const int tooltipTimeout = 5000;

  /// Loading timeout - 30000ms (30 seconds)
  static const int loadingTimeout = 30000;

  /// Network request timeout - 10000ms (10 seconds)
  static const int networkTimeout = 10000;

  // ==========================================================================
  // COMMON NUMERIC VALUES
  // ==========================================================================

  /// Zero value
  static const int zero = 0;

  /// One value
  static const int one = 1;

  /// Two value
  static const int two = 2;

  /// Three value
  static const int three = 3;

  /// Four value
  static const int four = 4;

  /// Five value
  static const int five = 5;

  /// Ten value
  static const int ten = 10;

  /// Twenty value
  static const int twenty = 20;

  /// Fifty value
  static const int fifty = 50;

  /// One hundred value
  static const int oneHundred = 100;

  // ==========================================================================
  // PERCENTAGE VALUES
  // ==========================================================================

  /// 0% as integer
  static const int percent0 = 0;

  /// 25% as integer
  static const int percent25 = 25;

  /// 50% as integer
  static const int percent50 = 50;

  /// 75% as integer
  static const int percent75 = 75;

  /// 100% as integer
  static const int percent100 = 100;

  // ==========================================================================
  // LEGACY CONSTANTS (for backward compatibility)
  // ==========================================================================

  /// @deprecated Use specific named constants instead
  static const int int0 = 0;

  /// @deprecated Use specific named constants instead
  static const int int1 = 1;

  /// @deprecated Use specific named constants instead
  static const int int2 = 2;

  /// @deprecated Use specific named constants instead
  static const int int3 = 3;

  /// @deprecated Use specific named constants instead
  static const int int4 = 4;

  /// @deprecated Use specific named constants instead
  static const int int5 = 5;

  /// @deprecated Use specific named constants instead
  static const int int10 = 10;

  /// @deprecated Use specific named constants instead
  static const int int20 = 20;

  /// @deprecated Use specific named constants instead
  static const int int50 = 50;

  /// @deprecated Use specific named constants instead
  static const int int100 = 100;
}
