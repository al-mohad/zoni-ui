import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// A section component for organizing content with headers and descriptions.
class ZoniSection extends StatelessWidget {
  /// Creates a section component.
  const ZoniSection({
    super.key,
    this.title,
    this.description,
    this.headerAction,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 0.0,
  });

  /// Title of the section.
  final String? title;

  /// Description text below the title.
  final String? description;

  /// Optional action widget in the header.
  final Widget? headerAction;

  /// Content of the section.
  final Widget child;

  /// Padding inside the section.
  final EdgeInsets padding;

  /// Background color of the section.
  final Color? backgroundColor;

  /// Border radius of the section.
  final double borderRadius;

  /// Whether to show a border.
  final bool showBorder;

  /// Elevation of the section.
  final double elevation;

  /// Creates a section with a card-like appearance.
  const ZoniSection.card({
    super.key,
    this.title,
    this.description,
    this.headerAction,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.backgroundColor,
    this.borderRadius = 12.0,
  })  : showBorder = true,
        elevation = 2.0;

  /// Creates a section with minimal styling.
  const ZoniSection.minimal({
    super.key,
    this.title,
    this.description,
    this.headerAction,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.borderRadius = 8.0,
  })  : showBorder = false,
        elevation = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.cardColor;

    return Material(
      color: effectiveBackgroundColor,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: showBorder
              ? Border.all(
                  color: ZoniColors.outline.withValues(alpha: 0.2),
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null || description != null || headerAction != null)
              _buildHeader(context),
            Padding(
              padding: padding,
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        padding.left,
        padding.top,
        padding.right,
        title != null && description != null ? 8.0 : padding.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || headerAction != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (headerAction != null) headerAction!,
              ],
            ),
          if (description != null) ...[
            if (title != null) const SizedBox(height: 8.0),
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A grid section for displaying items in a grid layout.
class ZoniGridSection extends StatelessWidget {
  /// Creates a grid section.
  const ZoniGridSection({
    super.key,
    this.title,
    this.description,
    this.headerAction,
    required this.children,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.padding = const EdgeInsets.all(24.0),
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 0.0,
  });

  /// Title of the section.
  final String? title;

  /// Description text below the title.
  final String? description;

  /// Optional action widget in the header.
  final Widget? headerAction;

  /// Grid items.
  final List<Widget> children;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Aspect ratio of grid items.
  final double childAspectRatio;

  /// Spacing between columns.
  final double crossAxisSpacing;

  /// Spacing between rows.
  final double mainAxisSpacing;

  /// Padding inside the section.
  final EdgeInsets padding;

  /// Background color of the section.
  final Color? backgroundColor;

  /// Border radius of the section.
  final double borderRadius;

  /// Whether to show a border.
  final bool showBorder;

  /// Elevation of the section.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return ZoniSection(
      title: title,
      description: description,
      headerAction: headerAction,
      padding: padding,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      showBorder: showBorder,
      elevation: elevation,
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        children: children,
      ),
    );
  }
}

/// A list section for displaying items in a vertical list.
class ZoniListSection extends StatelessWidget {
  /// Creates a list section.
  const ZoniListSection({
    super.key,
    this.title,
    this.description,
    this.headerAction,
    required this.children,
    this.itemSpacing = 8.0,
    this.padding = const EdgeInsets.all(24.0),
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 0.0,
  });

  /// Title of the section.
  final String? title;

  /// Description text below the title.
  final String? description;

  /// Optional action widget in the header.
  final Widget? headerAction;

  /// List items.
  final List<Widget> children;

  /// Spacing between list items.
  final double itemSpacing;

  /// Padding inside the section.
  final EdgeInsets padding;

  /// Background color of the section.
  final Color? backgroundColor;

  /// Border radius of the section.
  final double borderRadius;

  /// Whether to show a border.
  final bool showBorder;

  /// Elevation of the section.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return ZoniSection(
      title: title,
      description: description,
      headerAction: headerAction,
      padding: padding,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      showBorder: showBorder,
      elevation: elevation,
      child: Column(
        children: children
            .expand((child) => [
                  child,
                  if (child != children.last) SizedBox(height: itemSpacing),
                ])
            .toList(),
      ),
    );
  }
}
