import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for list tile variants.
enum ZoniListTileVariant {
  /// Default list tile variant.
  standard,

  /// Dense list tile variant.
  dense,

  /// Compact list tile variant.
  compact,
}

/// Enum for list tile sizes.
enum ZoniListTileSize {
  /// Small list tile size.
  small,

  /// Medium list tile size.
  medium,

  /// Large list tile size.
  large,
}

/// A customizable list tile widget that follows Zoni design system principles.
class ZoniListTile extends StatelessWidget {
  /// Creates a ZoniListTile.
  const ZoniListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leadingAndTrailingTextStyle,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.variant = ZoniListTileVariant.standard,
    this.size = ZoniListTileSize.medium,
    this.showDivider = false,
    this.dividerColor,
    this.dividerIndent,
    this.dividerEndIndent,
  });

  /// Creates a dense list tile.
  const ZoniListTile.dense({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leadingAndTrailingTextStyle,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.size = ZoniListTileSize.medium,
    this.showDivider = false,
    this.dividerColor,
    this.dividerIndent,
    this.dividerEndIndent,
  })  : variant = ZoniListTileVariant.dense,
        dense = true;

  /// Creates a compact list tile.
  const ZoniListTile.compact({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leadingAndTrailingTextStyle,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.size = ZoniListTileSize.small,
    this.showDivider = false,
    this.dividerColor,
    this.dividerIndent,
    this.dividerEndIndent,
  })  : variant = ZoniListTileVariant.compact,
        dense = true;

  /// A widget to display before the title.
  final Widget? leading;

  /// The primary content of the list item.
  final Widget? title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Whether this list item is intended to display three lines of text.
  final bool isThreeLine;

  /// Whether this list item is part of a vertically dense list.
  final bool? dense;

  /// Defines how compact the list item's layout will be.
  final VisualDensity? visualDensity;

  /// The shape of the list item.
  final ShapeBorder? shape;

  /// Defines the font used for the title.
  final ListTileStyle? style;

  /// The color to use when this list item is selected.
  final Color? selectedColor;

  /// The color to use for the icon.
  final Color? iconColor;

  /// The color to use for text.
  final Color? textColor;

  /// The text style for the title.
  final TextStyle? titleTextStyle;

  /// The text style for the subtitle.
  final TextStyle? subtitleTextStyle;

  /// The text style for the leading and trailing widgets.
  final TextStyle? leadingAndTrailingTextStyle;

  /// The tile's internal padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether this list item is interactive.
  final bool enabled;

  /// Called when the user taps this list item.
  final GestureTapCallback? onTap;

  /// Called when the user long-presses on this list item.
  final GestureLongPressCallback? onLongPress;

  /// Called when the focus changes.
  final ValueChanged<bool>? onFocusChange;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// If this tile is also enabled then icons and text are rendered with the same color.
  final bool selected;

  /// The color for the tile's focus indicator.
  final Color? focusColor;

  /// The color for the tile's hover indicator.
  final Color? hoverColor;

  /// The color for the tile's splash indicator.
  final Color? splashColor;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  final bool autofocus;

  /// The color for the tile's background.
  final Color? tileColor;

  /// The color for the tile's background when selected.
  final Color? selectedTileColor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  final bool? enableFeedback;

  /// The horizontal gap between the titles and the leading/trailing widgets.
  final double? horizontalTitleGap;

  /// The minimum padding on the top and bottom of the title and subtitle widgets.
  final double? minVerticalPadding;

  /// The minimum width allocated for the leading widget.
  final double? minLeadingWidth;

  /// The list tile variant.
  final ZoniListTileVariant variant;

  /// The list tile size.
  final ZoniListTileSize size;

  /// Whether to show a divider below the tile.
  final bool showDivider;

  /// The color of the divider.
  final Color? dividerColor;

  /// The indent of the divider.
  final double? dividerIndent;

  /// The end indent of the divider.
  final double? dividerEndIndent;

  @override
  Widget build(BuildContext context) {
    final Widget listTile = ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      isThreeLine: isThreeLine,
      dense: dense ?? _getDefaultDense(),
      visualDensity: visualDensity ?? _getDefaultVisualDensity(),
      shape: shape,
      style: style,
      selectedColor: selectedColor,
      iconColor: iconColor,
      textColor: textColor,
      titleTextStyle: titleTextStyle ?? _getDefaultTitleTextStyle(),
      subtitleTextStyle: subtitleTextStyle ?? _getDefaultSubtitleTextStyle(),
      leadingAndTrailingTextStyle: leadingAndTrailingTextStyle,
      contentPadding: contentPadding ?? _getDefaultContentPadding(),
      enabled: enabled,
      onTap: onTap,
      onLongPress: onLongPress,
      onFocusChange: onFocusChange,
      mouseCursor: mouseCursor,
      selected: selected,
      focusColor: focusColor,
      hoverColor: hoverColor,
      splashColor: splashColor,
      focusNode: focusNode,
      autofocus: autofocus,
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
      enableFeedback: enableFeedback,
      horizontalTitleGap: horizontalTitleGap ?? _getDefaultHorizontalTitleGap(),
      minVerticalPadding: minVerticalPadding ?? _getDefaultMinVerticalPadding(),
      minLeadingWidth: minLeadingWidth,
    );

    if (showDivider) {
      return Column(
        children: <Widget>[
          listTile,
          Divider(
            height: 1,
            thickness: 1,
            color: dividerColor ?? ZoniColors.outline,
            indent: dividerIndent,
            endIndent: dividerEndIndent,
          ),
        ],
      );
    }

    return listTile;
  }

  bool _getDefaultDense() {
    switch (variant) {
      case ZoniListTileVariant.standard:
        return false;
      case ZoniListTileVariant.dense:
      case ZoniListTileVariant.compact:
        return true;
    }
  }

  VisualDensity _getDefaultVisualDensity() {
    switch (variant) {
      case ZoniListTileVariant.standard:
        return VisualDensity.standard;
      case ZoniListTileVariant.dense:
        return VisualDensity.compact;
      case ZoniListTileVariant.compact:
        return const VisualDensity(horizontal: -4, vertical: -4);
    }
  }

  TextStyle _getDefaultTitleTextStyle() {
    switch (size) {
      case ZoniListTileSize.small:
        return ZoniTextStyles.bodySmall;
      case ZoniListTileSize.medium:
        return ZoniTextStyles.bodyMedium;
      case ZoniListTileSize.large:
        return ZoniTextStyles.bodyLarge;
    }
  }

  TextStyle _getDefaultSubtitleTextStyle() {
    switch (size) {
      case ZoniListTileSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniListTileSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniListTileSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

  EdgeInsetsGeometry _getDefaultContentPadding() {
    switch (size) {
      case ZoniListTileSize.small:
        return const EdgeInsets.symmetric(horizontal: ZoniSpacing.sm);
      case ZoniListTileSize.medium:
        return const EdgeInsets.symmetric(horizontal: ZoniSpacing.md);
      case ZoniListTileSize.large:
        return const EdgeInsets.symmetric(horizontal: ZoniSpacing.lg);
    }
  }

  double _getDefaultHorizontalTitleGap() {
    switch (size) {
      case ZoniListTileSize.small:
        return ZoniSpacing.xs;
      case ZoniListTileSize.medium:
        return ZoniSpacing.sm;
      case ZoniListTileSize.large:
        return ZoniSpacing.md;
    }
  }

  double _getDefaultMinVerticalPadding() {
    switch (size) {
      case ZoniListTileSize.small:
        return ZoniSpacing.xs;
      case ZoniListTileSize.medium:
        return ZoniSpacing.sm;
      case ZoniListTileSize.large:
        return ZoniSpacing.md;
    }
  }

}

/// A list widget that follows Zoni design system principles.
class ZoniList extends StatelessWidget {
  /// Creates a ZoniList.
  const ZoniList({
    required this.children,
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.showDividers = false,
    this.dividerColor,
    this.dividerThickness,
    this.dividerIndent,
    this.dividerEndIndent,
  });

  /// The widgets to display in the list.
  final List<Widget> children;

  /// The axis along which the scroll view scrolls.
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  final bool reverse;

  /// An object that can be used to control the position to which this scroll view is scrolled.
  final ScrollController? controller;

  /// Whether this is the primary scroll view associated with the parent.
  final bool? primary;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view in the scrollDirection should be determined by the contents being viewed.
  final bool shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// If non-null, forces the children to have the given extent in the scroll direction.
  final double? itemExtent;

  /// If non-null, forces the children to have the same extent as the given widget in the scroll direction.
  final Widget? prototypeItem;

  /// Whether to wrap each child in an AutomaticKeepAlive.
  final bool addAutomaticKeepAlives;

  /// Whether to wrap each child in a RepaintBoundary.
  final bool addRepaintBoundaries;

  /// Whether to wrap each child in an IndexedSemantics.
  final bool addSemanticIndexes;

  /// The viewport has an area before and after the visible area to cache items that are about to become visible when the user scrolls.
  final double? cacheExtent;

  /// The number of children that will contribute semantic information.
  final int? semanticChildCount;

  /// Determines the way that drag start behavior is handled.
  final DragStartBehavior dragStartBehavior;

  /// Defines how this ScrollView will dismiss the on-screen keyboard automatically.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// Restoration ID to save and restore the scroll offset of the scrollable.
  final String? restorationId;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// Whether to show dividers between list items.
  final bool showDividers;

  /// The color of the dividers.
  final Color? dividerColor;

  /// The thickness of the dividers.
  final double? dividerThickness;

  /// The indent of the dividers.
  final double? dividerIndent;

  /// The end indent of the dividers.
  final double? dividerEndIndent;

  @override
  Widget build(BuildContext context) {
    if (showDividers) {
      final List<Widget> dividedChildren = <Widget>[];
      for (int i = 0; i < children.length; i++) {
        dividedChildren.add(children[i]);
        if (i < children.length - 1) {
          dividedChildren.add(
            Divider(
              height: dividerThickness ?? 1,
              thickness: dividerThickness ?? 1,
              color: dividerColor ?? ZoniColors.outline,
              indent: dividerIndent,
              endIndent: dividerEndIndent,
            ),
          );
        }
      }

      return ListView(
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemExtent: itemExtent,
        prototypeItem: prototypeItem,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
        children: dividedChildren,
      );
    }

    return ListView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      children: children,
    );
  }

}
