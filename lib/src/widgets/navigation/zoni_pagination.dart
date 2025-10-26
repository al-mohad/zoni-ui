import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for pagination sizes.
enum ZoniPaginationSize {
  /// Small pagination size.
  small,

  /// Medium pagination size.
  medium,

  /// Large pagination size.
  large,
}

/// Enum for pagination variants.
enum ZoniPaginationVariant {
  /// Standard pagination with numbered pages.
  standard,

  /// Simple pagination with just previous/next.
  simple,

  /// Compact pagination with minimal UI.
  compact,
}

/// A pagination widget that follows Zoni design system principles.
class ZoniPagination extends StatelessWidget {
  /// Creates a ZoniPagination.
  const ZoniPagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    super.key,
    this.size = ZoniPaginationSize.medium,
    this.variant = ZoniPaginationVariant.standard,
    this.visiblePages = 5,
    this.showFirstLast = true,
    this.showPreviousNext = true,
    this.firstPageText = 'First',
    this.lastPageText = 'Last',
    this.previousPageText = 'Previous',
    this.nextPageText = 'Next',
    this.firstPageIcon,
    this.lastPageIcon,
    this.previousPageIcon,
    this.nextPageIcon,
    this.activeColor,
    this.inactiveColor,
    this.disabledColor,
    this.backgroundColor,
    this.borderColor,
    this.spacing,
    this.padding,
    this.itemPadding,
    this.showPageInfo = false,
    this.pageInfoText,
  });

  /// Creates a simple pagination.
  const ZoniPagination.simple({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    super.key,
    this.size = ZoniPaginationSize.medium,
    this.previousPageText = 'Previous',
    this.nextPageText = 'Next',
    this.previousPageIcon,
    this.nextPageIcon,
    this.activeColor,
    this.inactiveColor,
    this.disabledColor,
    this.backgroundColor,
    this.borderColor,
    this.spacing,
    this.padding,
    this.itemPadding,
    this.showPageInfo = true,
    this.pageInfoText,
  })  : variant = ZoniPaginationVariant.simple,
        visiblePages = 0,
        showFirstLast = false,
        showPreviousNext = true,
        firstPageText = '',
        lastPageText = '',
        firstPageIcon = null,
        lastPageIcon = null;

  /// Creates a compact pagination.
  const ZoniPagination.compact({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    super.key,
    this.size = ZoniPaginationSize.small,
    this.visiblePages = 3,
    this.showFirstLast = false,
    this.showPreviousNext = true,
    this.previousPageIcon,
    this.nextPageIcon,
    this.activeColor,
    this.inactiveColor,
    this.disabledColor,
    this.backgroundColor,
    this.borderColor,
    this.spacing,
    this.padding,
    this.itemPadding,
    this.showPageInfo = false,
  })  : variant = ZoniPaginationVariant.compact,
        firstPageText = '',
        lastPageText = '',
        previousPageText = '',
        nextPageText = '',
        firstPageIcon = null,
        lastPageIcon = null,
        pageInfoText = null;

  /// The current active page (1-based).
  final int currentPage;

  /// The total number of pages.
  final int totalPages;

  /// Callback when a page is selected.
  final ValueChanged<int> onPageChanged;

  /// The size of the pagination.
  final ZoniPaginationSize size;

  /// The variant of the pagination.
  final ZoniPaginationVariant variant;

  /// Number of page numbers to show around the current page.
  final int visiblePages;

  /// Whether to show first/last page buttons.
  final bool showFirstLast;

  /// Whether to show previous/next page buttons.
  final bool showPreviousNext;

  /// Text for the first page button.
  final String firstPageText;

  /// Text for the last page button.
  final String lastPageText;

  /// Text for the previous page button.
  final String previousPageText;

  /// Text for the next page button.
  final String nextPageText;

  /// Icon for the first page button.
  final Widget? firstPageIcon;

  /// Icon for the last page button.
  final Widget? lastPageIcon;

  /// Icon for the previous page button.
  final Widget? previousPageIcon;

  /// Icon for the next page button.
  final Widget? nextPageIcon;

  /// Color for the active page.
  final Color? activeColor;

  /// Color for inactive pages.
  final Color? inactiveColor;

  /// Color for disabled buttons.
  final Color? disabledColor;

  /// Background color for pagination items.
  final Color? backgroundColor;

  /// Border color for pagination items.
  final Color? borderColor;

  /// Spacing between pagination items.
  final double? spacing;

  /// Padding around the entire pagination.
  final EdgeInsetsGeometry? padding;

  /// Padding around individual pagination items.
  final EdgeInsetsGeometry? itemPadding;

  /// Whether to show page information text.
  final bool showPageInfo;

  /// Custom page information text. If null, shows "Page X of Y".
  final String? pageInfoText;

  @override
  Widget build(BuildContext context) {
    final Color effectiveActiveColor = activeColor ?? ZoniColors.primary;
    final Color effectiveInactiveColor = inactiveColor ?? ZoniColors.onSurface;
    final Color effectiveDisabledColor =
        disabledColor ?? ZoniColors.onSurface.withOpacity(0.3);
    final Color effectiveBackgroundColor =
        backgroundColor ?? ZoniColors.surface;
    final Color effectiveBorderColor = borderColor ?? ZoniColors.outline;
    final double effectiveSpacing = spacing ?? _getDefaultSpacing();

    final List<Widget> paginationItems = <Widget>[];

    // Add first page button
    if (showFirstLast && variant == ZoniPaginationVariant.standard) {
      paginationItems.add(
        _buildPageButton(
          text: firstPageText,
          icon: firstPageIcon,
          isActive: false,
          isDisabled: currentPage == 1,
          onTap: currentPage == 1 ? null : () => onPageChanged(1),
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          disabledColor: effectiveDisabledColor,
          backgroundColor: effectiveBackgroundColor,
          borderColor: effectiveBorderColor,
        ),
      );
      paginationItems.add(SizedBox(width: effectiveSpacing));
    }

    // Add previous page button
    if (showPreviousNext) {
      paginationItems.add(
        _buildPageButton(
          text:
              variant == ZoniPaginationVariant.compact ? '' : previousPageText,
          icon: previousPageIcon ??
              Icon(Icons.chevron_left, size: _getIconSize()),
          isActive: false,
          isDisabled: currentPage == 1,
          onTap: currentPage == 1 ? null : () => onPageChanged(currentPage - 1),
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          disabledColor: effectiveDisabledColor,
          backgroundColor: effectiveBackgroundColor,
          borderColor: effectiveBorderColor,
        ),
      );
      paginationItems.add(SizedBox(width: effectiveSpacing));
    }

    // Add page numbers (for standard and compact variants)
    if (variant != ZoniPaginationVariant.simple) {
      final List<int> pageNumbers = _calculateVisiblePages();

      for (int i = 0; i < pageNumbers.length; i++) {
        final int pageNumber = pageNumbers[i];

        if (pageNumber == -1) {
          // Ellipsis
          paginationItems.add(
            _buildEllipsis(effectiveInactiveColor),
          );
        } else {
          paginationItems.add(
            _buildPageButton(
              text: pageNumber.toString(),
              isActive: pageNumber == currentPage,
              isDisabled: false,
              onTap: () => onPageChanged(pageNumber),
              activeColor: effectiveActiveColor,
              inactiveColor: effectiveInactiveColor,
              disabledColor: effectiveDisabledColor,
              backgroundColor: effectiveBackgroundColor,
              borderColor: effectiveBorderColor,
            ),
          );
        }

        if (i < pageNumbers.length - 1) {
          paginationItems.add(SizedBox(width: effectiveSpacing));
        }
      }

      paginationItems.add(SizedBox(width: effectiveSpacing));
    }

    // Add page info for simple variant
    if (variant == ZoniPaginationVariant.simple && showPageInfo) {
      paginationItems.add(
        _buildPageInfo(effectiveInactiveColor),
      );
      paginationItems.add(SizedBox(width: effectiveSpacing));
    }

    // Add next page button
    if (showPreviousNext) {
      paginationItems.add(
        _buildPageButton(
          text: variant == ZoniPaginationVariant.compact ? '' : nextPageText,
          icon: nextPageIcon ?? Icon(Icons.chevron_right, size: _getIconSize()),
          isActive: false,
          isDisabled: currentPage == totalPages,
          onTap: currentPage == totalPages
              ? null
              : () => onPageChanged(currentPage + 1),
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          disabledColor: effectiveDisabledColor,
          backgroundColor: effectiveBackgroundColor,
          borderColor: effectiveBorderColor,
        ),
      );
      paginationItems.add(SizedBox(width: effectiveSpacing));
    }

    // Add last page button
    if (showFirstLast && variant == ZoniPaginationVariant.standard) {
      paginationItems.add(
        _buildPageButton(
          text: lastPageText,
          icon: lastPageIcon,
          isActive: false,
          isDisabled: currentPage == totalPages,
          onTap: currentPage == totalPages
              ? null
              : () => onPageChanged(totalPages),
          activeColor: effectiveActiveColor,
          inactiveColor: effectiveInactiveColor,
          disabledColor: effectiveDisabledColor,
          backgroundColor: effectiveBackgroundColor,
          borderColor: effectiveBorderColor,
        ),
      );
    }

    Widget pagination = Row(
      mainAxisSize: MainAxisSize.min,
      children: paginationItems,
    );

    if (padding != null) {
      pagination = Padding(
        padding: padding!,
        child: pagination,
      );
    }

    return pagination;
  }

  Widget _buildPageButton({
    required bool isActive,
    required bool isDisabled,
    required VoidCallback? onTap,
    required Color activeColor,
    required Color inactiveColor,
    required Color disabledColor,
    required Color backgroundColor,
    required Color borderColor,
    String? text,
    Widget? icon,
  }) {
    Color textColor;
    Color bgColor;
    Color borderClr;

    if (isDisabled) {
      textColor = disabledColor;
      bgColor = backgroundColor;
      borderClr = borderColor.withOpacity(0.3);
    } else if (isActive) {
      textColor = ZoniColors.onPrimary;
      bgColor = activeColor;
      borderClr = activeColor;
    } else {
      textColor = inactiveColor;
      bgColor = backgroundColor;
      borderClr = borderColor;
    }

    Widget content;
    if (icon != null && (text == null || text.isEmpty)) {
      content = IconTheme(
        data: IconThemeData(color: textColor),
        child: icon,
      );
    } else if (icon != null && text != null && text.isNotEmpty) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme(
            data: IconThemeData(color: textColor),
            child: icon,
          ),
          const SizedBox(width: ZoniSpacing.xs),
          Text(
            text,
            style: _getTextStyle().copyWith(color: textColor),
          ),
        ],
      );
    } else {
      content = Text(
        text ?? '',
        style: _getTextStyle().copyWith(color: textColor),
      );
    }

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: itemPadding ?? _getDefaultItemPadding(),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderClr),
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
        ),
        child: content,
      ),
    );
  }

  Widget _buildEllipsis(Color color) => Container(
        padding: itemPadding ?? _getDefaultItemPadding(),
        child: Text(
          '...',
          style: _getTextStyle().copyWith(color: color),
        ),
      );

  Widget _buildPageInfo(Color color) {
    final String text = pageInfoText ?? 'Page $currentPage of $totalPages';
    return Text(
      text,
      style: _getTextStyle().copyWith(color: color),
    );
  }

  List<int> _calculateVisiblePages() {
    if (totalPages <= visiblePages) {
      return List.generate(totalPages, (int index) => index + 1);
    }

    final List<int> pages = <int>[];
    final int halfVisible = visiblePages ~/ 2;

    int start = currentPage - halfVisible;
    int end = currentPage + halfVisible;

    if (start < 1) {
      start = 1;
      end = visiblePages;
    }

    if (end > totalPages) {
      end = totalPages;
      start = totalPages - visiblePages + 1;
    }

    // Add first page and ellipsis if needed
    if (start > 1) {
      pages.add(1);
      if (start > 2) {
        pages.add(-1); // Ellipsis
      }
    }

    // Add visible pages
    for (int i = start; i <= end; i++) {
      pages.add(i);
    }

    // Add ellipsis and last page if needed
    if (end < totalPages) {
      if (end < totalPages - 1) {
        pages.add(-1); // Ellipsis
      }
      pages.add(totalPages);
    }

    return pages;
  }

  double _getDefaultSpacing() {
    switch (size) {
      case ZoniPaginationSize.small:
        return ZoniSpacing.xs;
      case ZoniPaginationSize.medium:
        return ZoniSpacing.sm;
      case ZoniPaginationSize.large:
        return ZoniSpacing.md;
    }
  }

  EdgeInsetsGeometry _getDefaultItemPadding() {
    switch (size) {
      case ZoniPaginationSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.xs,
          vertical: ZoniSpacing.xs / 2,
        );
      case ZoniPaginationSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniPaginationSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ZoniPaginationSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniPaginationSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniPaginationSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ZoniPaginationSize.small:
        return 14;
      case ZoniPaginationSize.medium:
        return 16;
      case ZoniPaginationSize.large:
        return 18;
    }
  }

}
