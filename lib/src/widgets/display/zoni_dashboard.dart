import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Dashboard layout types.
enum ZoniDashboardLayout {
  /// Grid layout with equal-sized cards.
  grid,
  /// Masonry layout with variable heights.
  masonry,
  /// List layout with full-width cards.
  list,
}

/// Dashboard widget item.
class ZoniDashboardItem {
  /// Creates a dashboard item.
  const ZoniDashboardItem({
    required this.id,
    required this.widget,
    this.title,
    this.subtitle,
    this.width = 1,
    this.height = 1,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.onLongPress,
    this.draggable = false,
    this.resizable = false,
  });

  /// Unique identifier for the item.
  final String id;

  /// Widget to display in the dashboard item.
  final Widget widget;

  /// Optional title for the item.
  final String? title;

  /// Optional subtitle for the item.
  final String? subtitle;

  /// Width in grid units (for grid layout).
  final int width;

  /// Height in grid units (for grid layout).
  final int height;

  /// Minimum width constraint.
  final double? minWidth;

  /// Minimum height constraint.
  final double? minHeight;

  /// Maximum width constraint.
  final double? maxWidth;

  /// Maximum height constraint.
  final double? maxHeight;

  /// Padding inside the item.
  final EdgeInsets? padding;

  /// Margin around the item.
  final EdgeInsets? margin;

  /// Background color of the item.
  final Color? backgroundColor;

  /// Border radius of the item.
  final double? borderRadius;

  /// Elevation of the item.
  final double? elevation;

  /// Callback when item is tapped.
  final VoidCallback? onTap;

  /// Callback when item is long pressed.
  final VoidCallback? onLongPress;

  /// Whether the item can be dragged.
  final bool draggable;

  /// Whether the item can be resized.
  final bool resizable;
}

/// Comprehensive dashboard component for displaying widgets in various layouts.
class ZoniDashboard extends StatefulWidget {
  /// Creates a dashboard.
  const ZoniDashboard({
    super.key,
    required this.items,
    this.layout = ZoniDashboardLayout.grid,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
    this.childAspectRatio = 1.0,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.scrollable = true,
    this.physics,
    this.shrinkWrap = false,
    this.onReorder,
    this.header,
    this.footer,
    this.emptyState,
    this.loadingState,
    this.errorState,
    this.isLoading = false,
    this.hasError = false,
  });

  /// Items to display in the dashboard.
  final List<ZoniDashboardItem> items;

  /// Layout type for the dashboard.
  final ZoniDashboardLayout layout;

  /// Number of columns in grid layout.
  final int crossAxisCount;

  /// Spacing between items on main axis.
  final double mainAxisSpacing;

  /// Spacing between items on cross axis.
  final double crossAxisSpacing;

  /// Aspect ratio of items in grid layout.
  final double childAspectRatio;

  /// Padding around the dashboard.
  final EdgeInsets padding;

  /// Background color of the dashboard.
  final Color? backgroundColor;

  /// Whether the dashboard is scrollable.
  final bool scrollable;

  /// Scroll physics for the dashboard.
  final ScrollPhysics? physics;

  /// Whether to shrink wrap the dashboard.
  final bool shrinkWrap;

  /// Callback when items are reordered.
  final void Function(int oldIndex, int newIndex)? onReorder;

  /// Optional header widget.
  final Widget? header;

  /// Optional footer widget.
  final Widget? footer;

  /// Widget to show when dashboard is empty.
  final Widget? emptyState;

  /// Widget to show when dashboard is loading.
  final Widget? loadingState;

  /// Widget to show when dashboard has error.
  final Widget? errorState;

  /// Whether the dashboard is in loading state.
  final bool isLoading;

  /// Whether the dashboard has error.
  final bool hasError;

  @override
  State<ZoniDashboard> createState() => _ZoniDashboardState();
}

class _ZoniDashboardState extends State<ZoniDashboard> {
  late List<ZoniDashboardItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(ZoniDashboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _items = List.from(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content;

    if (widget.isLoading) {
      content = widget.loadingState ?? _buildDefaultLoadingState(theme);
    } else if (widget.hasError) {
      content = widget.errorState ?? _buildDefaultErrorState(theme);
    } else if (_items.isEmpty) {
      content = widget.emptyState ?? _buildDefaultEmptyState(theme);
    } else {
      content = _buildDashboard(theme);
    }

    return Container(
      color: widget.backgroundColor,
      child: Column(
        children: [
          if (widget.header != null) widget.header!,
          Expanded(child: content),
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }

  Widget _buildDashboard(ThemeData theme) {
    Widget dashboard;

    switch (widget.layout) {
      case ZoniDashboardLayout.grid:
        dashboard = _buildGridLayout();
        break;
      case ZoniDashboardLayout.masonry:
        dashboard = _buildMasonryLayout();
        break;
      case ZoniDashboardLayout.list:
        dashboard = _buildListLayout();
        break;
    }

    if (widget.scrollable) {
      return SingleChildScrollView(
        padding: widget.padding,
        physics: widget.physics,
        child: dashboard,
      );
    }

    return Padding(
      padding: widget.padding,
      child: dashboard,
    );
  }

  Widget _buildGridLayout() {
    return GridView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.scrollable ? null : const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        mainAxisSpacing: widget.mainAxisSpacing,
        crossAxisSpacing: widget.crossAxisSpacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return _buildDashboardItem(_items[index], index);
      },
    );
  }

  Widget _buildMasonryLayout() {
    // Simple masonry implementation using Wrap
    return Wrap(
      spacing: widget.crossAxisSpacing,
      runSpacing: widget.mainAxisSpacing,
      children: _items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 
                 widget.padding.horizontal - 
                 (widget.crossAxisCount - 1) * widget.crossAxisSpacing) / 
                 widget.crossAxisCount,
          child: _buildDashboardItem(item, index),
        );
      }).toList(),
    );
  }

  Widget _buildListLayout() {
    return ListView.separated(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.scrollable ? null : const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      separatorBuilder: (context, index) => SizedBox(height: widget.mainAxisSpacing),
      itemBuilder: (context, index) {
        return _buildDashboardItem(_items[index], index);
      },
    );
  }

  Widget _buildDashboardItem(ZoniDashboardItem item, int index) {
    final theme = Theme.of(context);

    Widget content = item.widget;

    // Add title and subtitle if provided
    if (item.title != null || item.subtitle != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                item.title!,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (item.subtitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                item.subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
              ),
            ),
          Expanded(child: item.widget),
        ],
      );
    }

    // Apply constraints
    if (item.minWidth != null || item.maxWidth != null || 
        item.minHeight != null || item.maxHeight != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: item.minWidth ?? 0,
          maxWidth: item.maxWidth ?? double.infinity,
          minHeight: item.minHeight ?? 0,
          maxHeight: item.maxHeight ?? double.infinity,
        ),
        child: content,
      );
    }

    // Apply padding
    if (item.padding != null) {
      content = Padding(
        padding: item.padding!,
        child: content,
      );
    }

    // Wrap in Material for elevation and background
    content = Material(
      color: item.backgroundColor ?? theme.cardColor,
      elevation: item.elevation ?? 2.0,
      borderRadius: BorderRadius.circular(item.borderRadius ?? 12.0),
      child: InkWell(
        onTap: item.onTap,
        onLongPress: item.onLongPress,
        borderRadius: BorderRadius.circular(item.borderRadius ?? 12.0),
        child: Container(
          padding: item.padding ?? const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );

    // Apply margin
    if (item.margin != null) {
      content = Padding(
        padding: item.margin!,
        child: content,
      );
    }

    // Make draggable if specified
    if (item.draggable && widget.onReorder != null) {
      content = Draggable<int>(
        data: index,
        feedback: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(item.borderRadius ?? 12.0),
          child: Container(
            width: 200,
            height: 150,
            padding: const EdgeInsets.all(16.0),
            child: item.widget,
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: content,
        ),
        child: DragTarget<int>(
          onAccept: (draggedIndex) {
            if (draggedIndex != index) {
              widget.onReorder!(draggedIndex, index);
              setState(() {
                final item = _items.removeAt(draggedIndex);
                _items.insert(index, item);
              });
            }
          },
          builder: (context, candidateData, rejectedData) {
            return content;
          },
        ),
      );
    }

    return content;
  }

  Widget _buildDefaultLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ZoniColors.primary,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Loading dashboard...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultErrorState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.0,
            color: ZoniColors.error,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Error loading dashboard',
            style: theme.textTheme.titleMedium?.copyWith(
              color: ZoniColors.error,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Please try again later',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_outlined,
            size: 64.0,
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16.0),
          Text(
            'No dashboard items',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.textTheme.titleMedium?.color?.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Add items to see them here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
