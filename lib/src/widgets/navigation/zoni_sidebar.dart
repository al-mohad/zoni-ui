import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Enum for sidebar position.
enum ZoniSidebarPosition {
  /// Left side of the screen.
  left,
  /// Right side of the screen.
  right,
}

/// Enum for sidebar behavior.
enum ZoniSidebarBehavior {
  /// Sidebar pushes content.
  push,
  /// Sidebar overlays content.
  overlay,
}

/// A sidebar item.
class ZoniSidebarItem {
  /// Creates a sidebar item.
  const ZoniSidebarItem({
    required this.id,
    required this.title,
    this.icon,
    this.children = const [],
    this.isExpanded = false,
    this.isSelected = false,
    this.onTap,
  });

  /// Unique identifier for the item.
  final String id;

  /// Title of the item.
  final String title;

  /// Icon for the item.
  final IconData? icon;

  /// Child items for expandable items.
  final List<ZoniSidebarItem> children;

  /// Whether the item is expanded.
  final bool isExpanded;

  /// Whether the item is selected.
  final bool isSelected;

  /// Callback when item is tapped.
  final VoidCallback? onTap;

  /// Creates a copy of this item with the given fields replaced.
  ZoniSidebarItem copyWith({
    String? id,
    String? title,
    IconData? icon,
    List<ZoniSidebarItem>? children,
    bool? isExpanded,
    bool? isSelected,
    VoidCallback? onTap,
  }) {
    return ZoniSidebarItem(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      children: children ?? this.children,
      isExpanded: isExpanded ?? this.isExpanded,
      isSelected: isSelected ?? this.isSelected,
      onTap: onTap ?? this.onTap,
    );
  }
}

/// A customizable sidebar widget.
class ZoniSidebar extends StatefulWidget {
  /// Creates a sidebar.
  const ZoniSidebar({
    super.key,
    required this.items,
    this.width = 280.0,
    this.collapsedWidth = 72.0,
    this.isCollapsed = false,
    this.position = ZoniSidebarPosition.left,
    this.behavior = ZoniSidebarBehavior.push,
    this.onToggle,
    this.onItemTap,
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

  /// List of sidebar items.
  final List<ZoniSidebarItem> items;

  /// Width of the expanded sidebar.
  final double width;

  /// Width of the collapsed sidebar.
  final double collapsedWidth;

  /// Whether the sidebar is collapsed.
  final bool isCollapsed;

  /// Position of the sidebar.
  final ZoniSidebarPosition position;

  /// Behavior of the sidebar.
  final ZoniSidebarBehavior behavior;

  /// Callback when toggle button is pressed.
  final VoidCallback? onToggle;

  /// Callback when an item is tapped.
  final void Function(ZoniSidebarItem item)? onItemTap;

  /// Background color of the sidebar.
  final Color? backgroundColor;

  /// Color for selected items.
  final Color? selectedColor;

  /// Color for hovered items.
  final Color? hoverColor;

  /// Text color.
  final Color? textColor;

  /// Icon color.
  final Color? iconColor;

  /// Divider color.
  final Color? dividerColor;

  /// Elevation of the sidebar.
  final double elevation;

  /// Border radius of the sidebar.
  final BorderRadius? borderRadius;

  /// Whether to show the toggle button.
  final bool showToggleButton;

  /// Icon for the toggle button.
  final IconData toggleIcon;

  /// Icon for collapse button.
  final IconData collapseIcon;

  /// Icon for expand button.
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
    _widthAnimation = Tween<double>(
      begin: widget.isCollapsed ? widget.collapsedWidth : widget.width,
      end: widget.isCollapsed ? widget.collapsedWidth : widget.width,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(ZoniSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCollapsed != widget.isCollapsed) {
      _updateAnimation();
    }
    if (oldWidget.items != widget.items) {
      setState(() {
        _items = List.from(widget.items);
      });
    }
  }

  void _updateAnimation() {
    _widthAnimation = Tween<double>(
      begin: _widthAnimation.value,
      end: widget.isCollapsed ? widget.collapsedWidth : widget.width,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _backgroundColor => widget.backgroundColor ?? ZoniColors.surface;
  Color get _selectedColor => widget.selectedColor ?? ZoniColors.primary.withValues(alpha: 0.1);
  Color get _hoverColor => widget.hoverColor ?? ZoniColors.surfaceVariant;
  Color get _textColor => widget.textColor ?? ZoniColors.onSurface;
  Color get _iconColor => widget.iconColor ?? ZoniColors.onSurfaceVariant;
  Color get _dividerColor => widget.dividerColor ?? ZoniColors.outline;

  void _handleItemTap(ZoniSidebarItem item) {
    if (item.children.isNotEmpty) {
      setState(() {
        final index = _items.indexWhere((i) => i.id == item.id);
        if (index != -1) {
          _items[index] = item.copyWith(isExpanded: !item.isExpanded);
        }
      });
    } else {
      widget.onItemTap?.call(item);
    }
  }

  Widget _buildItem(ZoniSidebarItem item, {int level = 0}) {
    final isCollapsed = widget.isCollapsed;
    final hasChildren = item.children.isNotEmpty;
    final showChildren = hasChildren && item.isExpanded && !isCollapsed;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _handleItemTap(item),
            child: Container(
              padding: EdgeInsets.only(
                left: 16.0 + (level * 16.0),
                right: 16.0,
                top: 12.0,
                bottom: 12.0,
              ),
              decoration: BoxDecoration(
                color: item.isSelected ? _selectedColor : null,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    Icon(
                      item.icon,
                      color: _iconColor,
                      size: 20.0,
                    ),
                    if (!isCollapsed) const SizedBox(width: 12.0),
                  ],
                  if (!isCollapsed) ...[
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: _textColor,
                          fontSize: 14.0,
                          fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                    if (hasChildren)
                      Icon(
                        item.isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: _iconColor,
                        size: 20.0,
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (showChildren)
          ...item.children.map((child) => _buildItem(child, level: level + 1)),
      ],
    );
  }

  Widget _buildToggleButton() {
    if (!widget.showToggleButton) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: widget.onToggle,
        icon: Icon(
          widget.isCollapsed ? widget.expandIcon : widget.collapseIcon,
          color: _iconColor,
        ),
        tooltip: widget.isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Material(
          elevation: widget.elevation,
          borderRadius: widget.borderRadius,
          child: Container(
            width: _widthAnimation.value,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: widget.borderRadius,
            ),
            child: Column(
              children: [
                _buildToggleButton(),
                if (!widget.isCollapsed)
                  Divider(
                    color: _dividerColor,
                    height: 1,
                    thickness: 1,
                  ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    children: _items.map((item) => _buildItem(item)).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
