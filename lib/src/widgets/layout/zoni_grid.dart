import 'package:flutter/material.dart';
import '../../constants/zoni_constants.dart';

/// Enum for grid alignment
enum ZoniGridAlignment {
  start,
  center,
  end,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

/// A responsive grid layout component following Zoni design system.
///
/// The [ZoniGrid] widget provides a flexible grid layout that adapts
/// to different screen sizes and follows the design system spacing.
///
/// Example usage:
/// ```dart
/// ZoniGrid(
///   children: [
///     ZoniGridItem(child: Card(child: Text('Item 1'))),
///     ZoniGridItem(child: Card(child: Text('Item 2'))),
///     ZoniGridItem(child: Card(child: Text('Item 3'))),
///   ],
/// )
/// ```
class ZoniGrid extends StatelessWidget {
  /// Creates a Zoni grid.
  const ZoniGrid({
    super.key,
    required this.children,
    this.columns = 12,
    this.spacing = ZoniSpacing.md,
    this.runSpacing,
    this.mainAxisAlignment = ZoniGridAlignment.start,
    this.crossAxisAlignment = ZoniGridAlignment.start,
    this.padding,
  });

  /// The grid items to display.
  final List<ZoniGridItem> children;

  /// The number of columns in the grid.
  final int columns;

  /// The spacing between grid items.
  final double spacing;

  /// The spacing between rows.
  final double? runSpacing;

  /// How the grid items should be aligned along the main axis.
  final ZoniGridAlignment mainAxisAlignment;

  /// How the grid items should be aligned along the cross axis.
  final ZoniGridAlignment crossAxisAlignment;

  /// The padding around the grid.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectiveRunSpacing = runSpacing ?? spacing;
    
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final itemWidth = (availableWidth - (spacing * (columns - 1))) / columns;
          
          final rows = <List<ZoniGridItem>>[];
          var currentRow = <ZoniGridItem>[];
          var currentRowSpan = 0;
          
          for (final item in children) {
            final itemSpan = item.span.clamp(1, columns);
            
            if (currentRowSpan + itemSpan > columns) {
              if (currentRow.isNotEmpty) {
                rows.add(currentRow);
                currentRow = <ZoniGridItem>[];
                currentRowSpan = 0;
              }
            }
            
            currentRow.add(item);
            currentRowSpan += itemSpan;
            
            if (currentRowSpan >= columns) {
              rows.add(currentRow);
              currentRow = <ZoniGridItem>[];
              currentRowSpan = 0;
            }
          }
          
          if (currentRow.isNotEmpty) {
            rows.add(currentRow);
          }
          
          return Column(
            crossAxisAlignment: _getCrossAxisAlignment(),
            children: rows.asMap().entries.map((entry) {
              final rowIndex = entry.key;
              final row = entry.value;
              
              return Padding(
                padding: EdgeInsets.only(
                  bottom: rowIndex < rows.length - 1 ? effectiveRunSpacing : 0,
                ),
                child: _buildRow(row, itemWidth),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildRow(List<ZoniGridItem> items, double itemWidth) {
    final children = <Widget>[];
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final itemSpan = item.span.clamp(1, columns);
      final width = (itemWidth * itemSpan) + (spacing * (itemSpan - 1));
      
      children.add(
        SizedBox(
          width: width,
          child: item.child,
        ),
      );
      
      if (i < items.length - 1) {
        children.add(SizedBox(width: spacing));
      }
    }
    
    return Row(
      mainAxisAlignment: _getMainAxisAlignment(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  MainAxisAlignment _getMainAxisAlignment() {
    switch (mainAxisAlignment) {
      case ZoniGridAlignment.start:
        return MainAxisAlignment.start;
      case ZoniGridAlignment.center:
        return MainAxisAlignment.center;
      case ZoniGridAlignment.end:
        return MainAxisAlignment.end;
      case ZoniGridAlignment.spaceBetween:
        return MainAxisAlignment.spaceBetween;
      case ZoniGridAlignment.spaceAround:
        return MainAxisAlignment.spaceAround;
      case ZoniGridAlignment.spaceEvenly:
        return MainAxisAlignment.spaceEvenly;
    }
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    switch (crossAxisAlignment) {
      case ZoniGridAlignment.start:
        return CrossAxisAlignment.start;
      case ZoniGridAlignment.center:
        return CrossAxisAlignment.center;
      case ZoniGridAlignment.end:
        return CrossAxisAlignment.end;
      case ZoniGridAlignment.spaceBetween:
      case ZoniGridAlignment.spaceAround:
      case ZoniGridAlignment.spaceEvenly:
        return CrossAxisAlignment.start;
    }
  }
}

/// A single item in a [ZoniGrid].
class ZoniGridItem extends StatelessWidget {
  /// Creates a grid item.
  const ZoniGridItem({
    super.key,
    required this.child,
    this.span = 1,
    this.height,
  });

  /// The widget to display in this grid item.
  final Widget child;

  /// The number of columns this item should span.
  final int span;

  /// The height of this grid item.
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return SizedBox(
        height: height,
        child: child,
      );
    }
    
    return child;
  }
}

/// A responsive grid that automatically adjusts columns based on screen size.
class ZoniResponsiveGrid extends StatelessWidget {
  /// Creates a responsive grid.
  const ZoniResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 200,
    this.spacing = ZoniSpacing.md,
    this.runSpacing,
    this.padding,
  });

  /// The grid items to display.
  final List<Widget> children;

  /// The minimum width for each grid item.
  final double minItemWidth;

  /// The spacing between grid items.
  final double spacing;

  /// The spacing between rows.
  final double? runSpacing;

  /// The padding around the grid.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectiveRunSpacing = runSpacing ?? spacing;
    
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final columns = ((availableWidth + spacing) / (minItemWidth + spacing)).floor().clamp(1, children.length);
          final itemWidth = (availableWidth - (spacing * (columns - 1))) / columns;
          
          final rows = <List<Widget>>[];
          for (int i = 0; i < children.length; i += columns) {
            final end = (i + columns).clamp(0, children.length);
            rows.add(children.sublist(i, end));
          }
          
          return Column(
            children: rows.asMap().entries.map((entry) {
              final rowIndex = entry.key;
              final row = entry.value;
              
              return Padding(
                padding: EdgeInsets.only(
                  bottom: rowIndex < rows.length - 1 ? effectiveRunSpacing : 0,
                ),
                child: Row(
                  children: row.asMap().entries.map((itemEntry) {
                    final itemIndex = itemEntry.key;
                    final item = itemEntry.value;
                    
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: itemIndex < row.length - 1 ? spacing : 0,
                        ),
                        child: item,
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

/// A masonry grid layout that arranges items in columns.
class ZoniMasonryGrid extends StatelessWidget {
  /// Creates a masonry grid.
  const ZoniMasonryGrid({
    super.key,
    required this.children,
    this.columns = 2,
    this.spacing = ZoniSpacing.md,
    this.runSpacing,
    this.padding,
  });

  /// The grid items to display.
  final List<Widget> children;

  /// The number of columns in the grid.
  final int columns;

  /// The spacing between grid items.
  final double spacing;

  /// The spacing between rows.
  final double? runSpacing;

  /// The padding around the grid.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectiveRunSpacing = runSpacing ?? spacing;
    
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(columns, (columnIndex) {
          final columnChildren = <Widget>[];
          
          for (int i = columnIndex; i < children.length; i += columns) {
            columnChildren.add(children[i]);
            if (i + columns < children.length) {
              columnChildren.add(SizedBox(height: effectiveRunSpacing));
            }
          }
          
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: columnIndex < columns - 1 ? spacing : 0,
              ),
              child: Column(
                children: columnChildren,
              ),
            ),
          );
        }),
      ),
    );
  }
}
