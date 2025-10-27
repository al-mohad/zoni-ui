import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Enum for table size variants.
enum ZoniTableSize {
  small,
  medium,
  large,
}

/// Enum for table visual variants.
enum ZoniTableVariant {
  default_,
  striped,
  bordered,
  borderless,
  hover,
}

/// Enum for sort direction.
enum ZoniTableSortDirection {
  ascending,
  descending,
}

/// Configuration for a table column.
class ZoniTableColumn {
  const ZoniTableColumn({
    required this.key,
    required this.label,
    this.width,
    this.sortable = false,
    this.alignment = Alignment.centerLeft,
    this.cellBuilder,
  });

  /// Unique key for the column.
  final String key;

  /// Display label for the column header.
  final String label;

  /// Fixed width for the column.
  final double? width;

  /// Whether this column can be sorted.
  final bool sortable;

  /// Alignment for the column content.
  final Alignment alignment;

  /// Custom builder for cell content.
  final Widget Function(dynamic value, int rowIndex)? cellBuilder;
}

/// Data for a table row.
class ZoniTableRow {
  const ZoniTableRow({
    required this.cells,
    this.key,
    this.color,
    this.onTap,
    this.data,
  });

  /// Cell data for this row.
  final Map<String, dynamic> cells;

  /// Optional unique key for the row.
  final String? key;

  /// Optional background color for the row.
  final Color? color;

  /// Callback when the row is tapped.
  final VoidCallback? onTap;

  /// Additional data associated with this row.
  final dynamic data;
}

/// A comprehensive data table widget with sorting, selection, and customization options.
class ZoniTable extends StatefulWidget {
  const ZoniTable({
    super.key,
    required this.columns,
    required this.rows,
    this.size = ZoniTableSize.medium,
    this.variant = ZoniTableVariant.default_,
    this.showHeader = true,
    this.selectable = false,
    this.multiSelect = false,
    this.onSort,
    this.sortColumnKey,
    this.sortDirection,
    this.onRowSelect,
    this.onRowsSelect,
    this.selectedRows = const {},
    this.emptyMessage = 'No data available',
    this.headerStyle,
    this.cellStyle,
    this.borderColor,
    this.headerColor,
    this.selectedRowColor,
    this.hoverColor,
    this.alternateRowColor,
    this.showBorder = true,
    this.showAlternateRows = false,
    this.enableHover = true,
    this.horizontalPadding,
    this.verticalPadding,
    this.headerHeight,
    this.rowHeight,
    this.scrollable = true,
    this.fixedHeader = false,
    this.maxHeight,
    this.minWidth,
    this.columnSpacing,
    this.sortAscendingIcon,
    this.sortDescendingIcon,
    this.checkboxColumn = false,
    this.actions,
    this.footer,
  });

  /// List of column configurations.
  final List<ZoniTableColumn> columns;

  /// List of row data.
  final List<ZoniTableRow> rows;

  /// Size variant of the table.
  final ZoniTableSize size;

  /// Visual variant of the table.
  final ZoniTableVariant variant;

  /// Whether to show the header row.
  final bool showHeader;

  /// Whether rows can be selected.
  final bool selectable;

  /// Whether multiple rows can be selected.
  final bool multiSelect;

  /// Callback when a column header is tapped for sorting.
  final void Function(String columnKey, ZoniTableSortDirection direction)? onSort;

  /// Currently sorted column key.
  final String? sortColumnKey;

  /// Current sort direction.
  final ZoniTableSortDirection? sortDirection;

  /// Callback when a row selection changes.
  final void Function(String? rowKey, bool selected)? onRowSelect;

  /// Callback when multiple row selections change.
  final void Function(Set<String> selectedRowKeys)? onRowsSelect;

  /// Set of currently selected row keys.
  final Set<String> selectedRows;

  /// Message to show when there are no rows.
  final String emptyMessage;

  /// Text style for header cells.
  final TextStyle? headerStyle;

  /// Text style for data cells.
  final TextStyle? cellStyle;

  /// Color for table borders.
  final Color? borderColor;

  /// Background color for header row.
  final Color? headerColor;

  /// Background color for selected rows.
  final Color? selectedRowColor;

  /// Background color for hovered rows.
  final Color? hoverColor;

  /// Background color for alternate rows.
  final Color? alternateRowColor;

  /// Whether to show table borders.
  final bool showBorder;

  /// Whether to show alternate row colors.
  final bool showAlternateRows;

  /// Whether to enable row hover effects.
  final bool enableHover;

  /// Horizontal padding for cells.
  final double? horizontalPadding;

  /// Vertical padding for cells.
  final double? verticalPadding;

  /// Height of the header row.
  final double? headerHeight;

  /// Height of data rows.
  final double? rowHeight;

  /// Whether the table should be scrollable.
  final bool scrollable;

  /// Whether to fix the header when scrolling.
  final bool fixedHeader;

  /// Maximum height of the table.
  final double? maxHeight;

  /// Minimum width of the table.
  final double? minWidth;

  /// Spacing between columns.
  final double? columnSpacing;

  /// Icon for ascending sort indicator.
  final Widget? sortAscendingIcon;

  /// Icon for descending sort indicator.
  final Widget? sortDescendingIcon;

  /// Whether to show a checkbox column for selection.
  final bool checkboxColumn;

  /// Action buttons to show in the table header.
  final List<Widget>? actions;

  /// Footer widget to show below the table.
  final Widget? footer;

  @override
  State<ZoniTable> createState() => _ZoniTableState();
}

class _ZoniTableState extends State<ZoniTable> {
  Set<String> _selectedRows = {};
  String? _hoveredRowKey;

  @override
  void initState() {
    super.initState();
    _selectedRows = Set.from(widget.selectedRows);
  }

  @override
  void didUpdateWidget(ZoniTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedRows != oldWidget.selectedRows) {
      _selectedRows = Set.from(widget.selectedRows);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (widget.rows.isEmpty) {
      return _buildEmptyState(theme);
    }

    Widget table = _buildTable(theme);

    if (widget.scrollable) {
      table = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.minWidth ?? 0,
          ),
          child: table,
        ),
      );

      if (widget.maxHeight != null) {
        table = SizedBox(
          height: widget.maxHeight,
          child: SingleChildScrollView(
            child: table,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.actions != null) _buildActionsBar(theme),
        Expanded(child: table),
        if (widget.footer != null) widget.footer!,
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          widget.emptyMessage,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildActionsBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: widget.borderColor ?? theme.dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${widget.rows.length} items',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ...widget.actions!,
        ],
      ),
    );
  }

  Widget _buildTable(ThemeData theme) {
    return Table(
      border: widget.showBorder
          ? TableBorder.all(
              color: widget.borderColor ?? theme.dividerColor,
              width: 1.0,
            )
          : null,
      columnWidths: _buildColumnWidths(),
      children: [
        if (widget.showHeader) _buildHeaderRow(theme),
        ...widget.rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          return _buildDataRow(theme, row, index);
        }),
      ],
    );
  }

  Map<int, TableColumnWidth> _buildColumnWidths() {
    final Map<int, TableColumnWidth> widths = {};
    
    int columnIndex = 0;
    
    if (widget.checkboxColumn) {
      widths[columnIndex] = const FixedColumnWidth(48.0);
      columnIndex++;
    }

    for (final column in widget.columns) {
      if (column.width != null) {
        widths[columnIndex] = FixedColumnWidth(column.width!);
      }
      columnIndex++;
    }

    return widths;
  }

  TableRow _buildHeaderRow(ThemeData theme) {
    final List<Widget> cells = [];

    if (widget.checkboxColumn) {
      cells.add(_buildSelectAllCheckbox(theme));
    }

    for (final column in widget.columns) {
      cells.add(_buildHeaderCell(theme, column));
    }

    return TableRow(
      decoration: BoxDecoration(
        color: widget.headerColor ?? theme.colorScheme.surfaceVariant,
      ),
      children: cells,
    );
  }

  Widget _buildSelectAllCheckbox(ThemeData theme) {
    final bool allSelected = widget.rows.isNotEmpty &&
        widget.rows.every((row) => _selectedRows.contains(row.key ?? widget.rows.indexOf(row).toString()));
    final bool someSelected = _selectedRows.isNotEmpty && !allSelected;

    return Container(
      height: widget.headerHeight ?? _getHeaderHeight(),
      alignment: Alignment.center,
      child: Checkbox(
        value: allSelected,
        tristate: true,
        onChanged: widget.multiSelect ? (value) => _selectAllRows(value ?? false) : null,
      ),
    );
  }

  Widget _buildHeaderCell(ThemeData theme, ZoniTableColumn column) {
    final bool isSorted = widget.sortColumnKey == column.key;
    final bool isAscending = widget.sortDirection == ZoniTableSortDirection.ascending;

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            column.label,
            style: widget.headerStyle ?? theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (column.sortable) ...[
          const SizedBox(width: 4),
          if (isSorted)
            isAscending
                ? (widget.sortAscendingIcon ?? const Icon(Icons.arrow_upward, size: 16))
                : (widget.sortDescendingIcon ?? const Icon(Icons.arrow_downward, size: 16))
          else
            const Icon(Icons.unfold_more, size: 16),
        ],
      ],
    );

    if (column.sortable && widget.onSort != null) {
      content = InkWell(
        onTap: () => _handleSort(column.key),
        child: content,
      );
    }

    return Container(
      height: widget.headerHeight ?? _getHeaderHeight(),
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding ?? _getHorizontalPadding(),
        vertical: widget.verticalPadding ?? _getVerticalPadding(),
      ),
      alignment: column.alignment,
      child: content,
    );
  }

  TableRow _buildDataRow(ThemeData theme, ZoniTableRow row, int index) {
    final String rowKey = row.key ?? index.toString();
    final bool isSelected = _selectedRows.contains(rowKey);
    final bool isHovered = _hoveredRowKey == rowKey;

    final List<Widget> cells = [];

    if (widget.checkboxColumn) {
      cells.add(_buildRowCheckbox(theme, rowKey, isSelected));
    }

    for (final column in widget.columns) {
      cells.add(_buildDataCell(theme, column, row, index));
    }

    if (widget.enableHover || row.onTap != null) {
      return TableRow(
        decoration: BoxDecoration(
          color: _getRowColor(row, index),
        ),
        children: cells.map((cell) {
          return MouseRegion(
            onEnter: widget.enableHover ? (_) => _setHoveredRow(rowKey) : null,
            onExit: widget.enableHover ? (_) => _setHoveredRow(null) : null,
            child: GestureDetector(
              onTap: row.onTap,
              child: cell,
            ),
          );
        }).toList(),
      );
    }

    return TableRow(
      decoration: BoxDecoration(
        color: _getRowColor(row, index),
      ),
      children: cells,
    );
  }

  Widget _buildRowCheckbox(ThemeData theme, String rowKey, bool isSelected) {
    return Container(
      height: widget.rowHeight ?? _getRowHeight(),
      alignment: Alignment.center,
      child: Checkbox(
        value: isSelected,
        onChanged: widget.selectable ? (value) => _selectRow(rowKey, value ?? false) : null,
      ),
    );
  }

  Widget _buildDataCell(ThemeData theme, ZoniTableColumn column, ZoniTableRow row, int index) {
    final dynamic value = row.cells[column.key];
    
    Widget content;
    if (column.cellBuilder != null) {
      content = column.cellBuilder!(value, index);
    } else {
      content = Text(
        value?.toString() ?? '',
        style: widget.cellStyle ?? theme.textTheme.bodyMedium,
      );
    }

    return Container(
      height: widget.rowHeight ?? _getRowHeight(),
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding ?? _getHorizontalPadding(),
        vertical: widget.verticalPadding ?? _getVerticalPadding(),
      ),
      alignment: column.alignment,
      child: content,
    );
  }

  Color _getRowColor(ZoniTableRow row, int index) {
    if (row.color != null) return row.color!;

    final String? rowKey = row.key ?? index.toString();
    if (_selectedRows.contains(rowKey)) {
      return widget.selectedRowColor ?? ZoniColors.primary.withValues(alpha: 0.1);
    }

    if (_hoveredRowKey == rowKey) {
      return widget.hoverColor ?? ZoniColors.surfaceVariant.withValues(alpha: 0.5);
    }

    if (widget.showAlternateRows && index.isOdd) {
      return widget.alternateRowColor ?? ZoniColors.surfaceVariant.withValues(alpha: 0.3);
    }

    return Colors.transparent;
  }

  void _handleSort(String columnKey) {
    if (widget.onSort == null) return;

    ZoniTableSortDirection direction = ZoniTableSortDirection.ascending;
    
    if (widget.sortColumnKey == columnKey) {
      direction = widget.sortDirection == ZoniTableSortDirection.ascending
          ? ZoniTableSortDirection.descending
          : ZoniTableSortDirection.ascending;
    }

    widget.onSort!(columnKey, direction);
  }

  void _selectRow(String rowKey, bool selected) {
    setState(() {
      if (selected) {
        if (widget.multiSelect) {
          _selectedRows.add(rowKey);
        } else {
          _selectedRows = {rowKey};
        }
      } else {
        _selectedRows.remove(rowKey);
      }
    });

    widget.onRowSelect?.call(rowKey, selected);
    widget.onRowsSelect?.call(_selectedRows);
  }

  void _selectAllRows(bool selected) {
    setState(() {
      if (selected) {
        _selectedRows = widget.rows
            .map((row) => row.key ?? widget.rows.indexOf(row).toString())
            .toSet();
      } else {
        _selectedRows.clear();
      }
    });

    widget.onRowsSelect?.call(_selectedRows);
  }

  void _setHoveredRow(String? rowKey) {
    setState(() {
      _hoveredRowKey = rowKey;
    });
  }

  double _getHeaderHeight() {
    switch (widget.size) {
      case ZoniTableSize.small:
        return 40.0;
      case ZoniTableSize.medium:
        return 48.0;
      case ZoniTableSize.large:
        return 56.0;
    }
  }

  double _getRowHeight() {
    switch (widget.size) {
      case ZoniTableSize.small:
        return 36.0;
      case ZoniTableSize.medium:
        return 44.0;
      case ZoniTableSize.large:
        return 52.0;
    }
  }

  double _getHorizontalPadding() {
    switch (widget.size) {
      case ZoniTableSize.small:
        return 8.0;
      case ZoniTableSize.medium:
        return 12.0;
      case ZoniTableSize.large:
        return 16.0;
    }
  }

  double _getVerticalPadding() {
    switch (widget.size) {
      case ZoniTableSize.small:
        return 4.0;
      case ZoniTableSize.medium:
        return 6.0;
      case ZoniTableSize.large:
        return 8.0;
    }
  }
}
