import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// A filter option data model.
class ZoniFilterOption {
  /// Creates a [ZoniFilterOption].
  const ZoniFilterOption({
    required this.id,
    required this.label,
    this.icon,
    this.count,
    this.isSelected = false,
    this.color,
  });

  /// Unique identifier for the filter option.
  final String id;

  /// Display label for the filter option.
  final String label;

  /// Optional icon for the filter option.
  final IconData? icon;

  /// Optional count of items for this filter.
  final int? count;

  /// Whether this option is currently selected.
  final bool isSelected;

  /// Optional color for the filter option.
  final Color? color;

  /// Creates a copy of this filter option with the given fields replaced.
  ZoniFilterOption copyWith({
    String? id,
    String? label,
    IconData? icon,
    int? count,
    bool? isSelected,
    Color? color,
  }) {
    return ZoniFilterOption(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      count: count ?? this.count,
      isSelected: isSelected ?? this.isSelected,
      color: color ?? this.color,
    );
  }
}

/// A filter bar component for displaying and managing filter options.
class ZoniFilterBar extends StatelessWidget {
  /// Creates a [ZoniFilterBar].
  const ZoniFilterBar({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.title,
    this.showClearAll = true,
    this.showCounts = true,
    this.multiSelect = true,
    this.scrollable = true,
    this.spacing = 8.0,
    this.padding = const EdgeInsets.all(16.0),
    this.onClearAll,
  });

  /// List of filter options.
  final List<ZoniFilterOption> filters;

  /// Callback when a filter is changed.
  final void Function(ZoniFilterOption filter) onFilterChanged;

  /// Optional title for the filter bar.
  final String? title;

  /// Whether to show a clear all button.
  final bool showClearAll;

  /// Whether to show counts for each filter.
  final bool showCounts;

  /// Whether multiple filters can be selected.
  final bool multiSelect;

  /// Whether the filter bar is scrollable.
  final bool scrollable;

  /// Spacing between filter chips.
  final double spacing;

  /// Padding around the filter bar.
  final EdgeInsetsGeometry padding;

  /// Callback when clear all is pressed.
  final VoidCallback? onClearAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelectedFilters = filters.any((filter) => filter.isSelected);

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null || (showClearAll && hasSelectedFilters)) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (showClearAll && hasSelectedFilters)
                TextButton(
                  onPressed: onClearAll ?? _clearAllFilters,
                  child: const Text('Clear All'),
                ),
            ],
          ),
          SizedBox(height: ZoniSpacing.sm),
        ],
        
        _buildFilterChips(),
      ],
    );

    return Container(
      padding: padding,
      child: content,
    );
  }

  Widget _buildFilterChips() {
    if (scrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildChipWidgets(),
        ),
      );
    } else {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: _buildChipWidgets(),
      );
    }
  }

  List<Widget> _buildChipWidgets() {
    return filters.map((filter) {
      return _ZoniFilterChip(
        filter: filter,
        onTap: () => onFilterChanged(filter),
        showCount: showCounts,
      );
    }).toList();
  }

  void _clearAllFilters() {
    for (final filter in filters) {
      if (filter.isSelected) {
        onFilterChanged(filter.copyWith(isSelected: false));
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(FlagProperty('showClearAll', value: showClearAll, ifTrue: 'showClearAll'));
    properties.add(FlagProperty('showCounts', value: showCounts, ifTrue: 'showCounts'));
    properties.add(FlagProperty('multiSelect', value: multiSelect, ifTrue: 'multiSelect'));
    properties.add(FlagProperty('scrollable', value: scrollable, ifTrue: 'scrollable'));
    properties.add(DoubleProperty('spacing', spacing));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
  }
}

class _ZoniFilterChip extends StatelessWidget {
  const _ZoniFilterChip({
    required this.filter,
    required this.onTap,
    this.showCount = true,
  });

  final ZoniFilterOption filter;
  final VoidCallback onTap;
  final bool showCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final isSelected = filter.isSelected;
    final chipColor = filter.color ?? colorScheme.primary;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? chipColor
              : chipColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
          border: Border.all(
            color: isSelected
                ? chipColor
                : chipColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (filter.icon != null) ...[
              Icon(
                filter.icon,
                size: 16,
                color: isSelected
                    ? Colors.white
                    : chipColor,
              ),
              SizedBox(width: ZoniSpacing.xs),
            ],
            
            Text(
              filter.label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? Colors.white
                    : chipColor,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
            
            if (showCount && filter.count != null) ...[
              SizedBox(width: ZoniSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : chipColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${filter.count}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : chipColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A search and filter bar combination.
class ZoniSearchFilterBar extends StatefulWidget {
  /// Creates a [ZoniSearchFilterBar].
  const ZoniSearchFilterBar({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.searchHint = 'Search...',
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.showSearchBar = true,
    this.showFilterBar = true,
    this.searchController,
    this.filterTitle,
  });

  /// List of filter options.
  final List<ZoniFilterOption> filters;

  /// Callback when a filter is changed.
  final void Function(ZoniFilterOption filter) onFilterChanged;

  /// Hint text for the search bar.
  final String searchHint;

  /// Callback when search text changes.
  final void Function(String query)? onSearchChanged;

  /// Callback when search is submitted.
  final void Function(String query)? onSearchSubmitted;

  /// Whether to show the search bar.
  final bool showSearchBar;

  /// Whether to show the filter bar.
  final bool showFilterBar;

  /// Controller for the search field.
  final TextEditingController? searchController;

  /// Title for the filter section.
  final String? filterTitle;

  @override
  State<ZoniSearchFilterBar> createState() => _ZoniSearchFilterBarState();
}

class _ZoniSearchFilterBarState extends State<ZoniSearchFilterBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.searchController == null) {
      _searchController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showSearchBar) ...[
          Padding(
            padding: EdgeInsets.all(ZoniSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          widget.onSearchChanged?.call('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
                ),
                filled: true,
                fillColor: ZoniColors.surface,
              ),
              onChanged: widget.onSearchChanged,
              onSubmitted: widget.onSearchSubmitted,
            ),
          ),
        ],
        
        if (widget.showFilterBar)
          ZoniFilterBar(
            filters: widget.filters,
            onFilterChanged: widget.onFilterChanged,
            title: widget.filterTitle,
            padding: EdgeInsets.symmetric(
              horizontal: ZoniSpacing.md,
              vertical: ZoniSpacing.sm,
            ),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('searchHint', widget.searchHint));
    properties.add(FlagProperty('showSearchBar', value: widget.showSearchBar, ifTrue: 'showSearchBar'));
    properties.add(FlagProperty('showFilterBar', value: widget.showFilterBar, ifTrue: 'showFilterBar'));
    properties.add(StringProperty('filterTitle', widget.filterTitle));
  }
}
