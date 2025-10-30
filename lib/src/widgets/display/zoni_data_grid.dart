import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Column definition for data grid.
class ZoniDataGridColumn<T> {
  /// Creates a data grid column.
  const ZoniDataGridColumn({
    required this.key,
    required this.label,
    required this.valueBuilder,
    this.width,
    this.minWidth = 100.0,
    this.maxWidth,
    this.sortable = false,
    this.resizable = false,
    this.alignment = Alignment.centerLeft,
    this.headerAlignment,
    this.cellBuilder,
    this.headerBuilder,
    this.sortComparator,
  });

  /// Unique key for the column.
  final String key;

  /// Label to display in the header.
  final String label;

  /// Function to extract value from row data.
  final String Function(T data) valueBuilder;

  /// Fixed width of the column.
  final double? width;

  /// Minimum width of the column.
  final double minWidth;

  /// Maximum width of the column.
  final double? maxWidth;

  /// Whether the column is sortable.
  final bool sortable;

  /// Whether the column is resizable.
  final bool resizable;

  /// Alignment of cell content.
  final Alignment alignment;

  /// Alignment of header content.
  final Alignment? headerAlignment;

  /// Custom cell builder.
  final Widget Function(BuildContext context, T data, String value)? cellBuilder;

  /// Custom header builder.
  final Widget Function(BuildContext context, String label)? headerBuilder;

  /// Custom sort comparator.
  final int Function(T a, T b)? sortComparator;
}

/// Row selection mode for data grid.
enum ZoniDataGridSelectionMode {
  /// No selection allowed.
  none,
  /// Single row selection.
  single,
  /// Multiple row selection.
  multiple,
}

/// Advanced data grid component with sorting, filtering, and pagination.
class ZoniDataGrid<T> extends StatefulWidget {
  /// Creates a data grid.
  const ZoniDataGrid({
    super.key,
    required this.columns,
    required this.rows,
    this.selectionMode = ZoniDataGridSelectionMode.none,
    this.selectedRows = const {},
    this.onSelectionChanged,
    this.sortColumnKey,
    this.sortAscending = true,
    this.onSort,
    this.showHeader = true,
    this.showBorder = true,
    this.showRowDividers = true,
    this.showColumnDividers = true,
    this.alternateRowColors = false,
    this.headerHeight = 56.0,
    this.rowHeight = 48.0,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 12.0,
    this.borderColor,
    this.headerColor,
    this.selectedRowColor,
    this.alternateRowColor,
    this.hoverColor,
    this.emptyMessage = 'No data available',
    this.emptyWidget,
    this.loadingWidget,
    this.isLoading = false,
    this.onRowTap,
    this.onRowDoubleTap,
    this.onRowLongPress,
    this.contextMenuBuilder,
  });

  /// Column definitions for the grid.
  final List<ZoniDataGridColumn<T>> columns;

  /// Data rows to display.
  final List<T> rows;

  /// Row selection mode.
  final ZoniDataGridSelectionMode selectionMode;

  /// Currently selected rows.
  final Set<T> selectedRows;

  /// Callback when selection changes.
  final void Function(Set<T> selectedRows)? onSelectionChanged;

  /// Key of the currently sorted column.
  final String? sortColumnKey;

  /// Whether sorting is ascending.
  final bool sortAscending;

  /// Callback when column is sorted.
  final void Function(String columnKey, bool ascending)? onSort;

  /// Whether to show the header.
  final bool showHeader;

  /// Whether to show border around the grid.
  final bool showBorder;

  /// Whether to show dividers between rows.
  final bool showRowDividers;

  /// Whether to show dividers between columns.
  final bool showColumnDividers;

  /// Whether to alternate row colors.
  final bool alternateRowColors;

  /// Height of the header row.
  final double headerHeight;

  /// Height of data rows.
  final double rowHeight;

  /// Horizontal padding in cells.
  final double horizontalPadding;

  /// Vertical padding in cells.
  final double verticalPadding;

  /// Color of borders and dividers.
  final Color? borderColor;

  /// Background color of the header.
  final Color? headerColor;

  /// Background color of selected rows.
  final Color? selectedRowColor;

  /// Background color of alternate rows.
  final Color? alternateRowColor;

  /// Background color when hovering over rows.
  final Color? hoverColor;

  /// Message to show when grid is empty.
  final String emptyMessage;

  /// Custom widget to show when grid is empty.
  final Widget? emptyWidget;

  /// Custom widget to show when loading.
  final Widget? loadingWidget;

  /// Whether the grid is in loading state.
  final bool isLoading;

  /// Callback when row is tapped.
  final void Function(T row)? onRowTap;

  /// Callback when row is double tapped.
  final void Function(T row)? onRowDoubleTap;

  /// Callback when row is long pressed.
  final void Function(T row)? onRowLongPress;

  /// Builder for context menu.
  final Widget Function(BuildContext context, T row)? contextMenuBuilder;

  @override
  State<ZoniDataGrid<T>> createState() => _ZoniDataGridState<T>();
}

class _ZoniDataGridState<T> extends State<ZoniDataGrid<T>> {
  late Set<T> _selectedRows;
  T? _hoveredRow;

  @override
  void initState() {
    super.initState();
    _selectedRows = Set.from(widget.selectedRows);
  }

  @override
  void didUpdateWidget(ZoniDataGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedRows != oldWidget.selectedRows) {
      _selectedRows = Set.from(widget.selectedRows);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.isLoading) {
      return _buildLoadingState(theme);
    }

    if (widget.rows.isEmpty) {
      return _buildEmptyState(theme);
    }

    return _buildDataGrid(theme);
  }

  Widget _buildDataGrid(ThemeData theme) {
    return Container(
      decoration: widget.showBorder
          ? BoxDecoration(
              border: Border.all(
                color: widget.borderColor ?? theme.dividerColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            )
          : null,
      child: Column(
        children: [
          if (widget.showHeader) _buildHeader(theme),
          Expanded(
            child: ListView.builder(
              itemCount: widget.rows.length,
              itemBuilder: (context, index) {
                return _buildDataRow(theme, widget.rows[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      height: widget.headerHeight,
      decoration: BoxDecoration(
        color: widget.headerColor ?? theme.colorScheme.surface,
        border: widget.showRowDividers
            ? Border(
                bottom: BorderSide(
                  color: widget.borderColor ?? theme.dividerColor,
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          if (widget.selectionMode == ZoniDataGridSelectionMode.multiple)
            _buildSelectAllCheckbox(theme),
          ...widget.columns.map((column) => _buildHeaderCell(theme, column)),
        ],
      ),
    );
  }

  Widget _buildSelectAllCheckbox(ThemeData theme) {
    final allSelected = _selectedRows.length == widget.rows.length;
    final someSelected = _selectedRows.isNotEmpty && !allSelected;

    return Container(
      width: 56.0,
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: Checkbox(
        value: allSelected,
        tristate: true,
        onChanged: (value) {
          setState(() {
            if (allSelected || someSelected) {
              _selectedRows.clear();
            } else {
              _selectedRows.addAll(widget.rows);
            }
          });
          widget.onSelectionChanged?.call(_selectedRows);
        },
      ),
    );
  }

  Widget _buildHeaderCell(ThemeData theme, ZoniDataGridColumn<T> column) {
    final isCurrentSort = widget.sortColumnKey == column.key;
    
    Widget content = column.headerBuilder?.call(context, column.label) ??
        Text(
          column.label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        );

    if (column.sortable) {
      content = InkWell(
        onTap: () {
          final ascending = isCurrentSort ? !widget.sortAscending : true;
          widget.onSort?.call(column.key, ascending);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: content),
            if (isCurrentSort)
              Icon(
                widget.sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 16.0,
                color: ZoniColors.primary,
              )
            else if (column.sortable)
              Icon(
                Icons.unfold_more,
                size: 16.0,
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
              ),
          ],
        ),
      );
    }

    return Expanded(
      flex: column.width?.toInt() ?? 1,
      child: Container(
        height: widget.headerHeight,
        padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding,
        ),
        alignment: column.headerAlignment ?? column.alignment,
        decoration: widget.showColumnDividers && 
                   widget.columns.last != column
            ? BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: widget.borderColor ?? theme.dividerColor,
                    width: 1.0,
                  ),
                ),
              )
            : null,
        child: content,
      ),
    );
  }

  Widget _buildDataRow(ThemeData theme, T row, int index) {
    final isSelected = _selectedRows.contains(row);
    final isHovered = _hoveredRow == row;
    final isAlternate = widget.alternateRowColors && index % 2 == 1;

    Color? backgroundColor;
    if (isSelected) {
      backgroundColor = widget.selectedRowColor ?? 
                      ZoniColors.primary.withValues(alpha: 0.1);
    } else if (isHovered) {
      backgroundColor = widget.hoverColor ?? 
                      theme.colorScheme.onSurface.withValues(alpha: 0.04);
    } else if (isAlternate) {
      backgroundColor = widget.alternateRowColor ?? 
                      theme.colorScheme.onSurface.withValues(alpha: 0.02);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredRow = row),
      onExit: (_) => setState(() => _hoveredRow = null),
      child: GestureDetector(
        onTap: () {
          if (widget.selectionMode != ZoniDataGridSelectionMode.none) {
            _handleRowSelection(row);
          }
          widget.onRowTap?.call(row);
        },
        onDoubleTap: () => widget.onRowDoubleTap?.call(row),
        onLongPress: () => widget.onRowLongPress?.call(row),
        child: Container(
          height: widget.rowHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: widget.showRowDividers && index < widget.rows.length - 1
                ? Border(
                    bottom: BorderSide(
                      color: widget.borderColor ?? theme.dividerColor,
                      width: 1.0,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              if (widget.selectionMode != ZoniDataGridSelectionMode.none)
                _buildRowSelector(theme, row, isSelected),
              ...widget.columns.map((column) => _buildDataCell(theme, column, row)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowSelector(ThemeData theme, T row, bool isSelected) {
    return Container(
      width: 56.0,
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: widget.selectionMode == ZoniDataGridSelectionMode.multiple
          ? Checkbox(
              value: isSelected,
              onChanged: (value) => _handleRowSelection(row),
            )
          : Radio<T>(
              value: row,
              groupValue: _selectedRows.isNotEmpty ? _selectedRows.first : null,
              onChanged: (value) => _handleRowSelection(row),
            ),
    );
  }

  Widget _buildDataCell(ThemeData theme, ZoniDataGridColumn<T> column, T row) {
    final value = column.valueBuilder(row);
    
    Widget content = column.cellBuilder?.call(context, row, value) ??
        Text(
          value,
          style: theme.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        );

    return Expanded(
      flex: column.width?.toInt() ?? 1,
      child: Container(
        height: widget.rowHeight,
        padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding,
        ),
        alignment: column.alignment,
        decoration: widget.showColumnDividers && 
                   widget.columns.last != column
            ? BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: widget.borderColor ?? theme.dividerColor,
                    width: 1.0,
                  ),
                ),
              )
            : null,
        child: content,
      ),
    );
  }

  void _handleRowSelection(T row) {
    setState(() {
      if (widget.selectionMode == ZoniDataGridSelectionMode.single) {
        _selectedRows.clear();
        _selectedRows.add(row);
      } else if (widget.selectionMode == ZoniDataGridSelectionMode.multiple) {
        if (_selectedRows.contains(row)) {
          _selectedRows.remove(row);
        } else {
          _selectedRows.add(row);
        }
      }
    });
    widget.onSelectionChanged?.call(_selectedRows);
  }

  Widget _buildLoadingState(ThemeData theme) {
    return widget.loadingWidget ??
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: ZoniColors.primary),
              const SizedBox(height: 16.0),
              Text(
                'Loading data...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return widget.emptyWidget ??
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.table_chart_outlined,
                size: 64.0,
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.emptyMessage,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.textTheme.titleMedium?.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        );
  }
}
