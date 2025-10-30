import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for sidebar position.
enum ZoniSidebarPosition {
  /// Left side of the screen.
  left,

  /// Right side of the screen.
  right,
}

/// Enum for sidebar behavior.
enum ZoniSidebarBehavior {
  /// Sidebar pushes content when opened.
  push,

  /// Sidebar overlays content when opened.
  overlay,

  /// Sidebar is always visible (persistent).
  persistent,
}

/// Represents a menu item in the sidebar.
class ZoniSidebarItem {
  /// Creates a sidebar menu item.
  const ZoniSidebarItem({
    required this.key,
    required this.title,
    this.icon,
    this.trailing,
    this.onTap,
    this.children = const <ZoniSidebarItem>[],
    this.isExpanded = false,
    this.isSelected = false,
    this.badge,
    this.enabled = true,
  });

  /// Unique key for the menu item.
  final String key;

  /// Title text for the menu item.
  final String title;

  /// Leading icon for the menu item.
  final IconData? icon;

  /// Trailing widget for the menu item.
  final Widget? trailing;

  /// Callback when the menu item is tapped.
  final VoidCallback? onTap;

  /// Child menu items for nested navigation.
  final List<ZoniSidebarItem> children;

  /// Whether the menu item is expanded (for items with children).
  final bool isExpanded;

  /// Whether the menu item is selected.
  final bool isSelected;

  /// Badge widget to show notifications or counts.
  final Widget? badge;

  /// Whether the menu item is enabled.
  final bool enabled;

  /// Creates a copy of this item with updated properties.
  ZoniSidebarItem copyWith({
    String? key,
    String? title,
    IconData? icon,
    Widget? trailing,
    VoidCallback? onTap,
    List<ZoniSidebarItem>? children,
    bool? isExpanded,
    bool? isSelected,
    Widget? badge,
    bool? enabled,
  }) =>
      ZoniSidebarItem(
        key: key ?? this.key,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        trailing: trailing ?? this.trailing,
        onTap: onTap ?? this.onTap,
        children: children ?? this.children,
        isExpanded: isExpanded ?? this.isExpanded,
        isSelected: isSelected ?? this.isSelected,
        badge: badge ?? this.badge,
        enabled: enabled ?? this.enabled,
      );
}

/// A collapsible sidebar navigation component following Zoni design system.
///
/// The [ZoniSidebar] widget provides a navigation sidebar with support for
/// nested menus, collapsing, and responsive behavior.
///
/// Example usage:
/// ```dart
/// ZoniSidebar(
///   items: [
///     ZoniSidebarItem(
///       key: 'dashboard',
///       title: 'Dashboard',
///       icon: Icons.dashboard,
///       onTap: () => print('Dashboard tapped'),
///     ),
///     ZoniSidebarItem(
///       key: 'users',
///       title: 'Users',
///       icon: Icons.people,
///       children: [
///         ZoniSidebarItem(
///           key: 'all_users',
///           title: 'All Users',
///           onTap: () => print('All Users tapped'),
///         ),
///       ],
///     ),
///   ],
/// )
/// ```
class ZoniSidebar extends StatefulWidget {
  /// Creates a Zoni sidebar.
  const ZoniSidebar({
    required this.items,
    super.key,
    this.width = 280.0,
    this.collapsedWidth = 72.0,
    this.isCollapsed = false,
    this.position = ZoniSidebarPosition.left,
    this.behavior = ZoniSidebarBehavior.persistent,
    this.onToggle,
    this.onItemTap,
    this.header,
    this.footer,
    this.backgroundColor,
    this.selectedColor,
    this.hoverColor,
    this.textColor,
    this.iconColor,
    this.dividerColor,
    this.elevation = 4.0,
    this.borderRadius,
    this.showToggleButton = true,
    this.toggleIcon = Icons.menu,
    this.collapseIcon = Icons.chevron_left,
    this.expandIcon = Icons.chevron_right,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  /// List of sidebar menu items.
  final List<ZoniSidebarItem> items;

  /// Width of the sidebar when expanded.
  final double width;

  /// Width of the sidebar when collapsed.
  final double collapsedWidth;

  /// Whether the sidebar is currently collapsed.
  final bool isCollapsed;

  /// Position of the sidebar.
  final ZoniSidebarPosition position;

  /// Behavior of the sidebar.
  final ZoniSidebarBehavior behavior;

  /// Callback when the sidebar is toggled.
  final VoidCallback? onToggle;

  /// Callback when a menu item is tapped.
  final void Function(ZoniSidebarItem item)? onItemTap;

  /// Header widget for the sidebar.
  final Widget? header;

  /// Footer widget for the sidebar.
  final Widget? footer;

  /// Background color of the sidebar.
  final Color? backgroundColor;

  /// Color for selected menu items.
  final Color? selectedColor;

  /// Color for hovered menu items.
  final Color? hoverColor;

  /// Text color for menu items.
  final Color? textColor;

  /// Icon color for menu items.
  final Color? iconColor;

  /// Color for divider lines.
  final Color? dividerColor;

  /// Elevation of the sidebar.
  final double elevation;

  /// Border radius of the sidebar.
  final BorderRadius? borderRadius;

  /// Whether to show the toggle button.
  final bool showToggleButton;

  /// Icon for the toggle button.
  final IconData toggleIcon;

  /// Icon for collapsing the sidebar.
  final IconData collapseIcon;

  /// Icon for expanding the sidebar.
  final IconData expandIcon;

  /// Animation duration for expand/collapse.
  final Duration animationDuration;

  @override
  State<ZoniSidebar> createState() => _ZoniSidebarState();
}

class _ZoniSidebarState extends State<ZoniSidebar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late List<ZoniSidebarItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _updateAnimation();
    if (widget.isCollapsed) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ZoniSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCollapsed != oldWidget.isCollapsed) {
      if (widget.isCollapsed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
    if (widget.items != oldWidget.items) {
      _items = List.from(widget.items);
    }
    _updateAnimation();
  }

  void _updateAnimation() {
    _widthAnimation = Tween<double>(
      begin: widget.width,
      end: widget.collapsedWidth,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _backgroundColor => widget.backgroundColor ?? ZoniColors.surface;
  Color get _selectedColor =>
      widget.selectedColor ?? ZoniColors.primary.withValues(alpha: 0.1);
  Color get _hoverColor => widget.hoverColor ?? ZoniColors.surfaceVariant;
  Color get _textColor => widget.textColor ?? ZoniColors.onSurface;
  Color get _iconColor => widget.iconColor ?? ZoniColors.onSurfaceVariant;
  Color get _dividerColor => widget.dividerColor ?? ZoniColors.outline;

  void _handleItemTap(ZoniSidebarItem item) {
    if (!item.enabled) return;

    if (item.children.isNotEmpty) {
      setState(() {
        final int index =
            _items.indexWhere((ZoniSidebarItem i) => i.key == item.key);
        if (index != -1) {
          _items[index] = item.copyWith(isExpanded: !item.isExpanded);
        }
      });
    } else {
      // Update selection state
      setState(() {
        _items = _items
            .map(
              (ZoniSidebarItem i) => i.copyWith(isSelected: i.key == item.key),
            )
            .toList();
      });
      item.onTap?.call();
      widget.onItemTap?.call(item);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _widthAnimation,
        builder: (BuildContext context, Widget? child) {
          final bool isCollapsed = _animationController.value > 0.5;

          return Material(
            elevation: widget.elevation,
            borderRadius: widget.borderRadius,
            color: _backgroundColor,
            child: SizedBox(
              width: _widthAnimation.value,
              child: Column(
                children: <Widget>[
                  if (widget.header != null) _buildHeader(isCollapsed),
                  if (widget.showToggleButton) _buildToggleButton(isCollapsed),
                  Expanded(
                    child: ListView(
                      padding:
                          const EdgeInsets.symmetric(vertical: ZoniSpacing.sm),
                      children: _items
                          .map(
                            (ZoniSidebarItem item) =>
                                _buildMenuItem(item, isCollapsed),
                          )
                          .toList(),
                    ),
                  ),
                  if (widget.footer != null) _buildFooter(isCollapsed),
                ],
              ),
            ),
          );
        },
      );

  Widget _buildHeader(bool isCollapsed) => Container(
        padding: const EdgeInsets.all(ZoniSpacing.md),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: _dividerColor),
          ),
        ),
        child: isCollapsed ? const SizedBox.shrink() : widget.header!,
      );

  Widget _buildToggleButton(bool isCollapsed) => Container(
        padding: const EdgeInsets.all(ZoniSpacing.sm),
        child: Align(
          alignment: widget.position == ZoniSidebarPosition.left
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: IconButton(
            icon: Icon(
              isCollapsed ? widget.expandIcon : widget.collapseIcon,
              color: _iconColor,
            ),
            onPressed: widget.onToggle,
            tooltip: isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
          ),
        ),
      );

  Widget _buildFooter(bool isCollapsed) => Container(
        padding: const EdgeInsets.all(ZoniSpacing.md),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: _dividerColor),
          ),
        ),
        child: isCollapsed ? const SizedBox.shrink() : widget.footer!,
      );

  Widget _buildMenuItem(
    ZoniSidebarItem item,
    bool isCollapsed, {
    int level = 0,
  }) {
    final bool hasChildren = item.children.isNotEmpty;
    final double leftPadding = ZoniSpacing.md + (level * ZoniSpacing.lg);

    return Column(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _handleItemTap(item),
            child: Container(
              padding: EdgeInsets.only(
                left: isCollapsed ? ZoniSpacing.sm : leftPadding,
                right: ZoniSpacing.md,
                top: ZoniSpacing.sm,
                bottom: ZoniSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: item.isSelected ? _selectedColor : null,
                borderRadius: const BorderRadius.all(
                  Radius.circular(ZoniBorderRadius.sm),
                ),
              ),
              child: Row(
                children: <Widget>[
                  if (item.icon != null)
                    Icon(
                      item.icon,
                      color: item.isSelected ? ZoniColors.primary : _iconColor,
                      size: 20,
                    ),
                  if (!isCollapsed) ...<Widget>[
                    const SizedBox(width: ZoniSpacing.md),
                    Expanded(
                      child: Text(
                        item.title,
                        style: ZoniTextStyles.bodyMedium.copyWith(
                          color:
                              item.isSelected ? ZoniColors.primary : _textColor,
                          fontWeight: item.isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.badge != null) item.badge!,
                    if (hasChildren)
                      Icon(
                        item.isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: _iconColor,
                        size: 20,
                      ),
                    if (item.trailing != null) item.trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
        if (hasChildren && item.isExpanded && !isCollapsed)
          ...item.children.map(
            (ZoniSidebarItem child) =>
                _buildMenuItem(child, isCollapsed, level: level + 1),
          ),
      ],
    );
  }
}
