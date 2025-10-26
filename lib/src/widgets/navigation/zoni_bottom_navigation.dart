import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// Enum for bottom navigation variants
enum ZoniBottomNavigationVariant {
  fixed,
  shifting,
  floating,
}

/// Enum for bottom navigation sizes
enum ZoniBottomNavigationSize {
  small,
  medium,
  large,
}

/// A customizable bottom navigation component following Zoni design system.
///
/// The [ZoniBottomNavigation] widget provides a bottom navigation bar
/// with consistent styling and behavior across the application.
///
/// Example usage:
/// ```dart
/// ZoniBottomNavigation(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [
///     ZoniBottomNavigationItem(
///       icon: Icons.home,
///       label: 'Home',
///     ),
///     ZoniBottomNavigationItem(
///       icon: Icons.search,
///       label: 'Search',
///     ),
///   ],
/// )
/// ```
class ZoniBottomNavigation extends StatelessWidget {
  /// Creates a Zoni bottom navigation.
  const ZoniBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.variant = ZoniBottomNavigationVariant.fixed,
    this.size = ZoniBottomNavigationSize.medium,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8,
    this.showLabels = true,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.type,
    this.iconSize,
    this.selectedFontSize,
    this.unselectedFontSize,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.enableFeedback = true,
    this.mouseCursor,
    this.useLegacyColorScheme = true,
  });

  /// The interactive items laid out within the bottom navigation bar.
  final List<ZoniBottomNavigationItem> items;

  /// The index into [items] for the current active item.
  final int currentIndex;

  /// Called when one of the [items] is tapped.
  final ValueChanged<int> onTap;

  /// The visual variant of the bottom navigation.
  final ZoniBottomNavigationVariant variant;

  /// The size of the bottom navigation.
  final ZoniBottomNavigationSize size;

  /// The color of the bottom navigation bar.
  final Color? backgroundColor;

  /// The color of the selected item.
  final Color? selectedItemColor;

  /// The color of unselected items.
  final Color? unselectedItemColor;

  /// The z-coordinate of this bottom navigation bar.
  final double elevation;

  /// Whether to show labels for all items.
  final bool showLabels;

  /// Whether to show labels for selected items.
  final bool showSelectedLabels;

  /// Whether to show labels for unselected items.
  final bool showUnselectedLabels;

  /// Defines the layout and behavior of a bottom navigation bar.
  final BottomNavigationBarType? type;

  /// The size of all of the bottom navigation bar icons.
  final double? iconSize;

  /// The font size of the selected label.
  final double? selectedFontSize;

  /// The font size of the unselected label.
  final double? unselectedFontSize;

  /// The text style of the selected label.
  final TextStyle? selectedLabelStyle;

  /// The text style of the unselected label.
  final TextStyle? unselectedLabelStyle;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  final bool enableFeedback;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// Whether to use the legacy color scheme.
  final bool useLegacyColorScheme;

  @override
  Widget build(BuildContext context) {
    if (variant == ZoniBottomNavigationVariant.floating) {
      return _buildFloatingNavigation(context);
    }

    final effectiveType = type ?? _getBottomNavigationBarType();
    final effectiveBackgroundColor = backgroundColor ?? _getBackgroundColor();
    final effectiveSelectedItemColor = selectedItemColor ?? _getSelectedItemColor();
    final effectiveUnselectedItemColor = unselectedItemColor ?? _getUnselectedItemColor();

    return BottomNavigationBar(
      items: items.map((item) => item.toBottomNavigationBarItem()).toList(),
      currentIndex: currentIndex,
      onTap: onTap,
      type: effectiveType,
      backgroundColor: effectiveBackgroundColor,
      selectedItemColor: effectiveSelectedItemColor,
      unselectedItemColor: effectiveUnselectedItemColor,
      elevation: elevation,
      showSelectedLabels: showLabels && showSelectedLabels,
      showUnselectedLabels: showLabels && showUnselectedLabels,
      iconSize: iconSize ?? _getIconSize(),
      selectedFontSize: selectedFontSize ?? _getSelectedFontSize(),
      unselectedFontSize: unselectedFontSize ?? _getUnselectedFontSize(),
      selectedLabelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      enableFeedback: enableFeedback,
      mouseCursor: mouseCursor,
      useLegacyColorScheme: useLegacyColorScheme,
    );
  }

  Widget _buildFloatingNavigation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ZoniSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor ?? _getBackgroundColor(),
        borderRadius: BorderRadius.circular(ZoniBorderRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation,
            offset: Offset(0, elevation / 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ZoniBorderRadius.xl),
        child: BottomNavigationBar(
          items: items.map((item) => item.toBottomNavigationBarItem()).toList(),
          currentIndex: currentIndex,
          onTap: onTap,
          type: type ?? _getBottomNavigationBarType(),
          backgroundColor: Colors.transparent,
          selectedItemColor: selectedItemColor ?? _getSelectedItemColor(),
          unselectedItemColor: unselectedItemColor ?? _getUnselectedItemColor(),
          elevation: 0,
          showSelectedLabels: showLabels && showSelectedLabels,
          showUnselectedLabels: showLabels && showUnselectedLabels,
          iconSize: iconSize ?? _getIconSize(),
          selectedFontSize: selectedFontSize ?? _getSelectedFontSize(),
          unselectedFontSize: unselectedFontSize ?? _getUnselectedFontSize(),
          selectedLabelStyle: selectedLabelStyle,
          unselectedLabelStyle: unselectedLabelStyle,
          enableFeedback: enableFeedback,
          mouseCursor: mouseCursor,
          useLegacyColorScheme: useLegacyColorScheme,
        ),
      ),
    );
  }

  BottomNavigationBarType _getBottomNavigationBarType() {
    switch (variant) {
      case ZoniBottomNavigationVariant.fixed:
      case ZoniBottomNavigationVariant.floating:
        return BottomNavigationBarType.fixed;
      case ZoniBottomNavigationVariant.shifting:
        return BottomNavigationBarType.shifting;
    }
  }

  Color _getBackgroundColor() {
    return ZoniColors.surface;
  }

  Color _getSelectedItemColor() {
    return ZoniColors.primary;
  }

  Color _getUnselectedItemColor() {
    return ZoniColors.onSurface.withOpacity(0.6);
  }

  double _getIconSize() {
    switch (size) {
      case ZoniBottomNavigationSize.small:
        return 20;
      case ZoniBottomNavigationSize.medium:
        return 24;
      case ZoniBottomNavigationSize.large:
        return 28;
    }
  }

  double _getSelectedFontSize() {
    switch (size) {
      case ZoniBottomNavigationSize.small:
        return 10;
      case ZoniBottomNavigationSize.medium:
        return 12;
      case ZoniBottomNavigationSize.large:
        return 14;
    }
  }

  double _getUnselectedFontSize() {
    switch (size) {
      case ZoniBottomNavigationSize.small:
        return 10;
      case ZoniBottomNavigationSize.medium:
        return 12;
      case ZoniBottomNavigationSize.large:
        return 14;
    }
  }
}

/// A single item in a [ZoniBottomNavigation].
class ZoniBottomNavigationItem {
  /// Creates a bottom navigation item.
  const ZoniBottomNavigationItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.backgroundColor,
    this.tooltip,
  });

  /// The icon of the item.
  final IconData icon;

  /// The text label for the item.
  final String label;

  /// An alternative icon displayed when this bottom navigation item is selected.
  final IconData? activeIcon;

  /// The color of the background radial animation.
  final Color? backgroundColor;

  /// The text to display in the tooltip for this item.
  final String? tooltip;

  /// Converts this item to a [BottomNavigationBarItem].
  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: activeIcon != null ? Icon(activeIcon!) : null,
      label: label,
      backgroundColor: backgroundColor,
      tooltip: tooltip,
    );
  }
}

/// A bottom navigation bar with custom styling and animations.
class ZoniAnimatedBottomNavigation extends StatefulWidget {
  /// Creates an animated bottom navigation.
  const ZoniAnimatedBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8,
    this.animationDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  /// The interactive items laid out within the bottom navigation bar.
  final List<ZoniBottomNavigationItem> items;

  /// The index into [items] for the current active item.
  final int currentIndex;

  /// Called when one of the [items] is tapped.
  final ValueChanged<int> onTap;

  /// The color of the bottom navigation bar.
  final Color? backgroundColor;

  /// The color of the selected item.
  final Color? selectedItemColor;

  /// The color of unselected items.
  final Color? unselectedItemColor;

  /// The z-coordinate of this bottom navigation bar.
  final double elevation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve of the animation.
  final Curve curve;

  @override
  State<ZoniAnimatedBottomNavigation> createState() => _ZoniAnimatedBottomNavigationState();
}

class _ZoniAnimatedBottomNavigationState extends State<ZoniAnimatedBottomNavigation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(ZoniAnimatedBottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? ZoniColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: widget.elevation,
            offset: Offset(0, -widget.elevation / 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ZoniSpacing.md,
            vertical: ZoniSpacing.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.currentIndex;

              return GestureDetector(
                onTap: () => widget.onTap(index),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ZoniSpacing.sm,
                        vertical: ZoniSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (widget.selectedItemColor ?? ZoniColors.primary).withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected && item.activeIcon != null ? item.activeIcon! : item.icon,
                            color: isSelected
                                ? widget.selectedItemColor ?? ZoniColors.primary
                                : widget.unselectedItemColor ?? ZoniColors.onSurface.withOpacity(0.6),
                            size: 24,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected
                                  ? widget.selectedItemColor ?? ZoniColors.primary
                                  : widget.unselectedItemColor ?? ZoniColors.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
