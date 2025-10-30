import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// A navigation drawer item data model.
class ZoniDrawerItem {
  /// Creates a [ZoniDrawerItem].
  const ZoniDrawerItem({
    required this.title,
    this.icon,
    this.badge,
    this.isSelected = false,
    this.isEnabled = true,
    this.onTap,
    this.children = const [],
  });

  /// The title of the drawer item.
  final String title;

  /// Optional icon for the drawer item.
  final IconData? icon;

  /// Optional badge text or count.
  final String? badge;

  /// Whether this item is currently selected.
  final bool isSelected;

  /// Whether this item is enabled.
  final bool isEnabled;

  /// Callback when the item is tapped.
  final VoidCallback? onTap;

  /// Child items for expandable sections.
  final List<ZoniDrawerItem> children;

  /// Whether this item has children.
  bool get hasChildren => children.isNotEmpty;
}

/// A navigation drawer component with support for nested items and sections.
class ZoniDrawer extends StatefulWidget {
  /// Creates a [ZoniDrawer].
  const ZoniDrawer({
    super.key,
    required this.items,
    this.header,
    this.footer,
    this.width = 280.0,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showDividers = true,
    this.elevation = 16.0,
  });

  /// The navigation items to display.
  final List<ZoniDrawerItem> items;

  /// Optional header widget.
  final Widget? header;

  /// Optional footer widget.
  final Widget? footer;

  /// Width of the drawer.
  final double width;

  /// Background color of the drawer.
  final Color? backgroundColor;

  /// Color for selected items.
  final Color? selectedColor;

  /// Color for unselected items.
  final Color? unselectedColor;

  /// Whether to show dividers between sections.
  final bool showDividers;

  /// Elevation of the drawer.
  final double elevation;

  @override
  State<ZoniDrawer> createState() => _ZoniDrawerState();
}

class _ZoniDrawerState extends State<ZoniDrawer> {
  final Set<String> _expandedItems = <String>{};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      width: widget.width,
      backgroundColor: widget.backgroundColor ?? colorScheme.surface,
      elevation: widget.elevation,
      child: Column(
        children: [
          if (widget.header != null) widget.header!,
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _buildDrawerItems(),
            ),
          ),
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }

  List<Widget> _buildDrawerItems() {
    final List<Widget> widgets = [];

    for (int i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      
      widgets.add(_buildDrawerItem(item));
      
      if (item.hasChildren && _expandedItems.contains(item.title)) {
        for (final child in item.children) {
          widgets.add(_buildDrawerItem(child, isChild: true));
        }
      }
      
      if (widget.showDividers && i < widget.items.length - 1) {
        widgets.add(const Divider(height: 1));
      }
    }

    return widgets;
  }

  Widget _buildDrawerItem(ZoniDrawerItem item, {bool isChild = false}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final selectedColor = widget.selectedColor ?? colorScheme.primary;
    final unselectedColor = widget.unselectedColor ?? colorScheme.onSurface;
    
    final isExpanded = _expandedItems.contains(item.title);
    
    return Container(
      margin: EdgeInsets.only(
        left: isChild ? ZoniSpacing.lg : ZoniSpacing.xs,
        right: ZoniSpacing.xs,
        bottom: ZoniSpacing.xs,
      ),
      child: Material(
        color: item.isSelected
            ? selectedColor.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        child: InkWell(
          onTap: item.isEnabled
              ? () {
                  if (item.hasChildren) {
                    setState(() {
                      if (isExpanded) {
                        _expandedItems.remove(item.title);
                      } else {
                        _expandedItems.add(item.title);
                      }
                    });
                  } else {
                    item.onTap?.call();
                  }
                }
              : null,
          borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ZoniSpacing.md,
              vertical: ZoniSpacing.sm,
            ),
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: 20,
                    color: item.isSelected
                        ? selectedColor
                        : item.isEnabled
                            ? unselectedColor
                            : unselectedColor.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: ZoniSpacing.sm),
                ],
                Expanded(
                  child: Text(
                    item.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: item.isSelected
                          ? selectedColor
                          : item.isEnabled
                              ? unselectedColor
                              : unselectedColor.withValues(alpha: 0.5),
                      fontWeight: item.isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (item.badge != null) ...[
                  SizedBox(width: ZoniSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: selectedColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item.badge!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                if (item.hasChildren) ...[
                  SizedBox(width: ZoniSpacing.xs),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16,
                    color: item.isEnabled
                        ? unselectedColor.withValues(alpha: 0.7)
                        : unselectedColor.withValues(alpha: 0.3),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', widget.width));
    properties.add(ColorProperty('backgroundColor', widget.backgroundColor));
    properties.add(ColorProperty('selectedColor', widget.selectedColor));
    properties.add(ColorProperty('unselectedColor', widget.unselectedColor));
    properties.add(FlagProperty('showDividers', value: widget.showDividers, ifTrue: 'showDividers'));
    properties.add(DoubleProperty('elevation', widget.elevation));
  }
}

/// A drawer header component with user information and branding.
class ZoniDrawerHeader extends StatelessWidget {
  /// Creates a [ZoniDrawerHeader].
  const ZoniDrawerHeader({
    super.key,
    this.title,
    this.subtitle,
    this.avatar,
    this.backgroundImage,
    this.backgroundColor,
    this.gradient,
    this.height = 160.0,
    this.onTap,
  });

  /// Optional title text.
  final String? title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional avatar widget.
  final Widget? avatar;

  /// Optional background image.
  final ImageProvider? backgroundImage;

  /// Background color.
  final Color? backgroundColor;

  /// Optional gradient background.
  final Gradient? gradient;

  /// Height of the header.
  final double height;

  /// Callback when the header is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.primary,
        gradient: gradient,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(ZoniSpacing.md),
            decoration: backgroundImage != null
                ? BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                  )
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (avatar != null) ...[
                  avatar!,
                  SizedBox(height: ZoniSpacing.sm),
                ],
                if (title != null)
                  Text(
                    title!,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('subtitle', subtitle));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(DoubleProperty('height', height));
  }
}
