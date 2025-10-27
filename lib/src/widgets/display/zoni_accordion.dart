import 'package:flutter/material.dart';
import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for accordion variants.
enum ZoniAccordionVariant {
  /// Standard accordion with default styling.
  standard,

  /// Outlined accordion with border.
  outlined,

  /// Filled accordion with background color.
  filled,

  /// Elevated accordion with shadow.
  elevated,
}

/// Enum for accordion size.
enum ZoniAccordionSize {
  /// Small accordion with compact spacing.
  small,

  /// Medium accordion with standard spacing.
  medium,

  /// Large accordion with generous spacing.
  large,
}

/// Represents an item in the accordion.
class ZoniAccordionItem {
  /// Creates an accordion item.
  const ZoniAccordionItem({
    required this.header,
    required this.content,
    this.key,
    this.isExpanded = false,
    this.canToggleExpansion = true,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.icon,
    this.trailing,
  });

  /// Header widget for the accordion item.
  final Widget header;

  /// Content widget for the accordion item.
  final Widget content;

  /// Unique key for the accordion item.
  final String? key;

  /// Whether the item is expanded.
  final bool isExpanded;

  /// Whether the item can be toggled.
  final bool canToggleExpansion;

  /// Background color for the item.
  final Color? backgroundColor;

  /// Background color for the header.
  final Color? headerBackgroundColor;

  /// Leading icon for the header.
  final Widget? icon;

  /// Trailing widget for the header.
  final Widget? trailing;

  /// Creates a copy of this item with updated properties.
  ZoniAccordionItem copyWith({
    Widget? header,
    Widget? content,
    String? key,
    bool? isExpanded,
    bool? canToggleExpansion,
    Color? backgroundColor,
    Color? headerBackgroundColor,
    Widget? icon,
    Widget? trailing,
  }) {
    return ZoniAccordionItem(
      header: header ?? this.header,
      content: content ?? this.content,
      key: key ?? this.key,
      isExpanded: isExpanded ?? this.isExpanded,
      canToggleExpansion: canToggleExpansion ?? this.canToggleExpansion,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      icon: icon ?? this.icon,
      trailing: trailing ?? this.trailing,
    );
  }
}

/// An expandable/collapsible content component following Zoni design system.
///
/// The [ZoniAccordion] widget provides an accordion for organizing
/// information hierarchically with expandable sections.
///
/// Example usage:
/// ```dart
/// ZoniAccordion(
///   items: [
///     ZoniAccordionItem(
///       header: Text('Section 1'),
///       content: Text('Content for section 1'),
///       isExpanded: true,
///     ),
///     ZoniAccordionItem(
///       header: Text('Section 2'),
///       content: Text('Content for section 2'),
///     ),
///   ],
/// )
/// ```
class ZoniAccordion extends StatefulWidget {
  /// Creates a Zoni accordion.
  const ZoniAccordion({
    super.key,
    required this.items,
    this.variant = ZoniAccordionVariant.standard,
    this.size = ZoniAccordionSize.medium,
    this.allowMultipleExpanded = true,
    this.onExpansionChanged,
    this.expandIcon = Icons.expand_more,
    this.collapseIcon,
    this.animationDuration = const Duration(milliseconds: 300),
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.elevation = 0.0,
    this.margin,
    this.dividerColor,
    this.showDividers = true,
  });

  /// List of accordion items.
  final List<ZoniAccordionItem> items;

  /// Visual variant of the accordion.
  final ZoniAccordionVariant variant;

  /// Size of the accordion.
  final ZoniAccordionSize size;

  /// Whether multiple items can be expanded simultaneously.
  final bool allowMultipleExpanded;

  /// Callback when an item's expansion state changes.
  final void Function(int index, bool isExpanded)? onExpansionChanged;

  /// Icon for expanding items.
  final IconData expandIcon;

  /// Icon for collapsing items (defaults to expandIcon).
  final IconData? collapseIcon;

  /// Animation duration for expand/collapse.
  final Duration animationDuration;

  /// Background color of the accordion.
  final Color? backgroundColor;

  /// Border color of the accordion.
  final Color? borderColor;

  /// Border radius of the accordion.
  final BorderRadius? borderRadius;

  /// Elevation of the accordion.
  final double elevation;

  /// Margin around the accordion.
  final EdgeInsets? margin;

  /// Color of divider lines between items.
  final Color? dividerColor;

  /// Whether to show dividers between items.
  final bool showDividers;

  @override
  State<ZoniAccordion> createState() => _ZoniAccordionState();
}

class _ZoniAccordionState extends State<ZoniAccordion> {
  late List<ZoniAccordionItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(ZoniAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _items = List.from(widget.items);
    }
  }

  EdgeInsets get _itemPadding {
    switch (widget.size) {
      case ZoniAccordionSize.small:
        return const EdgeInsets.all(ZoniSpacing.sm);
      case ZoniAccordionSize.medium:
        return const EdgeInsets.all(ZoniSpacing.md);
      case ZoniAccordionSize.large:
        return const EdgeInsets.all(ZoniSpacing.lg);
    }
  }

  EdgeInsets get _headerPadding {
    switch (widget.size) {
      case ZoniAccordionSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniAccordionSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
      case ZoniAccordionSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.xl,
          vertical: ZoniSpacing.lg,
        );
    }
  }

  EdgeInsets get _contentPadding {
    switch (widget.size) {
      case ZoniAccordionSize.small:
        return const EdgeInsets.fromLTRB(
          ZoniSpacing.md,
          0,
          ZoniSpacing.md,
          ZoniSpacing.sm,
        );
      case ZoniAccordionSize.medium:
        return const EdgeInsets.fromLTRB(
          ZoniSpacing.lg,
          0,
          ZoniSpacing.lg,
          ZoniSpacing.md,
        );
      case ZoniAccordionSize.large:
        return const EdgeInsets.fromLTRB(
          ZoniSpacing.xl,
          0,
          ZoniSpacing.xl,
          ZoniSpacing.lg,
        );
    }
  }

  Color get _backgroundColor {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    switch (widget.variant) {
      case ZoniAccordionVariant.standard:
        return Colors.transparent;
      case ZoniAccordionVariant.outlined:
        return Colors.transparent;
      case ZoniAccordionVariant.filled:
        return ZoniColors.surfaceVariant;
      case ZoniAccordionVariant.elevated:
        return ZoniColors.surface;
    }
  }

  Color get _borderColor => widget.borderColor ?? ZoniColors.outline;
  Color get _dividerColor => widget.dividerColor ?? ZoniColors.outline;

  BorderRadius get _borderRadius {
    return widget.borderRadius ??
        const BorderRadius.all(Radius.circular(ZoniBorderRadius.md));
  }

  BoxDecoration get _containerDecoration {
    switch (widget.variant) {
      case ZoniAccordionVariant.standard:
        return BoxDecoration(
          color: _backgroundColor,
          borderRadius: _borderRadius,
        );
      case ZoniAccordionVariant.outlined:
        return BoxDecoration(
          color: _backgroundColor,
          border: Border.all(color: _borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniAccordionVariant.filled:
        return BoxDecoration(
          color: _backgroundColor,
          borderRadius: _borderRadius,
        );
      case ZoniAccordionVariant.elevated:
        return BoxDecoration(
          color: _backgroundColor,
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: widget.elevation,
              offset: const Offset(0, 2),
            ),
          ],
        );
    }
  }

  void _handleExpansionChanged(int index, bool isExpanded) {
    setState(() {
      if (!widget.allowMultipleExpanded && isExpanded) {
        // Collapse all other items
        for (int i = 0; i < _items.length; i++) {
          if (i != index) {
            _items[i] = _items[i].copyWith(isExpanded: false);
          }
        }
      }
      _items[index] = _items[index].copyWith(isExpanded: isExpanded);
    });

    widget.onExpansionChanged?.call(index, isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: _containerDecoration,
      child: Column(
        children: _items.asMap().entries.map((entry) {
          final int index = entry.key;
          final ZoniAccordionItem item = entry.value;
          final bool isLast = index == _items.length - 1;

          return Column(
            children: [
              _buildAccordionItem(item, index),
              if (!isLast && widget.showDividers)
                Divider(
                  color: _dividerColor,
                  height: 1,
                  thickness: 1,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAccordionItem(ZoniAccordionItem item, int index) {
    return ExpansionTile(
      key: item.key != null ? Key(item.key!) : null,
      title: DefaultTextStyle(
        style: ZoniTextStyles.titleMedium.copyWith(
          color: ZoniColors.onSurface,
          fontWeight: FontWeight.w500,
        ),
        child: item.header,
      ),
      leading: item.icon,
      trailing: item.trailing ??
          Icon(
            item.isExpanded
                ? (widget.collapseIcon ?? widget.expandIcon)
                : widget.expandIcon,
            color: ZoniColors.onSurfaceVariant,
          ),
      initiallyExpanded: item.isExpanded,
      maintainState: true,
      backgroundColor: item.headerBackgroundColor,
      collapsedBackgroundColor: item.headerBackgroundColor,
      tilePadding: _headerPadding,
      childrenPadding: _contentPadding,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      onExpansionChanged: item.canToggleExpansion
          ? (expanded) => _handleExpansionChanged(index, expanded)
          : null,
      children: [
        Container(
          width: double.infinity,
          color: item.backgroundColor,
          child: DefaultTextStyle(
            style: ZoniTextStyles.bodyMedium.copyWith(
              color: ZoniColors.onSurface,
            ),
            child: item.content,
          ),
        ),
      ],
    );
  }
}
