import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Represents a single breadcrumb item.
class ZoniBreadcrumbItem {
  /// Creates a ZoniBreadcrumbItem.
  const ZoniBreadcrumbItem({
    required this.label,
    this.onTap,
    this.icon,
    this.isActive = false,
  });

  /// The text label for the breadcrumb.
  final String label;

  /// Callback when the breadcrumb is tapped.
  final VoidCallback? onTap;

  /// Optional icon for the breadcrumb.
  final Widget? icon;

  /// Whether this breadcrumb is the active/current item.
  final bool isActive;
}

/// Enum for breadcrumb sizes.
enum ZoniBreadcrumbSize {
  /// Small breadcrumb size.
  small,
  /// Medium breadcrumb size.
  medium,
  /// Large breadcrumb size.
  large,
}

/// Enum for breadcrumb variants.
enum ZoniBreadcrumbVariant {
  /// Default breadcrumb variant.
  standard,
  /// Compact breadcrumb variant.
  compact,
  /// Pills breadcrumb variant.
  pills,
}

/// A breadcrumb navigation widget that follows Zoni design system principles.
class ZoniBreadcrumb extends StatelessWidget {
  /// Creates a ZoniBreadcrumb.
  const ZoniBreadcrumb({
    required this.items,
    super.key,
    this.size = ZoniBreadcrumbSize.medium,
    this.variant = ZoniBreadcrumbVariant.standard,
    this.separator,
    this.maxItems,
    this.overflowWidget,
    this.showHomeIcon = false,
    this.homeIcon,
    this.onHomeTap,
    this.activeColor,
    this.inactiveColor,
    this.separatorColor,
    this.backgroundColor,
    this.padding,
    this.itemPadding,
    this.spacing,
  });

  /// Creates a small breadcrumb.
  const ZoniBreadcrumb.small({
    required this.items,
    super.key,
    this.variant = ZoniBreadcrumbVariant.standard,
    this.separator,
    this.maxItems,
    this.overflowWidget,
    this.showHomeIcon = false,
    this.homeIcon,
    this.onHomeTap,
    this.activeColor,
    this.inactiveColor,
    this.separatorColor,
    this.backgroundColor,
    this.padding,
    this.itemPadding,
    this.spacing,
  }) : size = ZoniBreadcrumbSize.small;

  /// Creates a large breadcrumb.
  const ZoniBreadcrumb.large({
    required this.items,
    super.key,
    this.variant = ZoniBreadcrumbVariant.standard,
    this.separator,
    this.maxItems,
    this.overflowWidget,
    this.showHomeIcon = false,
    this.homeIcon,
    this.onHomeTap,
    this.activeColor,
    this.inactiveColor,
    this.separatorColor,
    this.backgroundColor,
    this.padding,
    this.itemPadding,
    this.spacing,
  }) : size = ZoniBreadcrumbSize.large;

  /// Creates a compact breadcrumb.
  const ZoniBreadcrumb.compact({
    required this.items,
    super.key,
    this.size = ZoniBreadcrumbSize.medium,
    this.separator,
    this.maxItems,
    this.overflowWidget,
    this.showHomeIcon = false,
    this.homeIcon,
    this.onHomeTap,
    this.activeColor,
    this.inactiveColor,
    this.separatorColor,
    this.backgroundColor,
    this.padding,
    this.itemPadding,
    this.spacing,
  }) : variant = ZoniBreadcrumbVariant.compact;

  /// Creates a pills breadcrumb.
  const ZoniBreadcrumb.pills({
    required this.items,
    super.key,
    this.size = ZoniBreadcrumbSize.medium,
    this.separator,
    this.maxItems,
    this.overflowWidget,
    this.showHomeIcon = false,
    this.homeIcon,
    this.onHomeTap,
    this.activeColor,
    this.inactiveColor,
    this.separatorColor,
    this.backgroundColor,
    this.padding,
    this.itemPadding,
    this.spacing,
  }) : variant = ZoniBreadcrumbVariant.pills;

  /// The list of breadcrumb items.
  final List<ZoniBreadcrumbItem> items;

  /// The size of the breadcrumb.
  final ZoniBreadcrumbSize size;

  /// The variant of the breadcrumb.
  final ZoniBreadcrumbVariant variant;

  /// Custom separator widget between breadcrumb items.
  final Widget? separator;

  /// Maximum number of items to show before truncating.
  final int? maxItems;

  /// Widget to show when items are truncated.
  final Widget? overflowWidget;

  /// Whether to show a home icon at the beginning.
  final bool showHomeIcon;

  /// Custom home icon widget.
  final Widget? homeIcon;

  /// Callback when the home icon is tapped.
  final VoidCallback? onHomeTap;

  /// Color for active breadcrumb items.
  final Color? activeColor;

  /// Color for inactive breadcrumb items.
  final Color? inactiveColor;

  /// Color for separators.
  final Color? separatorColor;

  /// Background color for the breadcrumb container.
  final Color? backgroundColor;

  /// Padding around the entire breadcrumb.
  final EdgeInsetsGeometry? padding;

  /// Padding around individual breadcrumb items.
  final EdgeInsetsGeometry? itemPadding;

  /// Spacing between breadcrumb items and separators.
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? ZoniColors.primary;
    final effectiveInactiveColor = inactiveColor ?? ZoniColors.onSurface.withOpacity(0.6);
    final effectiveSeparatorColor = separatorColor ?? ZoniColors.onSurface.withOpacity(0.4);
    final effectiveSpacing = spacing ?? _getDefaultSpacing();

    List<ZoniBreadcrumbItem> displayItems = items;

    // Handle overflow
    if (maxItems != null && items.length > maxItems!) {
      final visibleItems = maxItems! - 1; // Reserve space for overflow indicator
      displayItems = [
        ...items.take(1), // Always show first item
        ZoniBreadcrumbItem(
          label: '...',
          onTap: null,
        ),
        ...items.skip(items.length - visibleItems + 1),
      ];
    }

    final breadcrumbWidgets = <Widget>[];

    // Add home icon if requested
    if (showHomeIcon) {
      breadcrumbWidgets.add(
        _buildHomeIcon(effectiveActiveColor, effectiveInactiveColor),
      );
      if (displayItems.isNotEmpty) {
        breadcrumbWidgets.add(SizedBox(width: effectiveSpacing));
        breadcrumbWidgets.add(_buildSeparator(effectiveSeparatorColor));
        breadcrumbWidgets.add(SizedBox(width: effectiveSpacing));
      }
    }

    // Add breadcrumb items
    for (int i = 0; i < displayItems.length; i++) {
      final item = displayItems[i];
      final isLast = i == displayItems.length - 1;

      breadcrumbWidgets.add(
        _buildBreadcrumbItem(
          item,
          effectiveActiveColor,
          effectiveInactiveColor,
          isLast,
        ),
      );

      if (!isLast) {
        breadcrumbWidgets.add(SizedBox(width: effectiveSpacing));
        breadcrumbWidgets.add(_buildSeparator(effectiveSeparatorColor));
        breadcrumbWidgets.add(SizedBox(width: effectiveSpacing));
      }
    }

    Widget breadcrumb = Row(
      mainAxisSize: MainAxisSize.min,
      children: breadcrumbWidgets,
    );

    if (variant == ZoniBreadcrumbVariant.pills || backgroundColor != null) {
      breadcrumb = Container(
        padding: padding ?? _getDefaultPadding(),
        decoration: BoxDecoration(
          color: backgroundColor ?? (variant == ZoniBreadcrumbVariant.pills ? ZoniColors.surface : null),
          borderRadius: variant == ZoniBreadcrumbVariant.pills
              ? BorderRadius.circular(ZoniBorderRadius.full)
              : null,
          border: variant == ZoniBreadcrumbVariant.pills
              ? Border.all(color: ZoniColors.outline)
              : null,
        ),
        child: breadcrumb,
      );
    } else if (padding != null) {
      breadcrumb = Padding(
        padding: padding!,
        child: breadcrumb,
      );
    }

    return breadcrumb;
  }

  Widget _buildHomeIcon(Color activeColor, Color inactiveColor) {
    final icon = homeIcon ?? Icon(
      Icons.home,
      size: _getIconSize(),
      color: inactiveColor,
    );

    if (onHomeTap != null) {
      return GestureDetector(
        onTap: onHomeTap,
        child: _wrapItem(icon, false, activeColor, inactiveColor),
      );
    }

    return _wrapItem(icon, false, activeColor, inactiveColor);
  }

  Widget _buildBreadcrumbItem(
    ZoniBreadcrumbItem item,
    Color activeColor,
    Color inactiveColor,
    bool isLast,
  ) {
    final textStyle = _getTextStyle();
    final effectiveColor = item.isActive || isLast ? activeColor : inactiveColor;

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          IconTheme(
            data: IconThemeData(
              color: effectiveColor,
              size: _getIconSize(),
            ),
            child: item.icon!,
          ),
          SizedBox(width: ZoniSpacing.xs),
        ],
        Text(
          item.label,
          style: textStyle.copyWith(
            color: effectiveColor,
            fontWeight: item.isActive || isLast ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );

    Widget wrappedContent = _wrapItem(content, item.isActive || isLast, activeColor, inactiveColor);

    if (item.onTap != null && !item.isActive && !isLast) {
      return GestureDetector(
        onTap: item.onTap,
        child: wrappedContent,
      );
    }

    return wrappedContent;
  }

  Widget _wrapItem(Widget child, bool isActive, Color activeColor, Color inactiveColor) {
    if (variant == ZoniBreadcrumbVariant.pills && isActive) {
      return Container(
        padding: itemPadding ?? _getDefaultItemPadding(),
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(ZoniBorderRadius.full),
        ),
        child: IconTheme(
          data: IconThemeData(color: ZoniColors.onPrimary),
          child: DefaultTextStyle(
            style: _getTextStyle().copyWith(color: ZoniColors.onPrimary),
            child: child,
          ),
        ),
      );
    }

    if (itemPadding != null) {
      return Padding(
        padding: itemPadding!,
        child: child,
      );
    }

    return child;
  }

  Widget _buildSeparator(Color separatorColor) {
    if (separator != null) return separator!;

    return Icon(
      Icons.chevron_right,
      size: _getIconSize(),
      color: separatorColor,
    );
  }

  double _getDefaultSpacing() {
    switch (size) {
      case ZoniBreadcrumbSize.small:
        return ZoniSpacing.xs;
      case ZoniBreadcrumbSize.medium:
        return ZoniSpacing.sm;
      case ZoniBreadcrumbSize.large:
        return ZoniSpacing.md;
    }
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    switch (size) {
      case ZoniBreadcrumbSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniBreadcrumbSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniBreadcrumbSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
    }
  }

  EdgeInsetsGeometry _getDefaultItemPadding() {
    switch (size) {
      case ZoniBreadcrumbSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.xs,
          vertical: 2,
        );
      case ZoniBreadcrumbSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniBreadcrumbSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ZoniBreadcrumbSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniBreadcrumbSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniBreadcrumbSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ZoniBreadcrumbSize.small:
        return 14;
      case ZoniBreadcrumbSize.medium:
        return 16;
      case ZoniBreadcrumbSize.large:
        return 18;
    }
  }
}
